import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/user.dart';
import 'package:unidoc/services/user_service.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/dummy/user_mock_data.dart';

class UserCreateDialog extends StatefulWidget {
  final Function(User) onUserCreated;

  const UserCreateDialog({
    super.key,
    required this.onUserCreated,
  });

  @override
  State<UserCreateDialog> createState() => _UserCreateDialogState();
}

class _UserCreateDialogState extends State<UserCreateDialog> {
  final UserService _userService = UserService();
  
  // Step tracking
  int _currentStep = 0;
  final int _totalSteps = 4;
  
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  
  // User type selection (Step 1)
  String _selectedUserType = 'Employee';
  
  // Basic information (Step 2)
  final _nameController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  
  // Permissions (Step 3)
  List<UserPermission> _permissions = [];
  
  // Documents (Step 4)
  List<UserDocument> _documents = [];
  bool _documentsUploaded = false;

  @override
  void initState() {
    super.initState();
    // Initialize with default permissions for the selected user type
    _permissions = UserMockData.getDefaultPermissions(_selectedUserType);
    _documents = UserMockData.getRequiredDocuments(_selectedUserType);
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _nicknameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    super.dispose();
  }

  void _updateSelectedUserType(String userType) {
    setState(() {
      _selectedUserType = userType;
      _permissions = UserMockData.getDefaultPermissions(userType);
      _documents = UserMockData.getRequiredDocuments(userType);
    });
  }
  
  void _goToNextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
    } else {
      _createUser();
    }
  }
  
  void _goToPreviousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }
  
  Future<void> _createUser() async {
    // Validate the form first
    if (_formKey.currentState?.validate() ?? false) {
      // Create the user
      final User newUser = await _userService.createUser(
        name: _nameController.text,
        email: _emailController.text,
        role: _selectedUserType,
        phone: _phoneController.text,
        address: _address1Controller.text,
        addressLine2: _address2Controller.text,
        nickname: _nicknameController.text,
        permissions: _permissions,
        documents: _documents,
      );
      
      // Call the callback
      widget.onUserCreated(newUser);
      
      // Close the dialog
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 800,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dialog header
            _buildDialogHeader(context),
            
            // Progress indicator
            LinearProgressIndicator(
              value: (_currentStep + 1) / _totalSteps,
              backgroundColor: colorScheme.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
            ),
            
            // Dialog content
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: _buildCurrentStepContent(context),
                  ),
                ),
              ),
            ),
            
            // Dialog actions
            _buildDialogActions(context),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDialogHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create New User',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Step ${_currentStep + 1} of $_totalSteps',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Complete the form to create a new user in the system.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(LucideIcons.x),
            onPressed: () => Navigator.pop(context),
            tooltip: 'Close',
          ),
        ],
      ),
    );
  }
  
  Widget _buildCurrentStepContent(BuildContext context) {
    switch (_currentStep) {
      case 0:
        return _buildUserTypeStep(context);
      case 1:
        return _buildBasicInfoStep(context);
      case 2:
        return _buildPermissionsStep(context);
      case 3:
        return _buildDocumentsStep(context);
      default:
        return const SizedBox.shrink();
    }
  }
  
  Widget _buildUserTypeStep(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select User Type',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose the type of user you want to create. This will determine their default permissions and access levels.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        
        // User type options
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildUserTypeCard(
              context,
              'Employee',
              LucideIcons.briefcase,
              'Staff members who work for your organization',
            ),
            _buildUserTypeCard(
              context,
              'Client',
              LucideIcons.building,
              'Customers who use your services',
            ),
            _buildUserTypeCard(
              context,
              'Foreman',
              LucideIcons.hardHat,
              'Field team leaders with project oversight',
            ),
            _buildUserTypeCard(
              context,
              'Subcontractor',
              LucideIcons.truck,
              'External contractors working on projects',
            ),
            _buildUserTypeCard(
              context,
              'Supplier-Client',
              LucideIcons.package,
              'Entities that both supply and purchase services',
            ),
            _buildUserTypeCard(
              context,
              'Admin',
              LucideIcons.shield,
              'Users with full system administrative access',
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildUserTypeCard(
    BuildContext context,
    String userType,
    IconData icon,
    String description,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedUserType == userType;
    
    return InkWell(
      onTap: () => _updateSelectedUserType(userType),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 230,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: isSelected
                      ? colorScheme.primary
                      : colorScheme.surfaceVariant,
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  userType,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            if (isSelected)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    LucideIcons.checkCircle2,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBasicInfoStep(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Basic Information',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Provide the basic details for the new ${_selectedUserType.toLowerCase()}.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        
        // Form fields
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    hint: 'Enter the user\'s full name',
                    icon: LucideIcons.user,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _nicknameController,
                    label: 'Nickname (Optional)',
                    hint: 'Enter a preferred name if applicable',
                    icon: LucideIcons.userCheck,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email Address',
                    hint: 'Enter a valid email address',
                    icon: LucideIcons.mail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      } else if (!value.contains('@') || !value.contains('.')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            // Right column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    hint: 'Enter a contact phone number',
                    icon: LucideIcons.phone,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _address1Controller,
                    label: 'Address Line 1',
                    hint: 'Street address',
                    icon: LucideIcons.mapPin,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _address2Controller,
                    label: 'Address Line 2 (Optional)',
                    hint: 'Unit, apt, suite, etc.',
                    icon: LucideIcons.building2,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        
        // User type info box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                LucideIcons.info,
                color: colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Creating a $_selectedUserType',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getUserTypeDescription(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
  
  String _getUserTypeDescription() {
    switch (_selectedUserType) {
      case 'Employee':
        return 'Employees have access to internal systems related to their job function. They can view their schedules, document submissions, and service records.';
      case 'Client':
        return 'Clients can request services, view their service history, and manage their account details. They have limited access to system functions.';
      case 'Foreman':
        return 'Foremen have advanced access to scheduling, team management, and service reporting tools. They oversee field operations and coordinate teams.';
      case 'Subcontractor':
        return 'Subcontractors can access assigned jobs, submit documentation, and communicate with project managers through the system.';
      case 'Supplier-Client':
        return 'These dual-role users have access to both supplier portal features and client features for managing service relationships.';
      case 'Admin':
        return 'Administrators have full system access and can manage users, configure settings, and access all features of the application.';
      default:
        return 'This user type has standard system access based on their role.';
    }
  }
  
  Widget _buildPermissionsStep(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Group permissions by category
    final Map<String, List<UserPermission>> permissionsByCategory = {};
    for (var permission in _permissions) {
      if (!permissionsByCategory.containsKey(permission.category)) {
        permissionsByCategory[permission.category] = [];
      }
      permissionsByCategory[permission.category]!.add(permission);
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Permissions',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Manage what this ${_selectedUserType.toLowerCase()} can access in the system. The default permissions for this user type are pre-selected.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        
        // Permission groups
        ...permissionsByCategory.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      _getCategoryIcon(entry.key),
                      size: 20,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      entry.key,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              
              // Permissions for this category
              ...entry.value.map((permission) {
                return CheckboxListTile(
                  value: permission.isEnabled,
                  onChanged: (value) {
                    setState(() {
                      final index = _permissions.indexWhere((p) => p.id == permission.id);
                      if (index != -1) {
                        _permissions[index] = UserPermission(
                          id: permission.id,
                          name: permission.name,
                          category: permission.category,
                          isEnabled: value ?? false,
                        );
                      }
                    });
                  },
                  title: Text(permission.name),
                  subtitle: Text(
                    _getPermissionDescription(permission.name),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                );
              }),
              const SizedBox(height: 16),
            ],
          );
        }),
        
        // Template selector
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Permission Templates',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  DropdownButton<String>(
                    value: 'Default $_selectedUserType',
                    items: [
                      DropdownMenuItem(
                        value: 'Default $_selectedUserType',
                        child: Text('Default $_selectedUserType'),
                      ),
                      const DropdownMenuItem(
                        value: 'Minimal Access',
                        child: Text('Minimal Access'),
                      ),
                      const DropdownMenuItem(
                        value: 'Full Access',
                        child: Text('Full Access'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == 'Default $_selectedUserType') {
                        setState(() {
                          _permissions = UserMockData.getDefaultPermissions(_selectedUserType);
                        });
                      } else if (value == 'Minimal Access') {
                        setState(() {
                          // Set only bare minimum permissions
                          _permissions = _permissions.map((p) => UserPermission(
                            id: p.id,
                            name: p.name,
                            category: p.category,
                            isEnabled: p.name.contains('Own') ? true : false,
                          )).toList();
                        });
                      } else if (value == 'Full Access') {
                        setState(() {
                          // Enable all permissions
                          _permissions = _permissions.map((p) => UserPermission(
                            id: p.id,
                            name: p.name,
                            category: p.category,
                            isEnabled: true,
                          )).toList();
                        });
                      }
                    },
                    hint: const Text('Select a template'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(width: 16),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _permissions = UserMockData.getDefaultPermissions(_selectedUserType);
                      });
                    },
                    icon: const Icon(LucideIcons.refreshCcw, size: 16),
                    label: const Text('Reset to Default'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Dashboard Access':
        return LucideIcons.layout;
      case 'Schedule Management':
        return LucideIcons.calendar;
      case 'User Management':
        return LucideIcons.users;
      case 'Document Management':
        return LucideIcons.fileText;
      case 'Account Management':
        return LucideIcons.settings;
      default:
        return LucideIcons.check;
    }
  }
  
  String _getPermissionDescription(String permission) {
    // Simplified for brevity - in a real app, you would have more detailed descriptions
    if (permission.contains('View')) {
      return 'Can view but not modify this information';
    } else if (permission.contains('Edit') || permission.contains('Manage')) {
      return 'Can create, edit, and delete this information';
    } else if (permission.contains('Approve')) {
      return 'Can review and approve actions from other users';
    } else if (permission.contains('Create')) {
      return 'Can create new items but not edit existing ones';
    } else {
      return 'Standard permission for this action';
    }
  }
  
  Widget _buildDocumentsStep(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Required Documents',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'The following documents are required for this user type. You can upload them now or later.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 24),
        
        // Document list
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _documents.length,
          itemBuilder: (context, index) {
            final document = _documents[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        LucideIcons.fileText,
                        color: colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            document.name,
                            style: theme.textTheme.titleMedium,
                          ),
                          Text(
                            document.type,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (document.isRequired)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Required',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {
                        // In a real app, this would open a file picker
                        setState(() {
                          // Simulate document upload
                          _documents[index] = UserDocument(
                            id: document.id,
                            name: document.name,
                            type: document.type,
                            isRequired: document.isRequired,
                            url: 'https://example.com/dummy-document.pdf',
                            uploadedDate: DateTime.now(),
                          );
                          _documentsUploaded = true;
                        });
                      },
                      icon: const Icon(LucideIcons.upload, size: 16),
                      label: Text(document.uploadedDate != null ? 'Replace' : 'Upload'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        side: BorderSide(color: colorScheme.primary),
                      ),
                    ),
                    if (document.uploadedDate != null) ...[
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(LucideIcons.check, color: Colors.green),
                        onPressed: null,
                        tooltip: 'Uploaded',
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
        
        const SizedBox(height: 16),
        
        // Skip upload option
        if (!_documentsUploaded)
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('Skip document upload for now'),
            ),
          ),
        
        // Success message if documents uploaded
        if (_documentsUploaded)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.green.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  LucideIcons.checkCircle,
                  color: Colors.green,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Documents Uploaded Successfully',
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'All documents have been uploaded and are ready for review.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
  
  Widget _buildDialogActions(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button (hidden on first step)
          _currentStep > 0
              ? TextButton.icon(
                  onPressed: _goToPreviousStep,
                  icon: const Icon(LucideIcons.arrowLeft),
                  label: const Text('Back'),
                )
              : const SizedBox(width: 100),
          
          // Step indicator text
          Text(
            'Step ${_currentStep + 1} of $_totalSteps',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          
          // Next/Create button
          ElevatedButton.icon(
            onPressed: _goToNextStep,
            icon: _currentStep < _totalSteps - 1 
                ? const Icon(LucideIcons.arrowRight)
                : const Icon(LucideIcons.userPlus),
            label: Text(
              _currentStep < _totalSteps - 1 ? 'Next' : 'Create User',
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
} 