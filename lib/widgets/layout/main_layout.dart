import 'package:flutter/material.dart';
import 'package:unidoc/widgets/layout/app_header.dart';
import 'package:unidoc/widgets/layout/app_sidebar.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Determine if we should show the mobile drawer or a permanent sidebar
    // For now, let's assume a desktop layout
    bool isDesktop = MediaQuery.of(context).size.width > 800; // Example breakpoint

    return Scaffold(
      appBar: isDesktop ? null : const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppHeader(), // Will be a simple AppBar for mobile
      ),
      drawer: isDesktop ? null : const Drawer(child: AppSidebar()), // Sidebar in a drawer for mobile
      body: Row(
        children: [
          if (isDesktop)
            const AppSidebar(), // Permanent sidebar for desktop
          Expanded(
            child: Column(
              children: [
                if (isDesktop)
                  const AppHeader(), // Header above content for desktop
                Expanded(
                  child: child, // Main content area
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 