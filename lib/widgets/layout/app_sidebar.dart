import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart'; // Import LucideIcons
import 'package:unidoc/router/app_router.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/widgets/common/unidoc_logo.dart'; // For logo

class AppSidebar extends StatelessWidget {
  final bool isCompact;
  const AppSidebar({super.key, required this.isCompact});

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.toString();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: isCompact ? 200 : 260, // Adjust width based on compact mode
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark ? AppColors.unidocDark.withOpacity(0.5) : AppColors.sidebarBackground, // Example dark mode adaptation
        border: Border(right: BorderSide(color: AppColors.sidebarBorder, width: 1)),
        // Removed outer shadow for a flatter design, or can be themed
      ),
      child: Column(
        children: [
          SizedBox(
            height: 64, // Standard AppBar height or a bit more for padding
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    UnidocLogo(size: 32, lightColor: colorScheme.primary, darkColor: colorScheme.secondary), // Themed logo
                    const SizedBox(width: 12),
                    if (!isCompact)
                      Text(
                        'Unidoc',
                        style: AppTextStyles.h3.copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12.0),
              children: <Widget>[
                _buildSectionTitle(context, 'MENU'),
                _buildNavItem(context, LucideIcons.layoutDashboard, 'Dashboard', RoutePaths.dashboard, currentPath),
                _buildNavItem(context, LucideIcons.users, 'Customers', RoutePaths.customers, currentPath),
                _buildNavItem(context, LucideIcons.fileText, 'Agreements', RoutePaths.agreements, currentPath),
                _buildNavItem(context, LucideIcons.calendarDays, 'Schedule', RoutePaths.schedule, currentPath),
                _buildNavItem(context, LucideIcons.fileArchive, 'Documents', RoutePaths.documents, currentPath),
                _buildNavItem(context, LucideIcons.messageCircle, 'Chat', RoutePaths.chat, currentPath),
                
                const SizedBox(height: 16),
                _buildSectionTitle(context, 'MANAGEMENT'),
                _buildNavItem(context, LucideIcons.userCog, 'Users', RoutePaths.users, currentPath), // Can be User Management
                _buildNavItem(context, LucideIcons.shieldCheck, 'Admin Panel', RoutePaths.adminPanel, currentPath),
                _buildNavItem(context, LucideIcons.contact2, 'Agents', RoutePaths.agentManagement, currentPath),
                
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: AppColors.sidebarBorder),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                _buildNavItem(context, LucideIcons.settings, 'Settings', RoutePaths.settings, currentPath),
                _buildNavItem(context, LucideIcons.logOut, 'Logout', RoutePaths.login, currentPath, isLogout: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.unidocMedium.withOpacity(0.7),
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String routePath, String currentPath, {bool isLogout = false}) {
    final bool isActive = !isLogout && currentPath == routePath;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final Color activeColor = colorScheme.primary;
    final Color inactiveColor = theme.brightness == Brightness.dark 
                                ? AppColors.unidocLightGray.withOpacity(0.8)
                                : AppColors.sidebarForeground.withOpacity(0.8);
    final Color iconColor = isActive ? activeColor : inactiveColor;
    final Color textColor = isActive ? activeColor : inactiveColor;
    final Color hoverColor = colorScheme.primary.withOpacity(0.08);
    final Color activeBgColor = colorScheme.primary.withOpacity(0.12);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      child: Material(
        color: isActive ? activeBgColor : Colors.transparent,
        borderRadius: AppRadii.mdRadius,
        child: InkWell(
          onTap: () {
            if (Scaffold.of(context).isDrawerOpen) {
              Navigator.of(context).pop(); // Close drawer if it's open (mobile)
            }
            context.go(routePath);
          },
          borderRadius: AppRadii.mdRadius,
          hoverColor: hoverColor,
          splashColor: activeColor.withOpacity(0.1),
          highlightColor: activeColor.withOpacity(0.15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(icon, color: isLogout ? AppColors.unidocError : iconColor, size: 20),
                const SizedBox(width: 16),
                if (!isCompact || isActive) // Show text if not compact or if it's active
                  Expanded(
                    child: Text(
                      title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isLogout ? AppColors.unidocError : textColor,
                        fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                if (isActive) // Small active indicator dot or line
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: activeColor,
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
} 