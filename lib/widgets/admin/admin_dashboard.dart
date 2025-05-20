import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/dummy/admin_mock_data.dart';
import 'package:unidoc/models/admin_models.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/widgets/admin/dashboard_metric_card.dart';
import 'package:unidoc/widgets/admin/recent_activity_item.dart';
import 'package:unidoc/widgets/admin/revenue_chart.dart';
import 'package:unidoc/widgets/admin/satisfaction_chart.dart';
import 'package:unidoc/widgets/admin/top_office_item.dart';
import 'package:unidoc/widgets/admin/completion_rate_chart.dart';
import 'package:unidoc/widgets/admin/quick_action_button.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String _timeRange = 'Last 6 months';
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final metrics = AdminMockData.getDashboardMetrics();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDashboardHeader(theme),
          const SizedBox(height: 24),
          _buildMetricsGrid(metrics, theme),
          const SizedBox(height: 32),
          _buildRevenueAndSatisfaction(theme),
          const SizedBox(height: 32),
          _buildOfficesAndActivity(theme),
          const SizedBox(height: 32),
          _buildQuickActions(theme),
          const SizedBox(height: 32),
          _buildNotificationsAndCompletionRate(theme),
        ],
      ),
    );
  }
  
  Widget _buildDashboardHeader(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Admin Dashboard',
          style: AppTextStyles.h2.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: [
            // Time range selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    _timeRange,
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    LucideIcons.chevronDown,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Refresh button
            IconButton(
              onPressed: () {},
              icon: Icon(
                LucideIcons.refreshCw,
                color: theme.colorScheme.primary,
              ),
              tooltip: 'Refresh',
            ),
            const SizedBox(width: 8),
            // Export button
            OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(LucideIcons.download, size: 18),
              label: const Text('Export'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildMetricsGrid(DashboardMetrics metrics, ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: DashboardMetricCard(
            title: 'Total Service Jobs',
            value: metrics.totalServiceJobs.toString(),
            changePercent: metrics.totalServiceJobsGrowth,
            icon: LucideIcons.clipboard,
            iconColor: Colors.blue,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: DashboardMetricCard(
            title: 'Active Operators',
            value: metrics.activeOperators.toString(),
            changePercent: metrics.activeOperatorsGrowth,
            icon: LucideIcons.userCheck,
            iconColor: Colors.green,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: DashboardMetricCard(
            title: 'Active Offices',
            value: metrics.activeOffices.toString(),
            suffix: metrics.newOffices > 0 ? '+${metrics.newOffices} new this month' : null,
            icon: LucideIcons.building,
            iconColor: Colors.indigo,
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: DashboardMetricCard(
            title: 'Total Revenue',
            value: '\$${_formatCurrency(metrics.totalRevenue)}',
            changePercent: metrics.totalRevenueGrowth,
            icon: LucideIcons.dollarSign,
            iconColor: Colors.amber,
          ),
        ),
      ],
    );
  }
  
  Widget _buildRevenueAndSatisfaction(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Revenue Overview
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Revenue Overview',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Monthly revenue across all offices',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          LucideIcons.settings,
                          size: 18,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: SizedBox(
                    height: 240,
                    child: RevenueChart(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Values displayed in thousands (\$K)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Customer Satisfaction
        Expanded(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Customer Satisfaction',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          LucideIcons.chevronDown,
                          size: 18,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text(
                    'Average satisfaction score',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: SatisfactionChart(),
                ),
                const SizedBox(height: 16),
                ...AdminMockData.getSatisfactionMetrics().map((metric) => 
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              metric.name,
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              '${metric.percentage.toInt()}%',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: metric.percentage / 100,
                          backgroundColor: theme.colorScheme.surface,
                          color: metric.color,
                          minHeight: 6,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ],
                    ),
                  ),
                ).toList(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildOfficesAndActivity(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Performing Offices
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Top Performing Offices',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Based on revenue and growth',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          LucideIcons.eye,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        label: Text(
                          'View All',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...AdminMockData.getTopPerformingOffices().map((office) => 
                  TopOfficeItem(office: office),
                ).toList(),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Recent Activity
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recent Activity',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Latest platform activities',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          LucideIcons.list,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                        label: Text(
                          'View All',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...AdminMockData.getRecentActivity().map((activity) => 
                  RecentActivityItem(activity: activity),
                ).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildQuickActions(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Actions',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Common administrative tasks',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: QuickActionButton(
                icon: LucideIcons.userPlus,
                title: 'Add User',
                color: Colors.blue,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: QuickActionButton(
                icon: LucideIcons.building,
                title: 'New Office',
                color: Colors.indigo,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: QuickActionButton(
                icon: LucideIcons.fileBarChart,
                title: 'Run Reports',
                color: Colors.purple,
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: QuickActionButton(
                icon: LucideIcons.settings,
                title: 'Settings',
                color: Colors.teal,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildNotificationsAndCompletionRate(ThemeData theme) {
    final rateData = AdminMockData.getCurrentRateData();
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Latest Notifications
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Latest Notifications',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ...AdminMockData.getSystemNotifications().map((notification) {
                  IconData iconData;
                  Color iconBgColor;
                  
                  switch (notification.type) {
                    case 'system':
                      iconData = LucideIcons.bell;
                      iconBgColor = Colors.blue.withOpacity(0.1);
                      break;
                    case 'message':
                      iconData = LucideIcons.messageCircle;
                      iconBgColor = Colors.orange.withOpacity(0.1);
                      break;
                    case 'achievement':
                      iconData = LucideIcons.trophy;
                      iconBgColor = Colors.green.withOpacity(0.1);
                      break;
                    default:
                      iconData = LucideIcons.info;
                      iconBgColor = Colors.grey.withOpacity(0.1);
                  }
                  
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        iconData,
                        color: notification.iconColor,
                      ),
                    ),
                    title: Text(
                      notification.title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: notification.type == 'system' 
                      ? Text(
                          'The system has been updated to version 2.4.0',
                          style: theme.textTheme.bodySmall,
                        )
                      : notification.type == 'message'
                        ? Text(
                            'Support team: "We\'ve received your ticket #4851..."',
                            style: theme.textTheme.bodySmall,
                          )
                        : notification.type == 'achievement'
                          ? Text(
                              'Chicago office has achieved their monthly service goal',
                              style: theme.textTheme.bodySmall,
                            )
                          : null,
                    trailing: Text(
                      _getTimeAgo(notification.time),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Service Completion Rate
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Service Completion Rate',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 200,
                    child: CompletionRateChart(),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      // Current rate
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'CURRENT RATE',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '${rateData['current']}%',
                                    style: theme.textTheme.headlineMedium?.copyWith(
                                      color: theme.colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    LucideIcons.trendingUp,
                                    size: 14,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${rateData['change']}% from last month',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Target
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TARGET',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    '${rateData['target']}%',
                                    style: theme.textTheme.headlineMedium?.copyWith(
                                      color: theme.colorScheme.error,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    LucideIcons.target,
                                    size: 14,
                                    color: theme.colorScheme.error,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${rateData['remaining']}% remaining to reach target',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.error,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  String _formatCurrency(double value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(0)}K';
    } else {
      return value.toStringAsFixed(0);
    }
  }
  
  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inHours < 1) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hour${difference.inHours == 1 ? '' : 's'} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} day${difference.inDays == 1 ? '' : 's'} ago';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }
} 