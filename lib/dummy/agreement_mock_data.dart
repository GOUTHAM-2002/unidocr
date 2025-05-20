import 'package:unidoc/models/agreement_models.dart';
import 'dart:math';

class AgreementMockData {
  // Random instance for generating varying data
  static final Random _random = Random();
  
  // Standard templates
  static List<AgreementTemplate> getTemplates() {
    return [
      AgreementTemplate(
        id: 'template-1',
        name: 'Standard Service Agreement',
        description: 'Basic service agreement for standard customers',
        isDefault: true,
        items: [
          AgreementItemTemplate(
            id: 'template-item-1-1',
            description: 'Basic Maintenance Service',
            productCode: 'BMS-001',
            defaultUnitPrice: 250.00,
            unit: 'month',
            defaultTax: 7.5,
          ),
          AgreementItemTemplate(
            id: 'template-item-1-2',
            description: 'Emergency Response Service',
            productCode: 'ERS-001',
            defaultUnitPrice: 150.00,
            unit: 'incident',
            defaultTax: 7.5,
          ),
        ],
        terms: 'Standard terms and conditions apply. Service provided during business hours only.',
        category: 'Standard',
      ),
      AgreementTemplate(
        id: 'template-2',
        name: 'Premium Service Agreement',
        description: 'Enhanced service agreement for premium customers',
        items: [
          AgreementItemTemplate(
            id: 'template-item-2-1',
            description: 'Premium Maintenance Service',
            productCode: 'PMS-001',
            defaultUnitPrice: 500.00,
            unit: 'month',
            defaultTax: 7.5,
          ),
          AgreementItemTemplate(
            id: 'template-item-2-2',
            description: '24/7 Emergency Response',
            productCode: 'ERS-002',
            defaultUnitPrice: 250.00,
            unit: 'incident',
            defaultTax: 7.5,
          ),
          AgreementItemTemplate(
            id: 'template-item-2-3',
            description: 'Quarterly Inspection',
            productCode: 'QI-001',
            defaultUnitPrice: 350.00,
            unit: 'quarter',
            defaultTax: 7.5,
          ),
        ],
        terms: 'Premium terms and conditions apply. 24/7 service coverage included.',
        category: 'Premium',
      ),
      AgreementTemplate(
        id: 'template-3',
        name: 'Enterprise Service Agreement',
        description: 'Comprehensive service agreement for enterprise customers',
        items: [
          AgreementItemTemplate(
            id: 'template-item-3-1',
            description: 'Enterprise Maintenance Service',
            productCode: 'EMS-001',
            defaultUnitPrice: 1000.00,
            unit: 'month',
            defaultTax: 7.5,
          ),
          AgreementItemTemplate(
            id: 'template-item-3-2',
            description: 'Priority Emergency Response',
            productCode: 'ERS-003',
            defaultUnitPrice: 350.00,
            unit: 'incident',
            defaultTax: 7.5,
          ),
          AgreementItemTemplate(
            id: 'template-item-3-3',
            description: 'Monthly Inspection',
            productCode: 'MI-001',
            defaultUnitPrice: 450.00,
            unit: 'month',
            defaultTax: 7.5,
          ),
          AgreementItemTemplate(
            id: 'template-item-3-4',
            description: 'Dedicated Account Manager',
            productCode: 'DAM-001',
            defaultUnitPrice: 750.00,
            unit: 'month',
            defaultTax: 7.5,
          ),
        ],
        terms: 'Enterprise terms and conditions apply. Dedicated account manager included.',
        category: 'Enterprise',
      ),
    ];
  }
  
  // Generate a list of mock agreements for demo purposes
  static List<Agreement> getAgreements() {
    return [
      // Active agreements
      Agreement(
        id: 'agr-001',
        customerId: '0a471a5b',
        customerName: 'אלכסנדר גרינברג',
        title: 'Standard Maintenance Agreement',
        status: 'active',
        type: 'standard',
        createdAt: DateTime(2022, 11, 15),
        effectiveDate: DateTime(2023, 1, 1),
        expirationDate: DateTime(2024, 12, 31),
        value: 5000.00,
        createdBy: 'John Doe',
        approvedBy: 'Jane Smith',
        approvedDate: DateTime(2022, 12, 20),
        signedBy: 'אלכסנדר גרינברג',
        signedDate: DateTime(2022, 12, 22),
        items: [
          AgreementItem(
            id: 'agr-001-item-1',
            description: 'Basic Maintenance Service',
            productCode: 'BMS-001',
            unitPrice: 250.00,
            quantity: 12.0,
            unit: 'month',
            tax: 7.5,
          ),
          AgreementItem(
            id: 'agr-001-item-2',
            description: 'Emergency Response Service',
            productCode: 'ERS-001',
            unitPrice: 150.00,
            quantity: 10.0,
            unit: 'incident',
            tax: 7.5,
          ),
        ],
        notes: 'Annual review scheduled for Q3 2023',
        history: [
          AgreementHistory(
            id: 'hist-001-1',
            timestamp: DateTime(2022, 11, 15),
            action: 'created',
            userId: 'user-001',
            userName: 'John Doe',
          ),
          AgreementHistory(
            id: 'hist-001-2',
            timestamp: DateTime(2022, 12, 20),
            action: 'approved',
            userId: 'user-002',
            userName: 'Jane Smith',
          ),
          AgreementHistory(
            id: 'hist-001-3',
            timestamp: DateTime(2022, 12, 22),
            action: 'signed',
            userId: 'customer-001',
            userName: 'אלכסנדר גרינברג',
          ),
        ],
      ),
      Agreement(
        id: 'agr-002',
        customerId: 'ba383dda',
        customerName: 'אלכסנדר גרינברג',
        title: 'Premium Support Contract',
        status: 'active',
        type: 'premium',
        createdAt: DateTime(2023, 2, 10),
        effectiveDate: DateTime(2023, 3, 1),
        expirationDate: DateTime(2025, 2, 28),
        value: 12000.00,
        createdBy: 'Sarah Johnson',
        approvedBy: 'Michael Brown',
        approvedDate: DateTime(2023, 2, 20),
        signedBy: 'אלכסנדר גרינברג',
        signedDate: DateTime(2023, 2, 25),
        items: [
          AgreementItem(
            id: 'agr-002-item-1',
            description: 'Premium Maintenance Service',
            productCode: 'PMS-001',
            unitPrice: 500.00,
            quantity: 24.0,
            unit: 'month',
            tax: 7.5,
          ),
        ],
        notes: 'Customer requested quarterly performance reports',
      ),
      Agreement(
        id: 'agr-003',
        customerId: '343bc3b5',
        customerName: 'TEST',
        title: 'Enterprise Service Package',
        status: 'active',
        type: 'custom',
        createdAt: DateTime(2023, 4, 5),
        effectiveDate: DateTime(2023, 5, 1),
        expirationDate: DateTime(2026, 4, 30),
        value: 36000.00,
        createdBy: 'Emily Williams',
        approvedBy: 'David Miller',
        approvedDate: DateTime(2023, 4, 20),
        signedBy: 'TEST Representative',
        signedDate: DateTime(2023, 4, 22),
        items: [
          AgreementItem(
            id: 'agr-003-item-1',
            description: 'Enterprise Maintenance',
            productCode: 'EMS-001',
            unitPrice: 1000.00,
            quantity: 36.0,
            unit: 'month',
            tax: 7.5,
          ),
        ],
      ),
      
      // Draft agreements
      Agreement(
        id: 'agr-004',
        customerId: '0442d8dd',
        customerName: 'Alex G',
        title: 'Standard Service Agreement',
        status: 'draft',
        type: 'standard',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        effectiveDate: DateTime.now().add(const Duration(days: 15)),
        expirationDate: DateTime.now().add(const Duration(days: 15 + 365)),
        value: 4500.00,
        createdBy: 'John Doe',
        items: [
          AgreementItem(
            id: 'agr-004-item-1',
            description: 'Basic Maintenance Service',
            productCode: 'BMS-001',
            unitPrice: 250.00,
            quantity: 12.0,
            unit: 'month',
            tax: 7.5,
          ),
          AgreementItem(
            id: 'agr-004-item-2',
            description: 'Emergency Response Service',
            productCode: 'ERS-001',
            unitPrice: 150.00,
            quantity: 10.0,
            unit: 'incident',
            tax: 7.5,
          ),
        ],
        notes: 'Awaiting final review before sending to customer',
      ),
      Agreement(
        id: 'agr-005',
        customerId: '117ecf8e',
        customerName: 'Alex G',
        title: 'Custom Equipment Agreement',
        status: 'draft',
        type: 'custom',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        effectiveDate: DateTime.now().add(const Duration(days: 20)),
        expirationDate: DateTime.now().add(const Duration(days: 20 + 730)),
        value: 18500.00,
        createdBy: 'Sarah Johnson',
        items: [
          AgreementItem(
            id: 'agr-005-item-1',
            description: 'Custom Equipment Maintenance',
            productCode: 'CEM-001',
            unitPrice: 750.00,
            quantity: 24.0,
            unit: 'month',
            tax: 7.5,
          ),
          AgreementItem(
            id: 'agr-005-item-2',
            description: 'Specialized Training',
            productCode: 'ST-001',
            unitPrice: 1200.00,
            quantity: 1.0,
            unit: 'session',
            tax: 7.5,
          ),
        ],
      ),
      
      // Expired agreements
      Agreement(
        id: 'agr-006',
        customerId: '8b743e60',
        customerName: 'Active',
        title: 'Limited Support Contract',
        status: 'expired',
        type: 'standard',
        createdAt: DateTime(2021, 3, 15),
        effectiveDate: DateTime(2021, 4, 1),
        expirationDate: DateTime(2022, 3, 31),
        value: 3600.00,
        createdBy: 'Michael Brown',
        approvedBy: 'David Miller',
        approvedDate: DateTime(2021, 3, 25),
        signedBy: 'Active Representative',
        signedDate: DateTime(2021, 3, 28),
        items: [
          AgreementItem(
            id: 'agr-006-item-1',
            description: 'Basic Support Package',
            productCode: 'BSP-001',
            unitPrice: 300.00,
            quantity: 12.0,
            unit: 'month',
            tax: 7.5,
          ),
        ],
        notes: 'Agreement expired, customer now on new contract AGR-002',
      ),
      Agreement(
        id: 'agr-007',
        customerId: 'd47417e3',
        customerName: 'מ.א.י שאיבות והובלות בע"מ',
        title: 'Annual Maintenance Agreement',
        status: 'expired',
        type: 'standard',
        createdAt: DateTime(2020, 5, 10),
        effectiveDate: DateTime(2020, 6, 1),
        expirationDate: DateTime(2021, 5, 31),
        value: 4200.00,
        createdBy: 'Emily Williams',
        approvedBy: 'Michael Brown',
        approvedDate: DateTime(2020, 5, 20),
        signedBy: 'מ.א.י Representative',
        signedDate: DateTime(2020, 5, 25),
        items: [
          AgreementItem(
            id: 'agr-007-item-1',
            description: 'Standard Maintenance Package',
            productCode: 'SMP-001',
            unitPrice: 350.00,
            quantity: 12.0,
            unit: 'month',
            tax: 7.5,
          ),
        ],
        notes: 'Customer declined renewal due to change in business needs',
      ),
    ];
  }
  
  // Get agreements for a specific customer
  static List<Agreement> getAgreementsForCustomer(String customerId) {
    return getAgreements().where((agreement) => agreement.customerId == customerId).toList();
  }
  
  // Get a single agreement by ID
  static Agreement? getAgreementById(String id) {
    try {
      return getAgreements().firstWhere((agreement) => agreement.id == id);
    } catch (e) {
      return null;
    }
  }
  
  // Generate random agreement items
  static List<AgreementItem> generateRandomItems() {
    final int itemCount = _random.nextInt(3) + 1; // 1-3 items
    final List<AgreementItem> items = [];
    
    for (int i = 0; i < itemCount; i++) {
      items.add(AgreementItem(
        id: 'item-${_random.nextInt(1000)}',
        description: _getRandomItemDescription(),
        productCode: 'P${_random.nextInt(100)}',
        unitPrice: (_random.nextInt(50) + 10) * 10.0, // 100-590
        quantity: (_random.nextInt(10) + 1).toDouble(), // 1-10
        unit: _getRandomUnit(),
        tax: 7.5,
      ));
    }
    
    return items;
  }
  
  // Helper method to get random item description
  static String _getRandomItemDescription() {
    final descriptions = [
      'Maintenance Service',
      'Equipment Support',
      'On-site Repairs',
      'Remote Monitoring',
      'Preventive Maintenance',
      'Emergency Support',
      'Parts Replacement',
      'Technical Consultation',
      'Software Updates',
      'Training Sessions',
    ];
    
    return descriptions[_random.nextInt(descriptions.length)];
  }
  
  // Helper method to get random unit
  static String _getRandomUnit() {
    final units = ['hour', 'day', 'month', 'year', 'incident', 'unit', 'service'];
    return units[_random.nextInt(units.length)];
  }
} 