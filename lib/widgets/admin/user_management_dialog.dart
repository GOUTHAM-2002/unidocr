import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/dummy/admin_mock_data.dart';
import 'package:unidoc/models/admin_models.dart';

class UserManagementDialog extends StatefulWidget {
  final Office office;

  const UserManagementDialog({
    super.key,
    required this.office,
  });

  @override
  State<UserManagementDialog> createState() => _UserManagementDialogState();
}

class _UserManagementDialogState extends State<UserManagementDialog> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<AdminUser> users = [];
  List<AdminUser> filteredUsers = [];
  String searchQuery = '';
  String activeTab = 'All';
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabChange);
    
    // Load mock users
    users = AdminMockData.getAdminUsers();
    filteredUsers = users;
  }
  
  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }
  
  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      setState(() {
        switch (_tabController.index) {
          case 0:
            activeTab = 'All';
            break;
          case 1:
            activeTab = 'active';
            break;
          case 2:
            activeTab = 'inactive';
            break;
          case 3:
            activeTab = 'pending';
            break;
        }
        _filterUsers();
      });
    }
  }
  
  void _filterUsers() {
    setState(() {
      if (activeTab == 'All' && searchQuery.isEmpty) {
        filteredUsers = users;
      } else {
        filteredUsers = users.where((user) {
          bool statusMatch = activeTab == 'All' || user.status == activeTab;
          bool searchMatch = searchQuery.isEmpty || 
              user.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              user.email.toLowerCase().contains(searchQuery.toLowerCase()) ||
              user.role.toLowerCase().contains(searchQuery.toLowerCase());
          
          return statusMatch && searchMatch;
        }).toList();
      }
    });
  }
  
  void _handleSearch(String query) {
    setState(() {
      searchQuery = query;
      _filterUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Dialog(
      insetPadding: const EdgeInsets.all(24),
      child: Container(
        width: 900,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Management',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Manage users for ${widget.office.name}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        // Handle user limits settings
                      },
                      icon: const Icon(LucideIcons.userCog),
                      label: const Text('User Limits'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(LucideIcons.x),
                      tooltip: 'Close',
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Search and actions
            Row(
              children: [
                // Search box
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: theme.colorScheme.outline.withOpacity(0.3),
                      ),
                    ),
                    child: TextField(
                      onChanged: _handleSearch,
                      decoration: InputDecoration(
                        hintText: 'Search users...',
                        prefixIcon: Icon(
                          LucideIcons.search,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Filter button
                OutlinedButton.icon(
                  onPressed: () {
                    // Show filter dialog
                  },
                  icon: const Icon(LucideIcons.filter),
                  label: const Text('Filter'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(width: 16),
                // Export button
                OutlinedButton.icon(
                  onPressed: () {
                    // Export user data
                  },
                  icon: const Icon(LucideIcons.download),
                  label: const Text('Export'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(width: 16),
                // Invite user button
                ElevatedButton.icon(
                  onPressed: () {
                    // Show invite user dialog
                    _showInviteUserDialog(context);
                  },
                  icon: const Icon(LucideIcons.userPlus),
                  label: const Text('Invite User'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Tabs
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
              ),
              child: TabBar(
                controller: _tabController,
                tabs: [
                  _buildTab(context, 'All', users.length),
                  _buildTab(context, 'Active', users.where((u) => u.status == 'active').length),
                  _buildTab(context, 'Inactive', users.where((u) => u.status == 'inactive').length),
                  _buildTab(context, 'Pending', users.where((u) => u.status == 'pending').length),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // User table
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  children: [
                    // Table header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          // User column - 40%
                          Expanded(
                            flex: 2,
                            child: Text(
                              'User',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Role column - 20%
                          Expanded(
                            child: Text(
                              'Role',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Last Active column - 20%
                          Expanded(
                            child: Text(
                              'Last Active',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Status column - 10%
                          Expanded(
                            child: Text(
                              'Status',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Actions column - 10%
                          const SizedBox(
                            width: 100,
                            child: Text(
                              'Actions',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Divider
                    const Divider(height: 1),
                    // Table content
                    Expanded(
                      child: ListView.separated(
                        itemCount: filteredUsers.length,
                        separatorBuilder: (context, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final user = filteredUsers[index];
                          return _buildUserRow(context, user);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTab(BuildContext context, String title, int count) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildUserRow(BuildContext context, AdminUser user) {
    final theme = Theme.of(context);
    
    // Get status color
    Color statusColor;
    switch (user.status) {
      case 'active':
        statusColor = Colors.green;
        break;
      case 'inactive':
        statusColor = Colors.grey;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // User column - 40%
          Expanded(
            flex: 2,
            child: Row(
              children: [
                // Avatar
                CircleAvatar(
                  radius: 20,
                  backgroundColor: _getAvatarColor(user.avatarInitials),
                  child: Text(
                    user.avatarInitials,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Name and email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: theme.textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user.email,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Role column - 20%
          Expanded(
            child: _buildRoleBadge(context, user.role),
          ),
          // Last Active column - 20%
          Expanded(
            child: Text(
              _formatTimeAgo(user.lastActive),
              style: theme.textTheme.bodyMedium,
            ),
          ),
          // Status column - 10%
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: statusColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _capitalizeFirst(user.status),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
          // Actions column - 10%
          SizedBox(
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(LucideIcons.moreHorizontal),
                  onPressed: () => _showUserActions(context, user),
                  tooltip: 'More actions',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRoleBadge(BuildContext context, String role) {
    final theme = Theme.of(context);
    
    // Get role color
    Color roleColor;
    IconData roleIcon;
    switch (role) {
      case 'Admin':
        roleColor = Colors.red;
        roleIcon = LucideIcons.shield;
        break;
      case 'Office Staff':
        roleColor = Colors.blue;
        roleIcon = LucideIcons.briefcase;
        break;
      case 'Foreman':
        roleColor = Colors.amber;
        roleIcon = LucideIcons.hardHat;
        break;
      case 'Employee':
        roleColor = Colors.green;
        roleIcon = LucideIcons.user;
        break;
      case 'Subcontractor':
        roleColor = Colors.purple;
        roleIcon = LucideIcons.hammer;
        break;
      default:
        roleColor = Colors.grey;
        roleIcon = LucideIcons.user;
    }
    
    return Row(
      children: [
        Icon(
          roleIcon,
          size: 16,
          color: roleColor,
        ),
        const SizedBox(width: 8),
        Text(
          role,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: roleColor,
          ),
        ),
      ],
    );
  }
  
  void _showUserActions(BuildContext context, AdminUser user) {
    final theme = Theme.of(context);
    
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width - 100,
        200,
        0,
        0,
      ),
      items: [
        if (user.status != 'active')
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(LucideIcons.userCheck, color: Colors.green),
              title: const Text('Activate User'),
              contentPadding: EdgeInsets.zero,
              dense: true,
              onTap: () {
                Navigator.pop(context);
                // Activate user
              },
            ),
          ),
        if (user.status == 'active')
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(LucideIcons.userX, color: Colors.grey),
              title: const Text('Deactivate User'),
              contentPadding: EdgeInsets.zero,
              dense: true,
              onTap: () {
                Navigator.pop(context);
                // Deactivate user
              },
            ),
          ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(LucideIcons.send, color: theme.colorScheme.primary),
            title: const Text('Send Reset Link'),
            contentPadding: EdgeInsets.zero,
            dense: true,
            onTap: () {
              Navigator.pop(context);
              // Send reset link
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(LucideIcons.pencil, color: theme.colorScheme.primary),
            title: const Text('Edit User'),
            contentPadding: EdgeInsets.zero,
            dense: true,
            onTap: () {
              Navigator.pop(context);
              // Edit user
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(LucideIcons.trash2, color: Colors.red),
            title: const Text('Delete User'),
            contentPadding: EdgeInsets.zero,
            dense: true,
            onTap: () {
              Navigator.pop(context);
              // Delete user
              _showDeleteConfirmation(context, user);
            },
          ),
        ),
      ],
    );
  }
  
  void _showDeleteConfirmation(BuildContext context, AdminUser user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User?'),
        content: Text('Are you sure you want to delete ${user.name}? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Delete user
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
  
  void _showInviteUserDialog(BuildContext context) {
    final theme = Theme.of(context);
    String email = '';
    String role = 'Select a role';
    
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 500,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Invite New User',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(LucideIcons.x),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Send an invitation to add a new user to the office.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Email Address',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                  hintText: 'user@example.com',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'User Role',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.outline,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(role),
                    const Icon(LucideIcons.chevronDown),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Message (Optional)',
                style: theme.textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Add a personal message to the invitation email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Send invitation
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Send Invitation'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Color _getAvatarColor(String initials) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
      Colors.amber,
    ];
    
    final index = initials.hashCode % colors.length;
    return colors[index.abs()];
  }
  
  String _formatTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
  
  String _capitalizeFirst(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }
} 