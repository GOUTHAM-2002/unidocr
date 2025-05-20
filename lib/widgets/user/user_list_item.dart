import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/user.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:intl/intl.dart';

class UserListItem extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserListItem({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              // User info
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    _buildAvatar(context),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user.email,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Role
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getRoleColor(colorScheme, user.role).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    user.role,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getRoleColor(colorScheme, user.role),
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              
              // Status
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                                        Container(                      width: 8,                      height: 8,                      decoration: BoxDecoration(                        color: user.status == 'active'                             ? Colors.green                             : Colors.grey,                        shape: BoxShape.circle,                      ),                    ),                    const SizedBox(width: 6),                    Text(                      user.status,                      style: theme.textTheme.bodyMedium?.copyWith(                        color: user.status == 'active'                             ? Colors.green                             : Colors.grey,                      ),                    ),
                  ],
                ),
              ),
              
              // Last active
              Expanded(
                flex: 1,
                child: Text(
                  _formatDate(user.lastActive),
                  style: theme.textTheme.bodyMedium,
                ),
              ),
              
              // Actions
              IconButton(
                icon: const Icon(LucideIcons.moreVertical, size: 20),
                onPressed: () {
                  // Show more options
                  _showUserActionsMenu(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildAvatar(BuildContext context) {
    final theme = Theme.of(context);
    
    return CircleAvatar(
      radius: 20,
      backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.5),
      child: Text(
        user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
  
    Color _getRoleColor(ColorScheme colorScheme, String role) {    switch (role) {      case 'Employee':        return colorScheme.primary;      case 'Client':        return Colors.blue;      case 'Foreman':        return Colors.orange;      case 'Subcontractor':        return Colors.green;      case 'Supplier-Client':        return Colors.purple;      default:        return colorScheme.primary;    }  }
  
  String _formatDate(DateTime date) {
    final formatter = DateFormat('MMM d, yyyy');
    return formatter.format(date);
  }
  
  void _showUserActionsMenu(BuildContext context) {
    final theme = Theme.of(context);
    
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(LucideIcons.eye, color: theme.colorScheme.primary),
                  title: const Text('View User'),
                  onTap: () {
                    Navigator.pop(context);
                    onTap();
                  },
                ),
                ListTile(
                  leading: Icon(LucideIcons.folder, color: theme.colorScheme.primary),
                  title: const Text('View Folder'),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle view folder
                  },
                ),
                ListTile(
                  leading: Icon(LucideIcons.mail, color: theme.colorScheme.primary),
                  title: const Text('Send Message'),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle send message
                  },
                ),
                ListTile(
                  leading: Icon(LucideIcons.userCog, color: theme.colorScheme.primary),
                  title: const Text('Edit User'),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle edit user
                  },
                ),
                const Divider(),
                ListTile(
                                    leading: Icon(LucideIcons.trash2, color: Colors.red),                  title: Text('Delete User',                     style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // Handle delete user
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 