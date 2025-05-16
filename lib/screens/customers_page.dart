import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:unidoc/theme/app_theme.dart';
// import '../services/data_service.dart'; // Assuming DataService needs updates or is for dummy data
// import '../widgets/animated_gradient_background.dart'; // Removed
// import '../widgets/glass_card.dart'; // Removed

// TODO: This entire screen is an older version and needs to be redesigned
// based on 'testprojects/src/pages/Customers.tsx' (or equivalent) and integrated with the new MainLayout.
// The router currently points /customers to a placeholder.

// Dummy Customer Model (replace with actual model from data_service or models directory)
class Customer {
  final String id;
  final String name;
  final String email;
  final String type; // 'business', 'individual', etc.
  final String status; // 'active', 'inactive'

  Customer({required this.id, required this.name, required this.email, required this.type, required this.status});
}

// Dummy DataService methods (replace with actual service calls)
class DataService {
  static List<Customer> getAllCustomers() {
    return _dummyCustomers;
  }
  static List<Customer> getCustomersByType(String type) {
    return _dummyCustomers.where((c) => c.type == type).toList();
  }

  static final List<Customer> _dummyCustomers = [
    Customer(id: '1', name: 'Acme Corp', email: 'contact@acme.com', type: 'business', status: 'active'),
    Customer(id: '2', name: 'John Doe', email: 'john.doe@example.com', type: 'individual', status: 'inactive'),
    Customer(id: '3', name: 'Gov Department X', email: 'info@govx.gov', type: 'government', status: 'active'),
    Customer(id: '4', name: 'Beta Solutions', email: 'sales@beta.io', type: 'business', status: 'active'),
    Customer(id: '5', name: 'Charity Org Y', email: 'support@charityy.org', type: 'non-profit', status: 'inactive'),
  ];
}

class CustomersPage extends StatefulWidget {
  const CustomersPage({super.key});

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  String _selectedType = 'all';

  final List<Map<String, String>> _customerTypes = [
    {'value': 'all', 'label': 'All Types'},
    {'value': 'business', 'label': 'Business'},
    {'value': 'individual', 'label': 'Individual'},
    {'value': 'government', 'label': 'Government'},
    {'value': 'non-profit', 'label': 'Non-Profit'},
  ];

  @override
  Widget build(BuildContext context) {
    final customers = _selectedType == 'all'
        ? DataService.getAllCustomers()
        : DataService.getCustomersByType(_selectedType);
    
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: Text('Old Customers Page (To Be Replaced)', style: textTheme.titleLarge),
        backgroundColor: colorScheme.surfaceVariant,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Customers (Old Version)',
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
                // Filter dropdown
                SizedBox(
                  width: 200, 
                  child: DropdownButtonFormField<String>(
                    value: _selectedType,
                    style: textTheme.bodyMedium,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorScheme.surface,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: OutlineInputBorder(borderRadius: AppRadii.mdRadius, borderSide: BorderSide(color: AppColors.border)),
                      enabledBorder: OutlineInputBorder(borderRadius: AppRadii.mdRadius, borderSide: BorderSide(color: AppColors.border)),
                    ),
                    dropdownColor: colorScheme.surface,
                    items: _customerTypes.map((type) {
                      return DropdownMenuItem(
                        value: type['value'],
                        child: Text(type['label']!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedType = value;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Customer list
            Expanded(
              child: ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, index) {
                  final customer = customers[index];
                  final bool isActive = customer.status == 'active';
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: AppRadii.mdRadius, side: BorderSide(color: AppColors.border)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isActive ? AppColors.unidocSuccess.withOpacity(0.2) : AppColors.unidocError.withOpacity(0.2),
                        child: Text(
                          customer.name.isNotEmpty ? customer.name[0] : '-',
                          style: textTheme.titleMedium?.copyWith(
                            color: isActive ? AppColors.unidocSuccess : AppColors.unidocError,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      title: Text(
                        customer.name,
                        style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        customer.email,
                        style: textTheme.bodyMedium?.copyWith(color: AppColors.unidocMedium),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.unidocSuccess.withOpacity(0.15)
                              : AppColors.unidocError.withOpacity(0.15),
                          borderRadius: AppRadii.smRadius,
                        ),
                        child: Text(
                          customer.status.toUpperCase(),
                          style: textTheme.labelSmall?.copyWith(
                            color: isActive
                                ? AppColors.unidocSuccess
                                : AppColors.unidocError,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(
                        delay: (100 * index).ms,
                        duration: 600.ms,
                      ).slideX(
                        begin: 0.2,
                        end: 0,
                        delay: (100 * index).ms,
                        duration: 600.ms,
                        curve: Curves.easeOutBack,
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 