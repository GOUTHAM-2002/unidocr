import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/user.dart';
import 'package:unidoc/services/user_service.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:intl/intl.dart';
import 'package:unidoc/widgets/user/user_tab_content.dart';

class UserDetailView extends StatefulWidget {
  final User user;
  final VoidCallback onClose;

  const UserDetailView({
    super.key,
    required this.user,
    required this.onClose,
  });

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final UserService _userService = UserService();
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Text(
            widget.user.name,
            style: theme.textTheme.titleLarge,
          ),
          actions: [
            IconButton(
              icon: const Icon(LucideIcons.x),
              onPressed: widget.onClose,
              tooltip: 'Close',
            ),
          ],
          elevation: 0,
          centerTitle: false,
        ),
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Employee Documents'),
              Tab(text: 'Agreements'),
              Tab(text: 'Service History'),
              Tab(text: 'Communication'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Overview Tab
                _buildOverviewTab(context),
                
                // Employee Documents Tab
                UserTabContent(
                  title: 'Employee Documents',
                  child: _buildDocumentsTab(context),
                ),
                
                // Agreements Tab
                UserTabContent(
                  title: 'Agreements',
                  child: _buildAgreementsTab(context),
                ),
                
                // Service History Tab
                UserTabContent(
                  title: 'Service History',
                  child: _buildServiceHistoryTab(context),
                ),
                
                // Communication Tab
                UserTabContent(
                  title: 'Communication',
                  child: _buildCommunicationTab(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildOverviewTab(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return UserTabContent(
      title: 'Overview',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Card
            _buildUserProfileCard(context),
            
            const SizedBox(height: 24),
            
            // User Stats
            _buildUserStats(context),
            
            const SizedBox(height: 24),
            
            // Recent Activity
            _buildRecentActivity(context),
            
            const SizedBox(height: 24),
            
            // User Actions
            _buildUserActions(context),
          ],
        ),
      ),
    );
  }
  
  Widget _buildUserProfileCard(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = widget.user;
    
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar or profile image
            CircleAvatar(
              radius: 40,
              backgroundColor: colorScheme.primaryContainer,
              child: Text(
                user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(width: 24),
            
            // User details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.name,
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: user.status == 'active' 
                              ? Colors.green.withOpacity(0.1) 
                              : Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          user.status,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: user.status == 'active' 
                                ? Colors.green 
                                : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          user.role,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(LucideIcons.mail, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        user.email,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  if (user.phone != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.phone, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          user.phone!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                  if (user.address != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(LucideIcons.mapPin, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          user.address!,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(LucideIcons.clock, size: 16, color: Colors.grey),
                      const SizedBox(width: 8),
                      Text(
                        'Last active: ${_formatDateTime(user.lastActive)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildUserStats(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = widget.user;
    
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            context,
            LucideIcons.clipboardCheck,
            '${user.completedJobs}',
            'Completed Jobs',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            LucideIcons.star,
            '${user.averageRating}/5',
            'Avg. Rating',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            LucideIcons.listTodo,
            '${user.openTasks}',
            'Open Tasks',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            context,
            LucideIcons.fileCheck,
            '${user.documentsSubmitted}',
            'Doc. Submitted',
          ),
        ),
      ],
    );
  }
  
  Widget _buildStatCard(BuildContext context, IconData icon, String value, String label) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      elevation: 0,
      color: colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: colorScheme.primary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildRecentActivity(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = widget.user;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: colorScheme.outline.withOpacity(0.1),
            ),
            itemBuilder: (context, index) {
              IconData icon;
              String title;
              String subtitle;
              String timeAgo;
              
              switch (index) {
                case 0:
                  icon = LucideIcons.clipboardCheck;
                  title = 'Completed service call';
                  subtitle = 'Service #SC-2023-108 for Global Industries';
                  timeAgo = '2 hours ago';
                  break;
                case 1:
                  icon = LucideIcons.fileCheck;
                  title = 'Document uploaded';
                  subtitle = 'Safety Training Certificate';
                  timeAgo = '1 day ago';
                  break;
                case 2:
                  icon = LucideIcons.userCheck;
                  title = 'Updated profile information';
                  subtitle = 'Contact details updated';
                  timeAgo = '2 days ago';
                  break;
                case 3:
                  icon = LucideIcons.mail;
                  title = 'Received message';
                  subtitle = 'Schedule updated for next week';
                  timeAgo = '3 days ago';
                  break;
                case 4:
                  icon = LucideIcons.fileText;
                  title = 'Agreement signed';
                  subtitle = 'Equipment Usage Policy';
                  timeAgo = '1 week ago';
                  break;
                default:
                  icon = LucideIcons.activity;
                  title = 'Activity';
                  subtitle = 'System action';
                  timeAgo = 'Some time ago';
              }
              
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(icon, color: colorScheme.primary, size: 20),
                ),
                title: Text(title),
                subtitle: Text(subtitle),
                trailing: Text(
                  timeAgo,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildUserActions(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Actions',
          style: theme.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _buildActionButton(
              context,
              LucideIcons.mail,
              'Send Message',
              () => _sendMessageToUser(context),
            ),
            _buildActionButton(
              context,
              LucideIcons.edit3,
              'Edit Profile',
              () => _editUserProfile(context),
            ),
            _buildActionButton(
              context,
              LucideIcons.key,
              'Reset Password',
              () => _resetUserPassword(context),
            ),
            widget.user.status == 'active'
                ? _buildActionButton(
                    context,
                    LucideIcons.userX,
                    'Deactivate User',
                    () => _deactivateUser(context),
                    color: Colors.red,
                  )
                : _buildActionButton(
                    context,
                    LucideIcons.userCheck,
                    'Activate User',
                    () => _activateUser(context),
                    color: Colors.green,
                  ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed, {
    Color? color,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color != null 
            ? color.withOpacity(0.1)
            : colorScheme.surfaceVariant,
        foregroundColor: color ?? colorScheme.primary,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: color != null
                ? color.withOpacity(0.2)
                : colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
  
  void _sendMessageToUser(BuildContext context) {
    // Code to handle sending a message to the user
    // This could show a dialog with a form to compose a message
  }
  
  void _editUserProfile(BuildContext context) {
    // Code to handle editing the user's profile
    // This could show a dialog with a form to edit user details
  }
  
  void _resetUserPassword(BuildContext context) {
    // Code to handle resetting the user's password
    _userService.resetPassword(widget.user.id);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password reset link has been sent to the user\'s email'),
      ),
    );
  }
  
  void _deactivateUser(BuildContext context) {
    // Code to handle deactivating the user
    _userService.deactivateUser(widget.user.id);
  }
  
  void _activateUser(BuildContext context) {
    // Code to handle activating the user
    _userService.activateUser(widget.user.id);
  }
  
  Widget _buildDocumentsTab(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = widget.user;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Required Documents',
                style: theme.textTheme.titleLarge,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Show document upload dialog
                },
                icon: const Icon(LucideIcons.uploadCloud),
                label: const Text('Upload Document'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Document Cards Grid
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: user.documents.length,
            itemBuilder: (context, index) {
              final document = user.documents[index];
              return _buildDocumentCard(context, document);
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildDocumentCard(BuildContext context, UserDocument document) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final bool isUploaded = document.uploadedDate != null;
    
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isUploaded
              ? colorScheme.primary.withOpacity(0.2)
              : colorScheme.error.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: isUploaded
                      ? colorScheme.primaryContainer
                      : colorScheme.errorContainer,
                  child: Icon(
                    isUploaded ? LucideIcons.fileCheck : LucideIcons.fileWarning,
                    color: isUploaded ? colorScheme.primary : colorScheme.error,
                    size: 20,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isUploaded
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isUploaded ? 'Uploaded' : 'Required',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isUploaded ? Colors.green : Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              document.name,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              document.type,
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const Spacer(),
            if (isUploaded) ...[
              Text(
                'Uploaded on: ${_formatDate(document.uploadedDate!)}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(LucideIcons.eye, size: 18),
                    onPressed: () {
                      // View document
                    },
                    tooltip: 'View Document',
                    color: colorScheme.primary,
                  ),
                  IconButton(
                    icon: const Icon(LucideIcons.download, size: 18),
                    onPressed: () {
                      // Download document
                    },
                    tooltip: 'Download Document',
                    color: colorScheme.primary,
                  ),
                ],
              ),
            ] else ...[
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Upload document
                  },
                  icon: const Icon(LucideIcons.upload, size: 16),
                  label: const Text('Upload Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.error.withOpacity(0.1),
                    foregroundColor: colorScheme.error,
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildAgreementsTab(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = widget.user;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Agreements',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: colorScheme.outline.withOpacity(0.1),
              ),
            ),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: user.agreements.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: colorScheme.outline.withOpacity(0.1),
              ),
              itemBuilder: (context, index) {
                final agreement = user.agreements[index];
                return ListTile(
                  title: Text(agreement.name),
                  subtitle: Text(
                    '${agreement.type} | Client: ${agreement.client}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(agreement.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          agreement.status,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _getStatusColor(agreement.status),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(agreement.date),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(LucideIcons.eye, size: 18),
                        onPressed: () {
                          // View agreement
                        },
                        tooltip: 'View Agreement',
                        color: colorScheme.primary,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildServiceHistoryTab(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = widget.user;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Service History',
                style: theme.textTheme.titleLarge,
              ),
              DropdownButton<String>(
                value: 'All Time',
                items: const [
                  DropdownMenuItem(value: 'All Time', child: Text('All Time')),
                  DropdownMenuItem(value: 'This Month', child: Text('This Month')),
                  DropdownMenuItem(value: 'This Year', child: Text('This Year')),
                ],
                onChanged: (value) {
                  // Filter service history by time period
                },
                borderRadius: BorderRadius.circular(8),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Service Record Cards
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: user.serviceHistory.length,
            itemBuilder: (context, index) {
              final serviceRecord = user.serviceHistory[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: colorScheme.outline.withOpacity(0.1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              LucideIcons.clipboardList,
                              color: colorScheme.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceRecord.serviceNumber,
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                _formatDate(serviceRecord.date),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: _getStatusColor(serviceRecord.status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              serviceRecord.status,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: _getStatusColor(serviceRecord.status),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Divider(color: colorScheme.outline.withOpacity(0.1)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Client',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  serviceRecord.clientName,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Location',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  serviceRecord.location,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        serviceRecord.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              // View service details
                            },
                            icon: const Icon(LucideIcons.fileText, size: 16),
                            label: const Text('View Report'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildCommunicationTab(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = widget.user;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Communication History',
                style: theme.textTheme.titleLarge,
              ),
              ElevatedButton.icon(
                onPressed: () => _sendMessageToUser(context),
                icon: const Icon(LucideIcons.send),
                label: const Text('Send Message'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Communication items
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: user.communications.length,
            itemBuilder: (context, index) {
              final communication = user.communications[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: colorScheme.outline.withOpacity(0.1),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: colorScheme.primaryContainer,
                            child: Icon(
                              communication.type == 'email' ? LucideIcons.mail : LucideIcons.messageSquare,
                              color: colorScheme.primary,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                communication.type == 'email' ? 'Email' : 'SMS',
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                'From: ${communication.sender}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            '${_formatDate(communication.date)} ${communication.time}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (communication.subject.isNotEmpty) ...[
                        Text(
                          'Subject: ${communication.subject}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      Text(
                        communication.content,
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (communication.type == 'email')
                            TextButton.icon(
                              onPressed: () {
                                // Reply to email
                              },
                              icon: const Icon(LucideIcons.reply, size: 16),
                              label: const Text('Reply'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
      case 'approved':
      case 'completed':
      case 'signed':
        return Colors.green;
      case 'inactive':
      case 'rejected':
      case 'cancelled':
        return Colors.red;
      case 'pending':
      case 'scheduled':
      case 'in-progress':
        return Colors.blue;
      case 'draft':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
  
  String _formatDate(DateTime date) {
    final formatter = DateFormat('MMM d, yyyy');
    return formatter.format(date);
  }
  
  String _formatDateTime(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(date);
  }
} 