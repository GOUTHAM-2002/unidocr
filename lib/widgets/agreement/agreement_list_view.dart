import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/agreement_models.dart';
import 'package:unidoc/dummy/agreement_mock_data.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:intl/intl.dart';

class AgreementListView extends StatefulWidget {
  final String customerId;
  final String customerName;
  final VoidCallback? onCreateAgreement;

  const AgreementListView({
    Key? key,
    required this.customerId,
    required this.customerName,
    this.onCreateAgreement,
  }) : super(key: key);

  @override
  State<AgreementListView> createState() => _AgreementListViewState();
}

class _AgreementListViewState extends State<AgreementListView> {
  // Agreements data
  List<Agreement> _agreements = [];
  List<Agreement> _filteredAgreements = [];
  bool _isLoading = true;
  String _activeFilterTab = 'All';
  
  // View options
  bool _isGridView = true;
  String _searchTerm = '';
  final TextEditingController _searchController = TextEditingController();
  
  // Sort options
  String _sortField = 'createdAt';
  bool _sortAscending = false;

  @override
  void initState() {
    super.initState();
    // Simulate loading
    Future.delayed(const Duration(milliseconds: 500), () {
      _loadAgreements();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Load agreements for this customer
  void _loadAgreements() {
    setState(() {
      _isLoading = true;
    });
    
    // In a real app, this would be an API call
    final agreements = AgreementMockData.getAgreementsForCustomer(widget.customerId);
    
    setState(() {
      _agreements = agreements;
      _applyFilters();
      _isLoading = false;
    });
  }
  
  // Apply filters and search
  void _applyFilters() {
    setState(() {
      _filteredAgreements = _agreements.where((agreement) {
        // Apply tab filter (All, Active, Drafts, Expired)
        if (_activeFilterTab != 'All' && agreement.status.toLowerCase() != _activeFilterTab.toLowerCase()) {
          return false;
        }
        
        // Apply search filter if any
        if (_searchTerm.isNotEmpty) {
          final search = _searchTerm.toLowerCase();
          return agreement.title.toLowerCase().contains(search) ||
                 agreement.id.toLowerCase().contains(search) ||
                 agreement.type.toLowerCase().contains(search) ||
                 agreement.formattedValue.toLowerCase().contains(search);
        }
        
        return true;
      }).toList();
      
      // Apply sorting
      _filteredAgreements.sort((a, b) {
        dynamic valueA;
        dynamic valueB;
        
        switch (_sortField) {
          case 'createdAt':
            valueA = a.createdAt;
            valueB = b.createdAt;
            break;
          case 'title':
            valueA = a.title;
            valueB = b.title;
            break;
          case 'expirationDate':
            valueA = a.expirationDate;
            valueB = b.expirationDate;
            break;
          case 'value':
            valueA = a.value;
            valueB = b.value;
            break;
          default:
            valueA = a.createdAt;
            valueB = b.createdAt;
        }
        
        if (valueA is String && valueB is String) {
          return _sortAscending ? valueA.compareTo(valueB) : valueB.compareTo(valueA);
        } else if (valueA is DateTime && valueB is DateTime) {
          return _sortAscending ? valueA.compareTo(valueB) : valueB.compareTo(valueA);
        } else if (valueA is num && valueB is num) {
          return _sortAscending ? valueA.compareTo(valueB) : valueB.compareTo(valueA);
        }
        
        return 0;
      });
    });
  }
  
  // Change filter tab
  void _onTabChange(String tab) {
    setState(() {
      _activeFilterTab = tab;
      _applyFilters();
    });
  }
  
  // Toggle view mode (grid/list)
  void _toggleViewMode() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }
  
  // Update search term
  void _onSearchChanged(String value) {
    setState(() {
      _searchTerm = value;
      _applyFilters();
    });
  }
  
  // Clear search
  void _clearSearch() {
    _searchController.clear();
    _onSearchChanged('');
  }
  
  // Set sort field
  void _setSortField(String field) {
    setState(() {
      if (_sortField == field) {
        // Toggle direction if same field
        _sortAscending = !_sortAscending;
      } else {
        // Default to descending for new field
        _sortField = field;
        _sortAscending = false;
      }
      _applyFilters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildFilterTabs(),
        const SizedBox(height: 16),
        _buildSearchBar(),
        const SizedBox(height: 16),
        Expanded(
          child: _isLoading 
              ? const Center(child: CircularProgressIndicator())
              : _filteredAgreements.isEmpty
                  ? _buildEmptyState()
                  : _isGridView
                      ? _buildGridView()
                      : _buildListView(),
        ),
      ],
    );
  }
  
  // Page header with title and actions
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Price Agreements',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton.icon(
          onPressed: widget.onCreateAgreement,
          icon: const Icon(Icons.add),
          label: const Text('New Agreement'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
  
  // Filter tabs (All, Active, Drafts, Expired)
  Widget _buildFilterTabs() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          _buildFilterTab('All'),
          _buildFilterTab('Active'),
          _buildFilterTab('Draft'),
          _buildFilterTab('Expired'),
        ],
      ),
    );
  }
  
  // Individual filter tab
  Widget _buildFilterTab(String label) {
    final isActive = _activeFilterTab == label;
    
    return InkWell(
      onTap: () => _onTabChange(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.blue : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.blue : Colors.grey.shade700,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  
  // Search and view toggles
  Widget _buildSearchBar() {
    return Row(
      children: [
        // Search field
        Expanded(
          child: TextField(
            controller: _searchController,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search agreements...',
              prefixIcon: const Icon(LucideIcons.search, size: 18),
              suffixIcon: _searchTerm.isNotEmpty
                  ? IconButton(
                      icon: const Icon(LucideIcons.x, size: 18),
                      onPressed: _clearSearch,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: AppRadii.mdRadius,
                borderSide: BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppRadii.mdRadius,
                borderSide: BorderSide(color: AppColors.border),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        
        // Sort button
        IconButton(
          icon: const Icon(LucideIcons.arrowDownUp),
          tooltip: 'Sort',
          onPressed: () => _showSortMenu(context),
        ),
        
        // View toggle
        IconButton(
          icon: Icon(_isGridView ? LucideIcons.list : LucideIcons.layoutGrid),
          tooltip: _isGridView ? 'List View' : 'Grid View',
          onPressed: _toggleViewMode,
        ),
      ],
    );
  }
  
  // Grid view of agreements
  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: _filteredAgreements.length,
      itemBuilder: (context, index) {
        final agreement = _filteredAgreements[index];
        return _buildAgreementCard(agreement);
      },
    );
  }
  
  // List view of agreements
  Widget _buildListView() {
    return ListView.separated(
      itemCount: _filteredAgreements.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final agreement = _filteredAgreements[index];
        return _buildAgreementListItem(agreement);
      },
    );
  }
  
  // Agreement card for grid view
  Widget _buildAgreementCard(Agreement agreement) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.mdRadius,
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () => _viewAgreementDetails(agreement),
        borderRadius: AppRadii.mdRadius,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: agreement.statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          agreement.statusIcon,
                          size: 12,
                          color: agreement.statusTextColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          agreement.status,
                          style: TextStyle(
                            fontSize: 12,
                            color: agreement.statusTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (agreement.isExpiringSoon && agreement.status != 'expired')
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            LucideIcons.alertTriangle,
                            size: 12,
                            color: Colors.amber.shade800,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${agreement.daysRemaining} days left',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.amber.shade800,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agreement.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      agreement.type.toUpperCase(),
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VALUE',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        agreement.formattedValue,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'VALID UNTIL',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        DateFormat('MM/dd/yyyy').format(agreement.expirationDate),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: agreement.status == 'expired' ? Colors.grey.shade600 : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Agreement list item for list view
  Widget _buildAgreementListItem(Agreement agreement) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadii.mdRadius,
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        onTap: () => _viewAgreementDetails(agreement),
        borderRadius: AppRadii.mdRadius,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          agreement.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: agreement.statusColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                agreement.statusIcon,
                                size: 12,
                                color: agreement.statusTextColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                agreement.status,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: agreement.statusTextColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (agreement.isExpiringSoon && agreement.status != 'expired')
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.alertTriangle,
                                  size: 12,
                                  color: Colors.amber.shade800,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${agreement.daysRemaining} days left',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.amber.shade800,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ID: ${agreement.id} | Type: ${agreement.type.toUpperCase()}',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VALUE',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      agreement.formattedValue,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VALIDITY PERIOD',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      agreement.dateRange,
                      style: TextStyle(
                        fontSize: 14,
                        color: agreement.status == 'expired' ? Colors.grey.shade600 : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showAgreementOptions(context, agreement),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Empty state when no agreements found
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.clipboardList,
            size: 64,
            color: Colors.blue.shade200,
          ),
          const SizedBox(height: 16),
          const Text(
            'No agreements found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This customer doesn\'t have any price agreements yet.',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: widget.onCreateAgreement,
            icon: const Icon(Icons.add),
            label: const Text('Create a Price Agreement'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
  
  // Show agreement details
  void _viewAgreementDetails(Agreement agreement) {
    // TODO: Navigate to agreement details page
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Agreement: ${agreement.title}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Status: ${agreement.status}'),
              Text('Value: ${agreement.formattedValue}'),
              Text('Valid until: ${DateFormat('MM/dd/yyyy').format(agreement.expirationDate)}'),
              Text('Created at: ${DateFormat('MM/dd/yyyy').format(agreement.createdAt)}'),
              const SizedBox(height: 8),
              const Text('This is a placeholder. Full implementation will show detailed agreement information.'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  // Show agreement options menu
  void _showAgreementOptions(BuildContext context, Agreement agreement) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          value: 'view',
          child: const Row(
            children: [
              Icon(LucideIcons.eye, size: 18),
              SizedBox(width: 8),
              Text('View Details'),
            ],
          ),
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => _viewAgreementDetails(agreement),
          ),
        ),
        if (agreement.status == 'draft')
          PopupMenuItem(
            value: 'edit',
            child: const Row(
              children: [
                Icon(LucideIcons.edit, size: 18),
                SizedBox(width: 8),
                Text('Edit'),
              ],
            ),
            onTap: () {
              // TODO: Edit agreement
            },
          ),
        if (agreement.status == 'active')
          PopupMenuItem(
            value: 'renew',
            child: const Row(
              children: [
                Icon(LucideIcons.repeat, size: 18),
                SizedBox(width: 8),
                Text('Renew'),
              ],
            ),
            onTap: () {
              // TODO: Renew agreement
            },
          ),
        PopupMenuItem(
          value: 'download',
          child: const Row(
            children: [
              Icon(LucideIcons.download, size: 18),
              SizedBox(width: 8),
              Text('Download PDF'),
            ],
          ),
          onTap: () {
            // TODO: Download PDF
          },
        ),
        if (agreement.status == 'draft')
          PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(LucideIcons.trash, size: 18, color: Colors.red.shade700),
                const SizedBox(width: 8),
                Text('Delete', style: TextStyle(color: Colors.red.shade700)),
              ],
            ),
            onTap: () {
              // TODO: Delete agreement
            },
          ),
      ],
    );
  }
  
  // Show sort menu
  void _showSortMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Sort Agreements'),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        children: [
          _buildSortOption('createdAt', 'Creation Date'),
          _buildSortOption('title', 'Title'),
          _buildSortOption('expirationDate', 'Expiration Date'),
          _buildSortOption('value', 'Value'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  // Build individual sort option
  Widget _buildSortOption(String field, String label) {
    final isSelected = _sortField == field;
    
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        _setSortField(field);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              isSelected
                  ? (_sortAscending ? LucideIcons.arrowUp : LucideIcons.arrowDown)
                  : LucideIcons.minus,
              size: 18,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 