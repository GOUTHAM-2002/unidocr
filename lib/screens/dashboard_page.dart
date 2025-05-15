import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/widgets/animated_gradient_background.dart';
import 'package:unidoc/widgets/animated_nav_rail.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  final List<NavigationRailDestination> _destinations = [
    const NavigationRailDestination(
      icon: Icon(Icons.dashboard_outlined),
      selectedIcon: Icon(Icons.dashboard),
      label: Text('Dashboard'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.calendar_today_outlined),
      selectedIcon: Icon(Icons.calendar_today),
      label: Text('Calendar'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.assignment_outlined),
      selectedIcon: Icon(Icons.assignment),
      label: Text('Tasks'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.message_outlined),
      selectedIcon: Icon(Icons.message),
      label: Text('Messages'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: Text('Settings'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.admin_panel_settings_outlined),
      selectedIcon: Icon(Icons.admin_panel_settings),
      label: Text('Admin Panel'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedGradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Row(
          children: [
            // Animated navigation rail
            AnimatedNavRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: _destinations,
            ),

            const VerticalDivider(
              thickness: 1,
              width: 1,
              color: Colors.white24,
            ),

            // Main content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Text(
                      'Dashboard',
                      style: Theme.of(context).textTheme.titleLarge,
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideY(
                      begin: -0.2,
                      end: 0,
                      duration: 600.ms,
                      curve: Curves.easeOutBack,
                    ),

                    const SizedBox(height: 24),

                    // Content cards
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: [
                          _buildDashboardCard(
                            'Total Tasks',
                            '24',
                            Icons.task_alt,
                            AppTheme.neonBlue,
                          ),
                          _buildDashboardCard(
                            'Upcoming Events',
                            '8',
                            Icons.event,
                            AppTheme.neonPurple,
                          ),
                          _buildDashboardCard(
                            'Messages',
                            '12',
                            Icons.message,
                            AppTheme.neonPink,
                          ),
                          _buildDashboardCard(
                            'Notifications',
                            '5',
                            Icons.notifications,
                            AppTheme.neonGreen,
                          ),
                        ],
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

  Widget _buildDashboardCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
        boxShadow: AppTheme.neonShadow(color),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48,
            color: color,
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(duration: 600.ms)
      .scale(
        begin: const Offset(0.8, 0.8),
        end: const Offset(1, 1),
        duration: 600.ms,
        curve: Curves.easeOutBack,
      );
  }
} 