import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/customer_models.dart';

class CustomerMockData {
  // Generate a list of mock customers matching the screenshots
  static List<Customer> getCustomers({String locale = 'en'}) {
    // For English language, use English names
    if (locale == 'en') {
      return [
        // First customer
        Customer(
          id: '0a471a5b',
          name: 'Alexander Greenberg',
          email: 'boq2828@gmail.com435',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'Raanana',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // Second customer
        Customer(
          id: 'ba383dda',
          name: 'Alexander Greenberg',
          email: 'aaaaaaaaaboq2828@gmail.com',
          status: 'active',
          type: 'business',
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'Raanana',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // Third customer
        Customer(
          id: '0acb9c5b',
          name: 'Alexander Greenberg',
          email: 'boq2828@gmail.comdgfddg',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'Raanana',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // Fourth customer
        Customer(
          id: 'dad68b9b',
          name: 'Alexander Greenberg',
          email: 'boq2828@gmail.comdfhg',
          status: 'active',
          type: 'business',
          tier: 'standard',
          businessType: 'concrete-pumping',
          address: 'Raanana',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // TEST account
        Customer(
          id: '343bc3b5',
          name: 'TEST',
          email: 'testqqw12312@gmail.com',
          phone: '1135345',
          status: 'active',
          type: 'business',
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'Raanana',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Alex G first account
        Customer(
          id: '0442d8dd',
          name: 'Alex G',
          email: 'gera@gmail.com',
          phone: '12342135',
          status: 'active',
          type: 'business', 
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'N/A',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Alex G second account
        Customer(
          id: '117ecf8e',
          name: 'Alex G',
          email: 'test@ldsadsa.com',
          phone: '1234231',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'N/A',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Ron David Love
        Customer(
          id: 'db3185b2',
          name: 'Ron David Love',
          email: 'ronlo4534543ve54310@gmail.com',
          phone: 'N/A',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'Morris Fisher 19, Jerusalem',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Active account
        Customer(
          id: '8b743460',
          name: 'Active',
          email: 'active@gmail.com',
          phone: '1232141',
          status: 'active',
          type: 'business',
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'Raanana',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-13'),
        ),
        
        // M.A. Shipments
        Customer(
          id: 'd4741e3',
          name: 'M.A. Shipments & Haulage Ltd.',
          email: 'office@office.com',
          phone: '0546254887',
          status: 'active',
          type: 'business',
          tier: 'standard',
          businessType: 'concrete-pumping',
          address: 'Raanana',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-02'),
        ),
        
        // Harmoneat Ltd.
        Customer(
          id: '5f5c8136',
          name: 'Harmoneat Ltd.',
          email: 'boq2828@gmail.com',
          phone: '+972-3-1234567',
          status: 'active',
          type: 'business',
          tier: 'standard',
          businessType: 'concrete-pumping',
          address: 'Tel Aviv, Dizengoff 12',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-01'),
        ),
      ];
    }
    
    // For Hebrew language, use Hebrew names
    else if (locale == 'he') {
      return [
        // First customer (appears in detail view)
        Customer(
          id: '0a471a5b',
          name: 'אלכסנדר גרינברג', // Alexander Greenberg in Hebrew
          email: 'boq2828@gmail.com435',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'רעננה', // Raanana in Hebrew
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // Second customer (similar email with multiple a's)
        Customer(
          id: 'ba383dda',
          name: 'אלכסנדר גרינברג',
          email: 'aaaaaaaaaboq2828@gmail.com',
          status: 'active',
          type: 'business',
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'רעננה',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // Third customer (with different suffix)
        Customer(
          id: '0acb9c5b',
          name: 'אלכסנדר גרינברג',
          email: 'boq2828@gmail.comdgfddg',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'רעננה',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // Fourth customer (with different suffix)
        Customer(
          id: 'dad68b9b',
          name: 'אלכסנדר גרינברג',
          email: 'boq2828@gmail.comdfhg',
          status: 'active',
          type: 'business',
          tier: 'standard',
          businessType: 'concrete-pumping',
          address: 'רעננה',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // TEST account
        Customer(
          id: '343bc3b5',
          name: 'בדיקה',
          email: 'testqqw12312@gmail.com',
          phone: '1135345',
          status: 'active',
          type: 'business',
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'רעננה',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Alex G first account
        Customer(
          id: '0442d8dd',
          name: 'אלכס ג',
          email: 'gera@gmail.com',
          phone: '12342135',
          status: 'active',
          type: 'business', 
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'לא זמין',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Alex G second account
        Customer(
          id: '117ecf8e',
          name: 'אלכס ג',
          email: 'test@ldsadsa.com',
          phone: '1234231',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'לא זמין',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Ron David Love
        Customer(
          id: 'db3185b2',
          name: 'רון דוד לב',
          email: 'ronlo4534543ve54310@gmail.com',
          phone: 'לא זמין',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'מוריס פישר 19 ירושלים',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Active account
        Customer(
          id: '8b743460',
          name: 'פעיל',
          email: 'active@gmail.com',
          phone: '1232141',
          status: 'active',
          type: 'business',
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'רעננה',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-13'),
        ),
        
        // M.A. Shipments and Haulage
        Customer(
          id: 'd4741e3',
          name: 'מ.א. שינוע והובלות בע"מ',
          email: 'office@office.com',
          phone: '0546254887',
          status: 'active',
          type: 'business',
          tier: 'standard',
          businessType: 'concrete-pumping',
          address: 'רעננה',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-02'),
        ),
        
        // Harmoneat Ltd.
        Customer(
          id: '5f5c8136',
          name: 'הרמוניט בע"מ',
          email: 'boq2828@gmail.com',
          phone: '+972-3-1234567',
          status: 'active',
          type: 'business',
          tier: 'standard',
          businessType: 'concrete-pumping',
          address: 'תל אביב, דיזנגוף 12',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-01'),
        ),
      ];
    }
    
    // For Arabic language, use Arabic names
    else if (locale == 'ar') {
      return [
        // First customer (appears in detail view)
        Customer(
          id: '0a471a5b',
          name: 'ألكسندر غرينبرغ', // Alexander Greenberg in Arabic
          email: 'boq2828@gmail.com435',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'رعنانا', // Raanana in Arabic
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // Second customer (similar email with multiple a's)
        Customer(
          id: 'ba383dda',
          name: 'ألكسندر غرينبرغ',
          email: 'aaaaaaaaaboq2828@gmail.com',
          status: 'active',
          type: 'business',
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'رعنانا',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // Third customer (with different suffix)
        Customer(
          id: '0acb9c5b',
          name: 'ألكسندر غرينبرغ',
          email: 'boq2828@gmail.comdgfddg',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'رعنانا',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // Fourth customer (with different suffix)
        Customer(
          id: 'dad68b9b',
          name: 'ألكسندر غرينبرغ',
          email: 'boq2828@gmail.comdfhg',
          status: 'active',
          type: 'business',
          tier: 'standard',
          businessType: 'concrete-pumping',
          address: 'رعنانا',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-09'),
        ),
        
        // TEST account
        Customer(
          id: '343bc3b5',
          name: 'اختبار',
          email: 'testqqw12312@gmail.com',
          phone: '1135345',
          status: 'active',
          type: 'business',
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'رعنانا',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Alex G first account
        Customer(
          id: '0442d8dd',
          name: 'أليكس ج',
          email: 'gera@gmail.com',
          phone: '12342135',
          status: 'active',
          type: 'business', 
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'غير متوفر',
          needsAgreement: false,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Alex G second account
        Customer(
          id: '117ecf8e',
          name: 'أليكس ج',
          email: 'test@ldsadsa.com',
          phone: '1234231',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'غير متوفر',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Ron David Love
        Customer(
          id: 'db3185b2',
          name: 'رون ديفيد لوف',
          email: 'ronlo4534543ve54310@gmail.com',
          phone: 'غير متوفر',
          status: 'active',
          type: 'business',
          tier: 'premium',
          businessType: 'concrete-pumping',
          address: 'موريس فيشر 19 القدس',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-10'),
        ),
        
        // Active account
        Customer(
          id: '8b743460',
          name: 'نشط',
          email: 'active@gmail.com',
          phone: '1232141',
          status: 'active',
          type: 'business',
          tier: 'elite',
          businessType: 'concrete-pumping',
          address: 'رعنانا',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-13'),
        ),
        
        // M.A. Shipments and Haulage
        Customer(
          id: 'd4741e3',
          name: 'م.أ. للشحن والنقل',
          email: 'office@office.com',
          phone: '0546254887',
          status: 'active',
          type: 'business',
          tier: 'standard',
          businessType: 'concrete-pumping',
          address: 'رعنانا',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-02'),
        ),
        
        // Harmoneat Ltd.
        Customer(
          id: '5f5c8136',
          name: 'هارمونيت المحدودة',
          email: 'boq2828@gmail.com',
          phone: '+972-3-1234567',
          status: 'active',
          type: 'business',
          tier: 'standard',
          businessType: 'concrete-pumping',
          address: 'تل أبيب، ديزنغوف 12',
          needsAgreement: true,
          lastActivity: DateTime.parse('2023-05-01'),
        ),
      ];
    }
    
    // Default to English if no locale is specified or locale is not supported
    return [
      // First customer
      Customer(
        id: '0a471a5b',
        name: 'Alexander Greenberg',
        email: 'boq2828@gmail.com435',
        status: 'active',
        type: 'business',
        tier: 'premium',
        businessType: 'concrete-pumping',
        address: 'Raanana',
        needsAgreement: false,
        lastActivity: DateTime.parse('2023-05-09'),
      ),
      
      // Remaining English customers (duplicated from above)
      Customer(
        id: 'ba383dda',
        name: 'Alexander Greenberg',
        email: 'aaaaaaaaaboq2828@gmail.com',
        status: 'active',
        type: 'business',
        tier: 'elite',
        businessType: 'concrete-pumping',
        address: 'Raanana',
        needsAgreement: false,
        lastActivity: DateTime.parse('2023-05-09'),
      ),
      
      Customer(
        id: '0acb9c5b',
        name: 'Alexander Greenberg',
        email: 'boq2828@gmail.comdgfddg',
        status: 'active',
        type: 'business',
        tier: 'premium',
        businessType: 'concrete-pumping',
        address: 'Raanana',
        needsAgreement: true,
        lastActivity: DateTime.parse('2023-05-09'),
      ),
      
      Customer(
        id: 'dad68b9b',
        name: 'Alexander Greenberg',
        email: 'boq2828@gmail.comdfhg',
        status: 'active',
        type: 'business',
        tier: 'standard',
        businessType: 'concrete-pumping',
        address: 'Raanana',
        needsAgreement: false,
        lastActivity: DateTime.parse('2023-05-09'),
      ),
      
      Customer(
        id: '343bc3b5',
        name: 'TEST',
        email: 'testqqw12312@gmail.com',
        phone: '1135345',
        status: 'active',
        type: 'business',
        tier: 'elite',
        businessType: 'concrete-pumping',
        address: 'Raanana',
        needsAgreement: true,
        lastActivity: DateTime.parse('2023-05-10'),
      ),
      
      Customer(
        id: '0442d8dd',
        name: 'Alex G',
        email: 'gera@gmail.com',
        phone: '12342135',
        status: 'active',
        type: 'business', 
        tier: 'elite',
        businessType: 'concrete-pumping',
        address: 'N/A',
        needsAgreement: false,
        lastActivity: DateTime.parse('2023-05-10'),
      ),
    ];
  }

  // Generate detailed metrics for a specific customer
  static CustomerMetrics getCustomerMetrics(String customerId) {
    // For the demo, return the same metrics for any customer
    return CustomerMetrics(
      thisMonthRevenue: 3250.50,
      lastMonthRevenue: 4120.25,
      changePercent: -12.0,
      satisfactionScore: 4.7,
      totalServiceCalls: 0,
      totalCertificates: 0,
      totalAgreements: 0,
      totalDisputes: 0,
      activeAgreements: 0,
      pendingCertificates: 0,
      completedServiceCalls: 0,
      openDisputes: 0,
    );
  }
  
  // Get document categories for the document library
  static List<DocumentCategory> getDocumentCategories() {
    return [
      DocumentCategory(
        name: 'Price Agreements',
        documentCount: 3,
        icon: LucideIcons.fileText,
        color: Colors.blue,
      ),
      DocumentCategory(
        name: 'Service Calls',
        documentCount: 8,
        icon: LucideIcons.calendarClock,
        color: Colors.green,
      ),
      DocumentCategory(
        name: 'Delivery Certificates',
        documentCount: 5,
        icon: LucideIcons.award,
        color: Colors.orange,
      ),
      DocumentCategory(
        name: 'Reports',
        documentCount: 2,
        icon: LucideIcons.clipboardList,
        color: Colors.purple,
      ),
      DocumentCategory(
        name: 'Invoices',
        documentCount: 7,
        icon: LucideIcons.receipt,
        color: Colors.red,
      ),
    ];
  }
  
  // Get disputes for a specific customer
  static List<Dispute> getCustomerDisputes(String customerId) {
    // For the demo, return empty list - screenshot shows no disputes
    return [];
  }
  
  // Get agreements for a specific customer
  static List<Agreement> getCustomerAgreements(String customerId) {
    // For the demo, return empty list - screenshot shows no agreements
    return [];
  }
  
  // Get service history for a specific customer
  static List<ServiceCall> getCustomerServiceCalls(String customerId) {
    // For the demo, return empty list - screenshot shows no service history
    return [];
  }
  
  // Get certificates for a specific customer
  static List<ServiceCertificate> getCustomerCertificates(String customerId) {
    // For the demo, return empty list - screenshot shows no certificates
    return [];
  }
} 