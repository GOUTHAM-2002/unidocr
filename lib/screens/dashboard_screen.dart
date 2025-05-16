import 'package:flutter/material.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/dummy/dashboard_data.dart'; // Import dummy data
import 'package:lucide_icons/lucide_icons.dart'; // Using a Lucide icons package
// Import the chart widgets we created
import 'package:unidoc/widgets/common/charts/line_chart_widget.dart';
import 'package:unidoc/widgets/common/charts/pie_chart_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedTimeRange = '30days'; // Matches default in Next.js
  bool _isSmallScreen = false; // Added to store screen size status

  final List<Map<String, dynamic>> _timeRangeOptions = [
    {'value': '7days', 'label': 'Last 7 days'},
    {'value': '30days', 'label': 'Last 30 days'},
    {'value': '90days', 'label': 'Last 90 days'},
    {'value': 'year', 'label': 'Last year'},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the TabController immediately with a default value
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newIsSmallScreen = MediaQuery.of(context).size.width < 768;
    if (newIsSmallScreen != _isSmallScreen) {
      _isSmallScreen = newIsSmallScreen;
      final tabCount = _isSmallScreen ? 3 : 5;
      
      // Dispose and recreate the controller only if screen size changed
      _tabController.dispose();
      _tabController = TabController(length: tabCount, vsync: this);
      // TODO: Fetch initial stats based on _selectedTimeRange if implementing actual data fetching
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false, // Handled by MainLayout's AppBar
              pinned: false, // Could be true if we want the header to stick
              floating: true, // Header appears when scrolling up
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              toolbarHeight: 100, // Increased height for title and actions
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                expandedTitleScale: 1.0, // Keep title size consistent
                background: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dashboard',
                                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Overview of your business performance',
                                style: textTheme.bodyMedium?.copyWith(color: AppColors.unidocMedium),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 180,
                            child: DropdownButtonFormField<String>(
                              value: _selectedTimeRange,
                              items: _timeRangeOptions.map((option) {
                                return DropdownMenuItem<String>(
                                  value: option['value'],
                                  child: Row(
                                    children: [
                                      const Icon(LucideIcons.calendarDays, size: 16, color: AppColors.unidocMedium),
                                      const SizedBox(width: 8),
                                      Text(option['label']),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedTimeRange = newValue;
                                    // TODO: Trigger data refetch
                                  });
                                }
                              },
                              style: textTheme.bodyMedium,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                border: OutlineInputBorder(
                                  borderRadius: AppRadii.mdRadius,
                                  borderSide: BorderSide(color: AppColors.border),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: AppRadii.mdRadius,
                                  borderSide: BorderSide(color: AppColors.border),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: AppRadii.mdRadius,
                                  borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                                ),
                                fillColor: colorScheme.surface,
                                filled: true,
                                isDense: true,
                              ),
                              dropdownColor: colorScheme.surface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                labelColor: colorScheme.primary,
                unselectedLabelColor: AppColors.unidocMedium,
                indicatorColor: colorScheme.primary,
                indicatorWeight: 2.0,
                labelStyle: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                unselectedLabelStyle: textTheme.bodyMedium,
                isScrollable: _isSmallScreen, // Allow scrolling on small screens
                tabs: [
                  _buildTab(LucideIcons.activity, 'Overview'),
                  _buildTab(LucideIcons.calendarDays, 'Schedule'),
                  _buildTab(LucideIcons.users, 'Customers'),
                  if (!_isSmallScreen) _buildTab(LucideIcons.dollarSign, 'Agreements', showOnSmallScreen: false),
                  if (!_isSmallScreen) _buildTab(LucideIcons.userCircle, 'Users', showOnSmallScreen: false),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(context),
            _buildPlaceholderTab('Schedule Content'), // Placeholder
            _buildPlaceholderTab('Customers Content'), // Placeholder
            if (!_isSmallScreen) _buildPlaceholderTab('Agreements Content'), // Placeholder
            if (!_isSmallScreen) _buildPlaceholderTab('Users Content'), // Placeholder
          ],
        ),
      ),
    );
  }

  Widget _buildTab(IconData icon, String text, {bool showOnSmallScreen = true}) {
    final theme = Theme.of(context);

    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab(String content) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(content, style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }

  // --- Overview Tab Content ---
  Widget _buildOverviewTab(BuildContext context) {
    // For now, using dummyDashboardStats directly. Later, this might come from a state management solution.
    final stats = dummyDashboardStats; 
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Cards Grid
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 4;
              if (constraints.maxWidth < 1200) crossAxisCount = 2;
              if (constraints.maxWidth < 600) crossAxisCount = 1;
              
              double childAspectRatio = (constraints.maxWidth < 600) ? 2.5 : (constraints.maxWidth < 1200 ? 1.8 : 2.2);


              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: childAspectRatio,
                children: [
                  _buildStatCard(
                    title: 'Revenue',
                    value: '\$${stats.totalRevenue.toStringAsFixed(0)}',
                    changePercent: stats.revenueChangePercent,
                    icon: LucideIcons.dollarSign,
                    iconColor: Colors.green.shade600,
                  ),
                  _buildStatCard(
                    title: 'Jobs Completed',
                    value: stats.completedJobs.toString(),
                    changePercent: stats.jobsChangePercent,
                    icon: LucideIcons.checkCircle2,
                     iconColor: Colors.blue.shade600,
                  ),
                  _buildStatCard(
                    title: 'Active Customers',
                    value: stats.activeCustomers.toString(),
                    changePercent: stats.customersChangePercent,
                    icon: LucideIcons.users,
                    iconColor: Colors.orange.shade600,
                  ),
                  _buildStatCard(
                    title: 'Avg. Job Value',
                    value: '\$${stats.avgJobValue.toStringAsFixed(0)}',
                    changePercent: stats.avgJobValueChangePercent,
                    icon: LucideIcons.trendingUp, // Or trendingDown based on value
                    iconColor: Colors.purple.shade600,
                  ),
                ],
              );
            }
          ),
          const SizedBox(height: 24),

          // Performance Overview & Customer Breakdown Charts
          LayoutBuilder(
            builder: (context, constraints) {
              bool isTabletOrLarger = constraints.maxWidth >= 768;
              if (isTabletOrLarger) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: _buildPerformanceChartCard(context),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: _buildCustomerBreakdownCard(context),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildPerformanceChartCard(context),
                    const SizedBox(height: 16),
                    _buildCustomerBreakdownCard(context),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 24),

          // Top Performing Users & Recent Activity
           LayoutBuilder(
            builder: (context, constraints) {
              bool isTabletOrLarger = constraints.maxWidth >= 768;
              if (isTabletOrLarger) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTopPerformingUsersCard(context),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildRecentActivityCard(context),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildTopPerformingUsersCard(context),
                    const SizedBox(height: 16),
                    _buildRecentActivityCard(context),
                  ],
                );
              }
            },
          ),
          const SizedBox(height: 16),
          // Info banner at the bottom
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.unidocPrimaryBlue.withOpacity(0.08),
              borderRadius: AppRadii.lgRadius,
              border: Border.all(color: AppColors.unidocPrimaryBlue.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.info, size: 18, color: AppColors.unidocPrimaryBlue),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analytics insights available',
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.unidocPrimaryBlue,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Deeper analytics for all business areas are available. Click on the Analytics button in each section for detailed insights.',
                        style: textTheme.bodySmall?.copyWith(
                          color: AppColors.unidocDeepBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required double changePercent,
    required IconData icon,
    Color? iconColor,

  }) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    bool isPositive = changePercent >= 0;

    return Card(
      elevation: 0, // Using theme's card elevation (which we set to 0 and border)
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.lgRadius,
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.unidocMedium),
                ),
                Icon(icon, size: 20, color: iconColor ?? AppColors.unidocMedium),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  isPositive ? LucideIcons.arrowUpRight : LucideIcons.arrowDownRight,
                  size: 14,
                  color: isPositive ? Colors.green.shade600 : Colors.red.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  '${isPositive ? "+" : ""}${changePercent.toStringAsFixed(1)}%',
                  style: textTheme.bodySmall?.copyWith(
                    color: isPositive ? Colors.green.shade600 : Colors.red.shade600,
                    fontWeight: FontWeight.w600
                  ),
                ),
                Expanded(
                  child: Text(
                    ' vs previous period',
                    style: textTheme.bodySmall?.copyWith(color: AppColors.unidocMedium),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceChartCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
       elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.lgRadius,
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Performance Overview', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            Text('Revenue and job completion trends', style: textTheme.bodySmall?.copyWith(color: AppColors.unidocMedium)),
            const SizedBox(height: 16),
            Container(
              height: 250, // Fixed height for the chart area
              child: LineChartWidget(performanceData: performanceData),
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildCustomerBreakdownCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.lgRadius,
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customer Breakdown', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            Text('By business type', style: textTheme.bodySmall?.copyWith(color: AppColors.unidocMedium)),
            const SizedBox(height: 16),
            Container(
              height: 250, // Fixed height for the chart area
              child: PieChartWidget(customerSegments: customerBreakdownData),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopPerformingUsersCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.lgRadius,
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Top Performing Users', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
                    Text('Based on job completion rate', style: textTheme.bodySmall?.copyWith(color: AppColors.unidocMedium)),
                  ],
                ),
                TextButton(
                  onPressed: () { /* TODO: Navigate to all users screen */ },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('View All', style: textTheme.labelLarge?.copyWith(color: colorScheme.primary)),
                      const SizedBox(width: 4),
                      Icon(LucideIcons.chevronRight, size: 16, color: colorScheme.primary),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 290, // As per Next.js (h-[290px])
              child: ListView.separated(
                itemCount: usersData.length,
                itemBuilder: (context, index) {
                  final user = usersData[index];
                  String initials = user.name.split(' ').map((n) => n.isNotEmpty ? n[0] : '').join('');
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
                        backgroundColor: AppColors.unidocLightBlue.withOpacity(0.3),
                        child: user.avatarUrl == null 
                               ? Text(initials, style: textTheme.bodyMedium?.copyWith(color: AppColors.unidocDeepBlue, fontWeight: FontWeight.w600))
                               : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.name, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                            Text(user.role, style: textTheme.bodySmall?.copyWith(color: AppColors.unidocMedium)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        width: 100, // Approx width for progress + percentage
                        child: Row(
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                value: user.performance / 100,
                                backgroundColor: AppColors.unidocLightGray,
                                color: colorScheme.primary,
                                minHeight: 6,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('${user.performance}%', style: textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivityCard(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    
    return Card(
       elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.lgRadius,
        side: BorderSide(color: AppColors.border, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Recent Activity', style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
            Text('Latest system events', style: textTheme.bodySmall?.copyWith(color: AppColors.unidocMedium)),
            const SizedBox(height: 16),
            SizedBox(
              height: 290, // As per Next.js (h-[290px])
              child: ListView.separated(
                itemCount: recentActivityData.length,
                itemBuilder: (context, index) {
                  final activity = recentActivityData[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: _getActivityIconColor(activity.type, Theme.of(context).colorScheme).withOpacity(0.1),
                            shape: BoxShape.circle,
                        ),
                        child: Icon(
                           _getActivityIcon(activity.type),
                            size: 14,
                            color: _getActivityIconColor(activity.type, Theme.of(context).colorScheme),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(activity.title, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                            if (activity.description != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(activity.description!, style: textTheme.bodySmall?.copyWith(color: AppColors.unidocMedium)),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                '${_formatTimeAgo(activity.timestamp)}${activity.user != null ? " by ${activity.user}" : ""}',
                                style: textTheme.labelSmall?.copyWith(color: AppColors.unidocMedium.withOpacity(0.8)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                 separatorBuilder: (context, index) => const Divider(height: 24, thickness: 0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  String _formatTimeAgo(DateTime dt) {
    final duration = DateTime.now().difference(dt);
    if (duration.inDays > 1) return '${duration.inDays} days ago';
    if (duration.inDays == 1) return '1 day ago';
    if (duration.inHours > 1) return '${duration.inHours} hours ago';
    if (duration.inHours == 1) return '1 hour ago';
    if (duration.inMinutes > 1) return '${duration.inMinutes} mins ago';
    return 'Just now';
  }

  IconData _getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.agreement: return LucideIcons.fileText;
      case ActivityType.job: return LucideIcons.hammer; // Changed to hammer instead of construct
      case ActivityType.user: return LucideIcons.userCog;
      case ActivityType.system: return LucideIcons.serverCog;
      default: return LucideIcons.alertCircle;
    }
  }
  
  Color _getActivityIconColor(ActivityType type, ColorScheme colorScheme) {
    switch (type) {
      case ActivityType.agreement: return colorScheme.primary;
      case ActivityType.job: return Colors.orange.shade600;
      case ActivityType.user: return Colors.purple.shade600;
      case ActivityType.system: return AppColors.unidocMedium;
      default: return colorScheme.error;
    }
  }
} 