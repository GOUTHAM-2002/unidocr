import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/dummy/admin_mock_data.dart';
import 'package:unidoc/models/admin_models.dart';
import 'package:unidoc/widgets/admin/office_grid_view.dart';
import 'package:unidoc/widgets/admin/office_table_view.dart';
import 'package:unidoc/widgets/admin/user_management_dialog.dart';

class OfficeManagement extends StatefulWidget {
  const OfficeManagement({super.key});

  @override
  State<OfficeManagement> createState() => _OfficeManagementState();
}

class _OfficeManagementState extends State<OfficeManagement> {
  List<Office> offices = [];
  bool isTableView = true;
  String searchQuery = '';
  List<Office> filteredOffices = [];
  
  @override
  void initState() {
    super.initState();
    // Load mock data
    offices = AdminMockData.getOffices();
    filteredOffices = offices;
  }
  
  void _filterOffices(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredOffices = offices;
      } else {
        filteredOffices = offices.where((office) => 
          office.name.toLowerCase().contains(query.toLowerCase()) ||
          office.type.toLowerCase().contains(query.toLowerCase()) ||
          office.location.toLowerCase().contains(query.toLowerCase()) ||
          (office.email != null && office.email!.toLowerCase().contains(query.toLowerCase()))
        ).toList();
      }
    });
  }
  
  void _toggleViewMode() {
    setState(() {
      isTableView = !isTableView;
    });
  }
  
  void _showUserManagement(Office office) {
    showDialog(
      context: context,
      builder: (context) => UserManagementDialog(office: office),
    );
  }
  
  void _viewOfficeDetails(Office office) {
    // Navigate to office details or show modal
    // For now just print to console
    print('View office details: ${office.name}');
  }
  
  void _editOffice(Office office) {
    // Show edit office dialog
    // For now just print to console
    print('Edit office: ${office.name}');
  }
  
  void _deleteOffice(Office office) {
    // Show confirmation dialog and delete
    // For now just print to console
    print('Delete office: ${office.name}');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Office Management',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${offices.length} Offices',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // View toggle
                  SegmentedButton<bool>(
                    segments: [
                      ButtonSegment(
                        value: true,
                        icon: const Icon(LucideIcons.layoutGrid),
                        label: const Text('Table View'),
                      ),
                      ButtonSegment(
                        value: false,
                        icon: const Icon(LucideIcons.layoutGrid),
                        label: const Text('Grid View'),
                      ),
                    ],
                    selected: {isTableView},
                    onSelectionChanged: (selection) {
                      _toggleViewMode();
                    },
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () {
                      // Refresh data
                      setState(() {
                        offices = AdminMockData.getOffices();
                        _filterOffices(searchQuery);
                      });
                    },
                    icon: const Icon(LucideIcons.refreshCw),
                    tooltip: 'Refresh',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Search and filter row
          Row(
            children: [
              // Search box
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(0.3),
                    ),
                  ),
                  child: TextField(
                    onChanged: _filterOffices,
                    decoration: InputDecoration(
                      hintText: 'Search offices...',
                      prefixIcon: Icon(
                        LucideIcons.search,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Filters button
              OutlinedButton.icon(
                onPressed: () {
                  // Show filters dialog
                },
                icon: const Icon(LucideIcons.filter),
                label: const Text('Filters'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  side: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Export button
              OutlinedButton.icon(
                onPressed: () {
                  // Export data
                },
                icon: const Icon(LucideIcons.download),
                label: const Text('Export'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  side: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Office list
          Expanded(
            child: isTableView
                ? OfficeTableView(
                    offices: filteredOffices,
                    onManageUsers: _showUserManagement,
                    onView: _viewOfficeDetails,
                    onEdit: _editOffice,
                    onDelete: _deleteOffice,
                  )
                : OfficeGridView(
                    offices: filteredOffices,
                    onManageUsers: _showUserManagement,
                    onView: _viewOfficeDetails,
                    onEdit: _editOffice,
                    onDelete: _deleteOffice,
                  ),
          ),
        ],
      ),
    );
  }
} 