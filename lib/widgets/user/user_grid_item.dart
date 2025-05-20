import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/user.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:intl/intl.dart';

class UserGridItem extends StatelessWidget {
  final User user;
  final VoidCallback onTap;

  const UserGridItem({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
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
                  PopupMenuButton<String>(
                    icon: const Icon(LucideIcons.moreVertical, size: 20),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'view_folder',
                        child: Row(
                          children: [
                            Icon(LucideIcons.folder, size: 18),
                            SizedBox(width: 8),
                            Text('View Folder'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'message',
                        child: Row(
                          children: [
                            Icon(LucideIcons.mail, size: 18),
                            SizedBox(width: 8),
                            Text('Send Message'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(LucideIcons.edit, size: 18),
                            SizedBox(width: 8),
                            Text('Edit User'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(LucideIcons.trash2, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete User', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      // Handle menu item selection
                      switch (value) {
                        case 'view_folder':
                          // Handle view folder
                          break;
                        case 'message':
                          // Handle send message
                          break;
                        case 'edit':
                          // Handle edit user
                          break;
                        case 'delete':
                          // Handle delete user
                          break;
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Role
              Container(
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
                ),
              ),
              const SizedBox(height: 16),
              // Status and last active
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: user.status == 'active' 
                          ? Colors.green 
                          : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    user.status,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: user.status == 'active' 
                          ? Colors.green 
                          : Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    LucideIcons.clock,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(user.lastActive),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
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
      radius: 24,
      backgroundColor: theme.colorScheme.primaryContainer,
      child: Text(
        user.name.isNotEmpty ? user.name[0].toUpperCase() : 'U',
        style: TextStyle(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
  
  Color _getRoleColor(ColorScheme colorScheme, String role) {
    switch (role) {
      case 'Employee':
        return colorScheme.primary;
      case 'Client':
        return Colors.blue;
      case 'Foreman':
        return Colors.orange;
      case 'Subcontractor':
        return Colors.green;
      case 'Supplier-Client':
        return Colors.purple;
      default:
        return colorScheme.primary;
    }
  }
  
  String _formatDate(DateTime date) {
    final formatter = DateFormat('MMM d, yyyy');
    return formatter.format(date);
  }
} 