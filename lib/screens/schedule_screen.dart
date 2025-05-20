import 'package:flutter/material.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:unidoc/models/service_call.dart';
import 'package:unidoc/widgets/schedule/service_call_card.dart';
import 'package:unidoc/widgets/schedule/service_call_detail.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime(2025, 5, 18); // Set to match screenshot date
  String _activeView = 'day'; // 'day', 'week', or 'month'
  String _viewMode = 'list'; // 'list', 'grid', or 'calendar'
  String _activeProjectTab = 'active'; // 'active' or 'completed'
  String _activeStatusFilter = 'all'; // 'all', 'pending', 'scheduled', etc.
  ServiceCall? _selectedServiceCall;
  
  late List<ServiceCall> _serviceCalls;
  late List<ServiceCall> _filteredCalls;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _serviceCalls = getDummyServiceCalls();
    _updateFilteredCalls();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  void _updateFilteredCalls() {
    // For screenshots, show specific records based on selected tab and filters
    if (_activeProjectTab == 'active') {
      if (_activeStatusFilter == 'all') {
        // Show all active service calls sorted by date
        _filteredCalls = _serviceCalls
            .where((call) => call.status != ServiceCallStatus.completed)
            .toList();
      } else if (_activeStatusFilter == 'scheduled') {
        // Show only scheduled service calls
        _filteredCalls = _serviceCalls
            .where((call) => call.status == ServiceCallStatus.scheduled)
            .toList();
      } else if (_activeStatusFilter == 'inProgress') {
        // Show only in-progress service calls
        _filteredCalls = _serviceCalls
            .where((call) => call.status == ServiceCallStatus.inProgress)
            .toList();
      } else if (_activeStatusFilter == 'incomplete') {
        // Show only incomplete service calls
        _filteredCalls = _serviceCalls
            .where((call) => call.status == ServiceCallStatus.incomplete)
            .toList();
      } else if (_activeStatusFilter == 'awaitingSignature') {
        // Show only awaiting signature service calls
        _filteredCalls = _serviceCalls
            .where((call) => call.status == ServiceCallStatus.awaitingSignature)
            .toList();
      } else if (_activeStatusFilter == 'pending') {
        // Show only pending service calls
        _filteredCalls = _serviceCalls
            .where((call) => call.status == ServiceCallStatus.pending)
            .toList();
      }
    } else {
      // Completed projects tab
      _filteredCalls = _serviceCalls
          .where((call) => call.status == ServiceCallStatus.completed)
          .toList();
    }
    
    // Sort by date
    _filteredCalls.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with title and actions
                    _buildHeader(textTheme, colorScheme),
                    const SizedBox(height: 24),
                    
                    // Alerts section
                    _buildAlertsSection(textTheme, colorScheme),
                    const SizedBox(height: 24),
                    
                    // Project status section
                    _buildProjectStatusSection(textTheme, colorScheme),
                    const SizedBox(height: 16),
                    
                    // Date selection and view controls
                    _buildDateControls(textTheme, colorScheme),
                    const SizedBox(height: 16),
                    
                    // Calendar view tabs
                    _buildCalendarTabs(textTheme, colorScheme),
                    const SizedBox(height: 16),
                    
                    // Service call listing - needs a fixed height with scrolling
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5, // 50% of screen height - reduced slightly
                      child: _filteredCalls.isEmpty
                        ? Center(
                            child: Text(
                              'No service calls found for the selected date and filters',
                              style: textTheme.bodyLarge?.copyWith(color: AppColors.unidocMedium),
                            ),
                          )
                        : _viewMode == 'list' 
                            ? _buildListView()
                            : _buildGridView(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Show service call detail as overlay when selected
          if (_selectedServiceCall != null)
            ServiceCallDetail(
              serviceCall: _selectedServiceCall!,
              onClose: () => setState(() => _selectedServiceCall = null),
            ),
        ],
      ),
    );
  }
  
  void _selectServiceCall(ServiceCall serviceCall) {
    setState(() {
      _selectedServiceCall = serviceCall;
    });
  }
  
  void _performAction(ServiceCall serviceCall) {
    // In a real app, we would perform the appropriate action based on the service call status
    // For this demo, we'll just select the service call to show details
    _selectServiceCall(serviceCall);
  }

  Widget _buildHeader(TextTheme textTheme, ColorScheme colorScheme) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 16,
      children: [
        // Left section: Title and description
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.calendar,
              color: colorScheme.primary,
              size: 36,
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Schedule Hub',
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Manage your service calls and work schedule',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.unidocMedium,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        
        // Right section: Action buttons
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(LucideIcons.alignJustify, size: 20),
              style: IconButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(LucideIcons.barChart2, size: 20),
              style: IconButton.styleFrom(
                foregroundColor: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(LucideIcons.bell, size: 20),
              style: IconButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.plus, size: 16),
              label: const Text('New Service Call'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(LucideIcons.clipboardSignature, size: 16),
              label: const Text('New Certificate'),
              style: OutlinedButton.styleFrom(
                foregroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAlertsSection(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Alerts header
        Row(
          children: [
            Icon(LucideIcons.chevronDown, size: 18, color: colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              'Alerts (25)',
              style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text('Show alerts', style: textTheme.bodySmall),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Alert cards - scrollable horizontally on small screens
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 280,
                child: _buildAlertCard(
                  icon: LucideIcons.checkCircle,
                  iconColor: Colors.purple,
                  title: 'Pending Approval',
                  count: '2',
                  description: '2 calls need approval',
                  buttonText: 'View Calls',
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 280,
                child: _buildAlertCard(
                  icon: LucideIcons.alertTriangle,
                  iconColor: Colors.red,
                  title: 'Incomplete',
                  count: '13',
                  description: '13 calls past due date',
                  buttonText: 'View Calls',
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 280,
                child: _buildAlertCard(
                  icon: LucideIcons.clock,
                  iconColor: Colors.amber,
                  title: 'Awaiting Signatures',
                  count: '5',
                  description: '5 certificates need signatures',
                  buttonText: 'View Certificates',
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                width: 280,
                child: _buildAlertCard(
                  icon: LucideIcons.fileText,
                  iconColor: Colors.deepOrange,
                  title: 'Unsigned Documents',
                  count: '5',
                  description: '5 completed calls without signatures',
                  buttonText: 'View Documents',
                  textTheme: textTheme,
                  colorScheme: colorScheme,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAlertCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String count,
    required String description,
    required String buttonText,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count,
                  style: textTheme.bodySmall?.copyWith(
                    color: iconColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: textTheme.bodySmall?.copyWith(color: AppColors.unidocMedium),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                buttonText,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectStatusSection(TextTheme textTheme, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Project status header
        Row(
          children: [
            Text(
              'PROJECT STATUS & FILTERS',
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.unidocMedium,
                letterSpacing: 0.5,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text('Hide filters', style: textTheme.bodySmall),
            ),
          ],
        ),
        const SizedBox(height: 12),
        
        // Project tabs
        Row(
          children: [
            _buildProjectTab(
              text: 'Active Projects',
              count: '18',
              isActive: _activeProjectTab == 'active',
              textTheme: textTheme,
              colorScheme: colorScheme,
              onTap: () {
                setState(() {
                  _activeProjectTab = 'active';
                  _activeStatusFilter = 'all';
                  _updateFilteredCalls();
                });
              },
            ),
            const SizedBox(width: 12),
            _buildProjectTab(
              text: 'Completed Projects',
              count: '5',
              isActive: _activeProjectTab == 'completed',
              textTheme: textTheme,
              colorScheme: colorScheme,
              onTap: () {
                setState(() {
                  _activeProjectTab = 'completed';
                  _activeStatusFilter = 'all';
                  _updateFilteredCalls();
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Project status filters
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _activeProjectTab == 'active' ? 'ACTIVE PROJECT STATUS' : 'COMPLETED PROJECT STATUS',
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.unidocMedium,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _activeProjectTab == 'active'
                  ? [
                      _buildStatusFilter(
                        text: 'All Statuses',
                        isActive: _activeStatusFilter == 'all',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'all';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildStatusFilter(
                        text: 'Pending',
                        isActive: _activeStatusFilter == 'pending',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'pending';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildStatusFilter(
                        text: 'Scheduled',
                        isActive: _activeStatusFilter == 'scheduled',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'scheduled';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildStatusFilter(
                        text: 'In Progress',
                        count: '13',
                        isActive: _activeStatusFilter == 'inProgress',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'inProgress';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildStatusFilter(
                        text: 'Incomplete',
                        count: '5',
                        isActive: _activeStatusFilter == 'incomplete',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'incomplete';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildStatusFilter(
                        text: 'Awaiting Signature',
                        isActive: _activeStatusFilter == 'awaitingSignature',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'awaitingSignature';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                    ]
                  : [
                      _buildStatusFilter(
                        text: 'All Statuses',
                        isActive: _activeStatusFilter == 'all',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'all';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildStatusFilter(
                        text: 'Completed',
                        isActive: _activeStatusFilter == 'completed',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'completed';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildStatusFilter(
                        text: 'Completed - Physical Signature',
                        count: '5',
                        isActive: _activeStatusFilter == 'completedPhysical',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'completedPhysical';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildStatusFilter(
                        text: 'Completed - Unsigned',
                        isActive: _activeStatusFilter == 'completedUnsigned',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'completedUnsigned';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                      const SizedBox(width: 8),
                      _buildStatusFilter(
                        text: 'Canceled',
                        isActive: _activeStatusFilter == 'canceled',
                        textTheme: textTheme,
                        colorScheme: colorScheme,
                        onTap: () {
                          setState(() {
                            _activeStatusFilter = 'canceled';
                            _updateFilteredCalls();
                          });
                        },
                      ),
                    ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProjectTab({
    required String text,
    required String count,
    required bool isActive,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive 
              ? (_activeProjectTab == 'active' ? colorScheme.primary.withOpacity(0.1) : Colors.green.withOpacity(0.1))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isActive 
                ? (_activeProjectTab == 'active' ? colorScheme.primary : Colors.green)
                : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                text,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isActive 
                      ? (_activeProjectTab == 'active' ? colorScheme.primary : Colors.green)
                      : AppColors.unidocMedium,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isActive 
                    ? (_activeProjectTab == 'active' ? colorScheme.primary : Colors.green)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                count,
                style: textTheme.bodySmall?.copyWith(
                  color: isActive ? Colors.white : AppColors.unidocMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusFilter({
    required String text,
    String? count,
    required bool isActive,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary.withOpacity(0.1) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: isActive ? colorScheme.primary : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                text,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  color: isActive ? colorScheme.primary : AppColors.unidocMedium,
                  fontSize: 13, // Slightly smaller font
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? colorScheme.primary : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  count,
                  style: textTheme.bodySmall?.copyWith(
                    color: isActive ? Colors.white : AppColors.unidocMedium,
                    fontWeight: FontWeight.bold,
                    fontSize: 11, // Slightly smaller font
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildDateControls(TextTheme textTheme, ColorScheme colorScheme) {
    const formattedDate = 'May 18th, 2025'; // Hardcoded to match screenshot
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Date label and navigation
          Text('DATE', style: textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.unidocMedium,
            letterSpacing: 0.5,
          )),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
                _updateFilteredCalls();
              });
            },
            icon: Icon(Icons.chevron_left, color: colorScheme.primary),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(24, 24),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(LucideIcons.calendar, size: 16, color: AppColors.unidocMedium),
                const SizedBox(width: 8),
                Text(
                  formattedDate,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 1));
                _updateFilteredCalls();
              });
            },
            icon: Icon(Icons.chevron_right, color: colorScheme.primary),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(24, 24),
            ),
          ),
          const SizedBox(width: 24),
          
          // View options (Today, Week, Month, Custom)
          _buildDateViewOption(
            text: 'Today',
            isActive: false,
            textTheme: textTheme,
            colorScheme: colorScheme,
            onTap: () {
              setState(() {
                _selectedDate = DateTime.now();
                _updateFilteredCalls();
              });
            },
          ),
          const SizedBox(width: 8),
          _buildDateViewOption(
            text: 'Week',
            isActive: false,
            textTheme: textTheme,
            colorScheme: colorScheme,
            onTap: () {},
          ),
          const SizedBox(width: 8),
          _buildDateViewOption(
            text: 'Month',
            isActive: false,
            textTheme: textTheme,
            colorScheme: colorScheme,
            onTap: () {},
          ),
          const SizedBox(width: 8),
          _buildDateViewOption(
            text: 'Custom',
            isActive: false,
            textTheme: textTheme,
            colorScheme: colorScheme,
            onTap: () {},
          ),
          
          const SizedBox(width: 24),
          
          // View type controls
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildViewTypeButton(
                  icon: LucideIcons.list,
                  isActive: _viewMode == 'list',
                  colorScheme: colorScheme,
                  onTap: () => setState(() => _viewMode = 'list'),
                ),
                _buildViewTypeButton(
                  icon: LucideIcons.layoutGrid,
                  isActive: _viewMode == 'grid',
                  colorScheme: colorScheme,
                  onTap: () => setState(() => _viewMode = 'grid'),
                ),
                _buildViewTypeButton(
                  icon: LucideIcons.calendar,
                  isActive: _viewMode == 'calendar',
                  colorScheme: colorScheme,
                  onTap: () => setState(() => _viewMode = 'calendar'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(LucideIcons.filter, size: 16),
            label: const Text('Filter'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDateViewOption({
    required String text,
    required bool isActive,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isActive ? colorScheme.primary : Colors.grey.shade300,
          ),
        ),
        child: Text(
          text,
          style: textTheme.bodySmall?.copyWith(
            color: isActive ? Colors.white : AppColors.unidocMedium,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
  
  Widget _buildViewTypeButton({
    required IconData icon,
    required bool isActive,
    required ColorScheme colorScheme,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isActive ? colorScheme.primary : AppColors.unidocMedium,
        ),
      ),
    );
  }
  
  Widget _buildCalendarTabs(TextTheme textTheme, ColorScheme colorScheme) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 16,
      runSpacing: 16,
      children: [
        // View tabs
        Wrap(
          spacing: 24,
          runSpacing: 16,
          children: [
            _buildCalendarTab(
              icon: LucideIcons.calendar,
              text: 'Day',
              isActive: _activeView == 'day',
              textTheme: textTheme,
              colorScheme: colorScheme,
              onTap: () => setState(() => _activeView = 'day'),
            ),
            _buildCalendarTab(
              icon: LucideIcons.calendarDays,
              text: 'Week',
              isActive: _activeView == 'week',
              textTheme: textTheme,
              colorScheme: colorScheme,
              onTap: () => setState(() => _activeView = 'week'),
            ),
            _buildCalendarTab(
              icon: LucideIcons.calendarCheck,
              text: 'Month',
              isActive: _activeView == 'month',
              textTheme: textTheme,
              colorScheme: colorScheme,
              onTap: () => setState(() => _activeView = 'month'),
            ),
          ],
        ),
        
        // Create button
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(LucideIcons.plus, size: 16),
          label: const Text('Create Service Call'),
          style: OutlinedButton.styleFrom(
            foregroundColor: colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildCalendarTab({
    required IconData icon,
    required String text,
    required bool isActive,
    required TextTheme textTheme,
    required ColorScheme colorScheme,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: isActive ? colorScheme.primary : AppColors.unidocMedium,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: textTheme.bodyMedium?.copyWith(
                  color: isActive ? colorScheme.primary : AppColors.unidocMedium,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 2,
            width: 60,
            color: isActive ? colorScheme.primary : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _filteredCalls.length,
      itemBuilder: (context, index) {
        final serviceCall = _filteredCalls[index];
        return ServiceCallCard(
          serviceCall: serviceCall,
          onMorePressed: () => _selectServiceCall(serviceCall),
          onActionPressed: () => _performAction(serviceCall),
          onCardTap: () => _selectServiceCall(serviceCall),
        );
      },
    );
  }
  
  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredCalls.length,
      itemBuilder: (context, index) {
        final serviceCall = _filteredCalls[index];
        return GestureDetector(
          onTap: () => _selectServiceCall(serviceCall),
          child: _buildGridCard(serviceCall),
        );
      },
    );
  }
  
  Widget _buildGridCard(ServiceCall serviceCall) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    
    final Color borderColor = _getBorderColor(serviceCall);
    final String actionButtonText = _getActionButtonText(serviceCall);
    final IconData actionButtonIcon = _getActionButtonIcon(serviceCall);
    
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.grey.shade50],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company initials in circle
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: serviceCall.initialsColor.withOpacity(0.3),
                            blurRadius: 6,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: serviceCall.initialsColor,
                        child: Text(
                          serviceCall.initials,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    
                    // Company name and status badge
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            serviceCall.companyName,
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: ServiceCall.getStatusColor(serviceCall.status).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: ServiceCall.getStatusColor(serviceCall.status).withOpacity(0.1),
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              ServiceCall.getStatusText(serviceCall.status) ?? '',
                              style: textTheme.bodySmall?.copyWith(
                                color: ServiceCall.getStatusColor(serviceCall.status),
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(LucideIcons.moreHorizontal, size: 14),
                        onPressed: () => _selectServiceCall(serviceCall),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Date, time and site info
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(LucideIcons.calendar, size: 12, color: Colors.grey.shade600),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('MMM d, yyyy').format(serviceCall.date),
                            style: textTheme.bodySmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                          
                          const SizedBox(width: 8),
                          
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(LucideIcons.mapPin, size: 12, color: Colors.grey.shade600),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              serviceCall.siteNumber,
                              style: textTheme.bodySmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 4),
                      
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(LucideIcons.user, size: 12, color: Colors.grey.shade600),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              serviceCall.assignedTo,
                              style: textTheme.bodySmall?.copyWith(fontSize: 10, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Status indicators and action button
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: serviceCall.progressValue,
                          backgroundColor: Colors.grey.shade200,
                          color: borderColor,
                          minHeight: 6,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [
                          BoxShadow(
                            color: serviceCall.status == ServiceCallStatus.awaitingSignature
                                ? ServiceCall.getStatusColor(serviceCall.status).withOpacity(0.2)
                                : Colors.grey.withOpacity(0.1),
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: OutlinedButton.icon(
                        onPressed: () => _performAction(serviceCall),
                        icon: Icon(actionButtonIcon, size: 12),
                        label: Text(
                          actionButtonText,
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: serviceCall.status == ServiceCallStatus.awaitingSignature 
                              ? Colors.white 
                              : ServiceCall.getStatusColor(serviceCall.status),
                          backgroundColor: serviceCall.status == ServiceCallStatus.awaitingSignature 
                              ? ServiceCall.getStatusColor(serviceCall.status)
                              : Colors.transparent,
                          side: BorderSide(
                            color: ServiceCall.getStatusColor(serviceCall.status),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Color _getBorderColor(ServiceCall serviceCall) {
    switch (serviceCall.status) {
      case ServiceCallStatus.scheduled:
        return Colors.blue;
      case ServiceCallStatus.inProgress:
        return Colors.green;
      case ServiceCallStatus.incomplete:
        return Colors.red;
      case ServiceCallStatus.awaitingSignature:
        return Colors.orange;
      case ServiceCallStatus.completed:
        return Colors.green;
      case ServiceCallStatus.pending:
        return Colors.purple;
    }
  }
  
  String _getActionButtonText(ServiceCall serviceCall) {
    switch (serviceCall.status) {
      case ServiceCallStatus.scheduled:
        return 'Start Service';
      case ServiceCallStatus.inProgress:
        return 'Mark Complete';
      case ServiceCallStatus.incomplete:
        return 'Mark Complete';
      case ServiceCallStatus.awaitingSignature:
        return 'Get Signature';
      case ServiceCallStatus.completed:
        return 'View Doc';
      case ServiceCallStatus.pending:
        return 'Start Service';
    }
  }
  
  IconData _getActionButtonIcon(ServiceCall serviceCall) {
    switch (serviceCall.status) {
      case ServiceCallStatus.scheduled:
        return LucideIcons.play;
      case ServiceCallStatus.inProgress:
        return LucideIcons.checkCircle;
      case ServiceCallStatus.incomplete:
        return LucideIcons.checkCircle;
      case ServiceCallStatus.awaitingSignature:
        return LucideIcons.fileSignature;
      case ServiceCallStatus.completed:
        return LucideIcons.fileText;
      case ServiceCallStatus.pending:
        return LucideIcons.play;
    }
  }
} 