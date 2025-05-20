import 'package:flutter/material.dart';
import 'package:unidoc/l10n/app_localizations.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:unidoc/models/customer_models.dart';
import 'package:unidoc/dummy/customer_mock_data.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/widgets/customer/customer_detail_view.dart';

// TODO: This entire screen is an older version and needs to be redesigned
// based on 'testprojects/src/pages/Customers.tsx' (or equivalent) and integrated with the new MainLayout.
// The router currently points /customers to a placeholder.

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  // Search controller
  final TextEditingController _searchController = TextEditingController();
  
  // Filter options
  String _customerStatus = 'all';
  String _customerTier = 'all';
  
  // View mode (grid or list)
  final bool _isGridView = true;
  
  // Selected customer for details panel
  Customer? _selectedCustomer;
  
  // Customers list
  late List<Customer> _allCustomers;
  late List<Customer> _filteredCustomers;
  
  @override
  void initState() {
    super.initState();
    _allCustomers = CustomerMockData.getCustomers();
    _filteredCustomers = List.from(_allCustomers);
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  // Filter customers based on search and filters
  void _filterCustomers() {
    setState(() {
      _filteredCustomers = _allCustomers.where((customer) {
        // Apply status filter
        if (_customerStatus != 'all' && customer.status != _customerStatus) {
          return false;
        }
        
        // Apply tier filter
        if (_customerTier != 'all' && customer.tier != _customerTier) {
          return false;
        }
        
        // Apply search
        if (_searchController.text.isNotEmpty) {
          final searchTerm = _searchController.text.toLowerCase();
          return customer.name.toLowerCase().contains(searchTerm) ||
              customer.email.toLowerCase().contains(searchTerm) ||
              (customer.phone?.toLowerCase().contains(searchTerm) ?? false) ||
              (customer.address?.toLowerCase().contains(searchTerm) ?? false) ||
              customer.id.toLowerCase().contains(searchTerm);
        }
        
        return true;
      }).toList();
    });
  }
  
  // Open customer details view
  void _viewCustomerDetails(Customer customer) {
    setState(() {
      _selectedCustomer = customer;
    });
  }
  
  // Close customer details view
  void _closeCustomerDetails() {
    setState(() {
      _selectedCustomer = null;
    });
  }

  // Enhanced customer detail view implementation
  Widget _buildCustomerDetailView() {
    final customer = _selectedCustomer!;
    // Convert Customer object to Map for the CustomerDetailView
    final customerData = {
      'id': customer.id,
      'name': customer.name,
      'email': customer.email,
      'phone': customer.phone,
      'address': customer.address,
      'status': customer.status,
      'tier': customer.tier,
      'lastActivity': customer.lastActivity.toString(),
      'businessType': customer.businessType,
      'needsAgreement': customer.needsAgreement,
    };
    
    // Return the CustomerDetailView in a container with clear constraints
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: CustomerDetailView(
        customer: customerData,
        onClose: _closeCustomerDetails,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main customer list area
          Expanded(
            flex: _selectedCustomer != null ? 3 : 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with title and actions
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n?.customers ?? 'Customers',
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage your customer information and quotes',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.unidocMedium,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          // Analytics button
                          IconButton(
                            onPressed: () {
                              // Show customer analytics
                            },
                            icon: const Icon(LucideIcons.barChart2),
                            tooltip: 'Customer Analytics',
                          ),
                          const SizedBox(width: 8),
                          
                          // Export button
                          OutlinedButton.icon(
                            onPressed: () {
                              // Export customer data
                            },
                            icon: const Icon(LucideIcons.fileOutput, size: 16),
                            label: const Text('Export'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppRadii.mdRadius,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          
                          // New customer button
                          FilledButton.icon(
                            onPressed: () {
                              // Create new customer
                            },
                            icon: const Icon(LucideIcons.userPlus, size: 16),
                            label: const Text('New Customer'),
                            style: FilledButton.styleFrom(
                              backgroundColor: colorScheme.primary,
                              foregroundColor: colorScheme.onPrimary,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: AppRadii.mdRadius,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Alert box for customers needing price agreement
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: AppRadii.mdRadius,
                      border: Border.all(color: Colors.amber[300]!),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(LucideIcons.alertCircle, color: Colors.amber[800]),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '5 customers need a price agreement.',
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildCompanyChip('Acme Corporation'),
                                  _buildCompanyChip('City Government'),
                                  _buildCompanyChip('Peak Construction'),
                                  Text('and 2 more', style: textTheme.bodyMedium),
                                ],
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // View all customers needing agreements
                          },
                          child: const Text('View All'),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Search and filter row
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Search field
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            _filterCustomers();
                          },
                          decoration: InputDecoration(
                            hintText: 'Search customers...',
                            prefixIcon: const Icon(LucideIcons.search, size: 18),
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
                            fillColor: colorScheme.surface,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      
                      // Refresh button
                      IconButton(
                        onPressed: () {
                          // Refresh customer list
                          setState(() {
                            _allCustomers = CustomerMockData.getCustomers();
                            _filterCustomers();
                          });
                        },
                        icon: const Icon(LucideIcons.refreshCw),
                        tooltip: 'Refresh',
                      ),
                      const SizedBox(width: 8),
                      
                      // Filter button
                      OutlinedButton.icon(
                        onPressed: () {
                          // Show filter menu
                          _showFilterMenu(context);
                        },
                        icon: const Icon(LucideIcons.filter, size: 16),
                        label: const Text('Filter'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: AppRadii.mdRadius,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Customer list (scrollable)
                Expanded(
                  child: _buildCustomerList(),
                ),
              ],
            ),
          ),
          
          // Customer details section (conditionally shown)
          if (_selectedCustomer != null)
            Expanded(
              flex: 2,
              child: _buildCustomerDetailView(),
            ),
        ],
      ),
    );
  }
  
  // Company chip widget
  Widget _buildCompanyChip(String name) {
    return InkWell(
      onTap: () {
        // Navigate to customer
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: AppRadii.smRadius,
        ),
        child: Text(
          name,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.amber[900],
          ),
        ),
      ),
    );
  }
  
  // Grid view of customers
  Widget _buildCustomerGrid() {
    final theme = Theme.of(context);
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredCustomers.length,
      itemBuilder: (context, index) {
        final customer = _filteredCustomers[index];
        
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadii.mdRadius,
            side: BorderSide(color: AppColors.border),
          ),
          child: InkWell(
            onTap: () => _viewCustomerDetails(customer),
            borderRadius: AppRadii.mdRadius,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: _getCustomerAvatarColor(customer.name),
                        child: Text(
                          _getCustomerInitials(customer.name),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    customer.name,
                                    style: theme.textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (customer.tier == 'premium')
                                  _buildTierBadge('Premium')
                                else if (customer.tier == 'elite')
                                  _buildTierBadge('Elite'),
                              ],
                            ),
                            Text(
                              customer.email,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: AppColors.unidocMedium,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(LucideIcons.tag, size: 14, color: AppColors.unidocMedium),
                      const SizedBox(width: 4),
                      Text(
                        'ID: ${customer.id}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.unidocMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(LucideIcons.phone, size: 14, color: AppColors.unidocMedium),
                      const SizedBox(width: 4),
                      Text(
                        'Phone: ${customer.phone ?? 'N/A'}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.unidocMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(LucideIcons.mail, size: 14, color: AppColors.unidocMedium),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'Email: ${customer.email}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppColors.unidocMedium,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(LucideIcons.mapPin, size: 14, color: AppColors.unidocMedium),
                      const SizedBox(width: 4),
                      Text(
                        'Address: ${customer.address ?? 'N/A'}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.unidocMedium,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Status pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: customer.status == 'active'
                              ? Colors.green[50]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          customer.status,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: customer.status == 'active'
                                ? Colors.green[700]
                                : Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      
                      // Last activity
                      Text(
                        'Last activity: ${_formatDate(customer.lastActivity)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.unidocMedium,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  // List view of customers
  Widget _buildCustomerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredCustomers.length,
      itemBuilder: (context, index) {
        final customer = _filteredCustomers[index];
        
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: AppRadii.mdRadius,
            side: BorderSide(color: AppColors.border),
          ),
          child: ListTile(
            onTap: () => _viewCustomerDetails(customer),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: _getCustomerAvatarColor(customer.name),
              child: Text(
                _getCustomerInitials(customer.name),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    customer.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                if (customer.needsAgreement)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Tooltip(
                      message: 'Needs price agreement',
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          LucideIcons.alertCircle,
                          size: 14,
                          color: Colors.amber[800],
                        ),
                      ),
                    ),
                  ),
                if (customer.tier == 'premium')
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _buildTierBadge('Premium'),
                  )
                else if (customer.tier == 'elite')
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _buildTierBadge('Elite'),
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.businessType ?? '',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      LucideIcons.mail,
                      size: 12,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        customer.email,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      LucideIcons.phone,
                      size: 12,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      customer.phone ?? 'N/A',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: customer.status == 'active' ? Colors.green[50] : Colors.grey[200],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                customer.status,
                style: TextStyle(
                  color: customer.status == 'active' ? Colors.green[700] : Colors.grey[700],
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  
  // Customer tier badge
  Widget _buildTierBadge(String tier) {
    final color = tier == 'Premium' ? Colors.blue : Colors.amber[700];
    final bgColor = tier == 'Premium' ? Colors.blue[50] : Colors.amber[50];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: color!.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.crown, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            tier,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
  
  // Get avatar color from name
  Color _getCustomerAvatarColor(String name) {
    final colors = [
      Colors.blue[700]!,
      Colors.purple[700]!,
      Colors.green[700]!,
      Colors.orange[700]!,
      Colors.teal[700]!,
      Colors.red[700]!,
    ];
    
    // Simple hash of name to pick a consistent color
    final hash = name.codeUnits.fold(0, (prev, element) => prev + element);
    return colors[hash % colors.length];
  }
  
  // Get initials from name
  String _getCustomerInitials(String name) {
    if (name.isEmpty) return '';
    
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    } else {
      return name[0].toUpperCase();
    }
  }
  
  // Format date
  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return '${date.month}/${date.day}/${date.year}';
  }
  
  // Show filter menu
  void _showFilterMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Customers'),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Customer Status'),
              const SizedBox(height: 8),
              _buildFilterOptions(
                options: const [
                  {'value': 'all', 'label': 'All Customers'},
                  {'value': 'active', 'label': 'Active Customers'},
                  {'value': 'inactive', 'label': 'Inactive Customers'},
                  {'value': 'prospects', 'label': 'Prospects'},
                ],
                selectedValue: _customerStatus,
                onChanged: (value) {
                  setState(() {
                    _customerStatus = value ?? 'all';
                    _filterCustomers();
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
              const Text('Customer Tiers'),
              const SizedBox(height: 8),
              _buildFilterOptions(
                options: const [
                  {'value': 'all', 'label': 'All Tiers'},
                  {'value': 'standard', 'label': 'Standard (10,000/mo)'},
                  {'value': 'premium', 'label': 'Premium (10,001-50,000/mo)'},
                  {'value': 'elite', 'label': 'Elite (50,000+/mo)'},
                ],
                selectedValue: _customerTier,
                onChanged: (value) {
                  setState(() {
                    _customerTier = value ?? 'all';
                    _filterCustomers();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Reset filters
              setState(() {
                _customerStatus = 'all';
                _customerTier = 'all';
                _filterCustomers();
              });
              Navigator.pop(context);
            },
            child: const Text('Reset Filters'),
          ),
        ],
      ),
    );
  }
  
  // Build filter options
  Widget _buildFilterOptions({
    required List<Map<String, String>> options,
    required String selectedValue,
    required Function(String?) onChanged,
  }) {
    return Column(
      children: options.map((option) {
        final value = option['value']!;
        final label = option['label']!;
        
        return RadioListTile<String>(
          title: Text(label),
          value: value,
          groupValue: selectedValue,
          onChanged: onChanged,
          dense: true,
          contentPadding: EdgeInsets.zero,
        );
      }).toList(),
    );
  }
} 