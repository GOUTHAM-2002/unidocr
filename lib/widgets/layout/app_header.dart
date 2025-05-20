import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unidoc/router/app_router.dart';
import 'package:unidoc/theme/app_theme.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool isMobile;
  const AppHeader({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    // Determine if the sidebar is present and visible (for mobile/desktop differentiation of leading widget)
    // This is a simplified check. A more robust way might involve a layout controller or inherited widget.
    final bool hasVisibleSidebar = !isMobile && MediaQuery.of(context).size.width > 800; 

    return AppBar(
      backgroundColor: colorScheme.surface, // Use surface color for AppBar background
      elevation: 1.0,
      shadowColor: colorScheme.outline.withOpacity(0.3),
      // Only show menu icon if there's no visible sidebar (i.e., on mobile where sidebar is in a drawer)
      automaticallyImplyLeading: !hasVisibleSidebar, 
      iconTheme: IconThemeData(color: colorScheme.onSurfaceVariant), // For drawer icon
      titleSpacing: hasVisibleSidebar ? 0 : NavigationToolbar.kMiddleSpacing, // Adjust title spacing based on leading icon
      title: hasVisibleSidebar
          ? null // No title if sidebar is visible, a logo might be in the sidebar itself
          : Text(
              'UniDoc', // Show title on mobile when sidebar is hidden
              style: textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
            ),
      actions: [
        // Search Input (Simplified)
        SizedBox(
          width: 200, // Adjust width as needed
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: TextField(
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurface),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                prefixIcon: Icon(Icons.search, color: colorScheme.onSurfaceVariant, size: 20),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                border: OutlineInputBorder(
                  borderRadius: AppRadii.mdRadius, // from theme
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppRadii.mdRadius,
                  borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                ),
              ),
              onChanged: (value) {
                // TODO: Implement search logic
                print('Search query: $value');
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Theme Toggle (Example)
        IconButton(
          icon: Icon(theme.brightness == Brightness.light ? Icons.dark_mode_outlined : Icons.light_mode_outlined, 
                     color: colorScheme.onSurfaceVariant),
          onPressed: () {
            // TODO: Implement theme toggle logic (e.g., via Riverpod provider)
            print('Toggle theme pressed');
            // This is a placeholder. Actual theme toggling requires state management.
          },
          tooltip: 'Toggle Theme',
        ),
        const SizedBox(width: 4),
        // Notifications Dropdown (Placeholder)
        IconButton(
          icon: Badge(
            label: const Text('3'), // Example badge count
            backgroundColor: colorScheme.error,
            isLabelVisible: true, // Set to false if no notifications
            child: Icon(Icons.notifications_none_rounded, color: colorScheme.onSurfaceVariant),
          ),
          onPressed: () {
            // TODO: Implement notifications dropdown/panel
            print('Notifications pressed');
            // _showNotificationsPanel(context);
          },
          tooltip: 'Notifications',
        ),
        const SizedBox(width: 4),
        // User Profile Menu (Placeholder)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: PopupMenuButton<String>(
            offset: const Offset(0, kToolbarHeight -10),
            tooltip: 'User Menu',
            onSelected: (value) {
              if (value == 'profile') {
                // context.go(RoutePaths.profile); // Example navigation
                print('Profile selected');
              } else if (value == 'settings') {
                context.go(RoutePaths.settings);
              } else if (value == 'logout') {
                context.go(RoutePaths.login); // Navigate to login page
                print('Logout selected');
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'profile',
                child: ListTile(leading: Icon(Icons.person_outline, color: colorScheme.onSurfaceVariant), title: Text('Profile', style: textTheme.bodyMedium)),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: ListTile(leading: Icon(Icons.settings_outlined, color: colorScheme.onSurfaceVariant), title: Text('Settings', style: textTheme.bodyMedium)),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<String>(
                value: 'logout',
                child: ListTile(leading: Icon(Icons.logout_outlined, color: colorScheme.error), title: Text('Logout', style: textTheme.bodyMedium?.copyWith(color: colorScheme.error))),
              ),
            ],
            shape: RoundedRectangleBorder(borderRadius: AppRadii.mdRadius),
            color: colorScheme.surface,
            child: CircleAvatar(
              backgroundColor: colorScheme.primaryContainer,
              foregroundColor: colorScheme.onPrimaryContainer,
              child: const Text('U'), // Placeholder for User Initials or Icon
              radius: 18,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// Example for Notifications Panel (can be a custom widget or dialog)
// void _showNotificationsPanel(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Notifications'),
//         content: Text('No new notifications.'), // Replace with actual notification list
//         actions: <Widget>[
//           TextButton(
//             child: Text('Close'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// } 