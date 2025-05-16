import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:unidoc/router/app_router.dart';

// TODO: This entire screen is an older version and needs to be either removed
// or completely redesigned based on 'testprojects/src/pages/Dashboard.tsx' and integrated with the new MainLayout.
// The current 'dashboard_screen.dart' is the primary dashboard.

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Widget _buildDashboardCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color iconColor,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: AppRadii.lgRadius),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: textTheme.displaySmall?.copyWith(
                color: iconColor, 
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(
          begin: 0.2,
          end: 0,
          duration: 600.ms,
          curve: Curves.easeOutBack,
        );
  }

  @override
  Widget build(BuildContext context) {
    // final stats = DataService.getDashboardStats(); // Assuming this provides Map<String, dynamic>
    // Using placeholder stats for now
    final stats = {
      'totalCustomers': 123,
      'activeCustomers': 88,
      'pendingQuotes': 12,
      'totalRevenue': 56789.50,
    };
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text('Old Dashboard Page (To Be Replaced)', style: textTheme.titleLarge),
        backgroundColor: colorScheme.surfaceVariant,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stats Overview (Old Version)',
              style: textTheme.headlineSmall,
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

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
                children: [
                  _buildDashboardCard(
                    context,
                    'Total Customers',
                    stats['totalCustomers'].toString(),
                    Icons.people,
                    AppColors.unidocPrimaryBlue,
                  ),
                  _buildDashboardCard(
                    context,
                    'Active Customers',
                    stats['activeCustomers'].toString(),
                    Icons.person,
                    AppColors.unidocCyanBlue,
                  ),
                  _buildDashboardCard(
                    context,
                    'Pending Quotes',
                    stats['pendingQuotes'].toString(),
                    Icons.description,
                    AppColors.unidocSecondaryOrange,
                  ),
                  _buildDashboardCard(
                    context,
                    'Total Revenue',
                    '\$${(stats['totalRevenue'] as double?)?.toStringAsFixed(2) ?? '0.00'}',
                    Icons.attach_money,
                    AppColors.unidocSuccess,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 