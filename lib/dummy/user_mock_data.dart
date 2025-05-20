import 'package:flutter/material.dart';
import 'package:unidoc/models/user.dart';
import 'package:lucide_icons/lucide_icons.dart';

class UserMockData {
  static List<User> getUsers() {
    return [
      // User 1
      User(
        id: '1',
        name: 'Unnamed User',
        email: 'boq2828@gmail.com',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-01'),
        phone: '+1234567890',
        address: '123 Main St, Anytown',
        completedJobs: 32,
        averageRating: 4.8,
        openTasks: 3,
        documentsSubmitted: 12,
        permissions: [
          UserPermission(
            id: '1',
            name: 'View Own Data',
            category: 'Dashboard Access',
            isEnabled: true,
          ),
          UserPermission(
            id: '2',
            name: 'View Reports',
            category: 'Dashboard Access',
            isEnabled: true,
          ),
          UserPermission(
            id: '3',
            name: 'View Schedule',
            category: 'Dashboard Access',
            isEnabled: true,
          ),
          UserPermission(
            id: '4',
            name: 'View Invoices',
            category: 'Dashboard Access',
            isEnabled: false,
          ),
          UserPermission(
            id: '5',
            name: 'View Analytics',
            category: 'Dashboard Access',
            isEnabled: false,
          ),
          UserPermission(
            id: '6',
            name: 'Request Service',
            category: 'Schedule Management',
            isEnabled: false,
          ),
          UserPermission(
            id: '7',
            name: 'View Own Schedule',
            category: 'Schedule Management',
            isEnabled: true,
          ),
          UserPermission(
            id: '8',
            name: 'Edit Schedule',
            category: 'Schedule Management',
            isEnabled: false,
          ),
          UserPermission(
            id: '9',
            name: 'Approve Schedule',
            category: 'Schedule Management',
            isEnabled: false,
          ),
          UserPermission(
            id: '10',
            name: 'Manage Own Profile',
            category: 'User Management',
            isEnabled: true,
          ),
          UserPermission(
            id: '11',
            name: 'Invite Users',
            category: 'User Management',
            isEnabled: false,
          ),
          UserPermission(
            id: '12',
            name: 'Manage Users',
            category: 'User Management',
            isEnabled: false,
          ),
          UserPermission(
            id: '13',
            name: 'View Own Documents',
            category: 'Document Management',
            isEnabled: true,
          ),
          UserPermission(
            id: '14',
            name: 'Create Documents',
            category: 'Document Management',
            isEnabled: true,
          ),
          UserPermission(
            id: '15',
            name: 'Approve Documents',
            category: 'Document Management',
            isEnabled: false,
          ),
        ],
        documents: [
          UserDocument(
            id: '1',
            name: 'Employment Contract',
            type: 'Employment Documents',
            isRequired: true,
            uploadedDate: DateTime.parse('2023-05-01'),
          ),
          UserDocument(
            id: '2',
            name: 'ID Document',
            type: 'ID Documents',
            isRequired: true,
            uploadedDate: DateTime.parse('2023-05-01'),
          ),
          UserDocument(
            id: '3',
            name: 'Certifications',
            type: 'Training Certificates',
            isRequired: false,
            uploadedDate: DateTime.parse('2023-05-01'),
          ),
        ],
        serviceHistory: [
          ServiceRecord(
            id: '1',
            serviceNumber: 'SC-2023-089',
            clientName: 'Acme Corp',
            location: '123 Main St, Anytown',
            date: DateTime.parse('2023-11-05'),
            status: 'completed',
            description: 'Regular maintenance completed successfully',
          ),
          ServiceRecord(
            id: '2',
            serviceNumber: 'SC-2023-092',
            clientName: 'TechGiant Inc',
            location: '456 Tech Ave, Innovation City',
            date: DateTime.parse('2023-11-12'),
            status: 'completed',
            description: 'Equipment installation and testing',
          ),
          ServiceRecord(
            id: '3',
            serviceNumber: 'SC-2023-097',
            clientName: 'Stellar Systems',
            location: '789 Galaxy Blvd, Starville',
            date: DateTime.parse('2023-11-18'),
            status: 'scheduled',
            description: 'Quarterly systems check',
          ),
          ServiceRecord(
            id: '4',
            serviceNumber: 'SC-2023-103',
            clientName: 'Global Industries',
            location: '101 International Dr, Worldwide',
            date: DateTime.parse('2023-11-25'),
            status: 'cancelled',
            description: 'Annual maintenance review',
          ),
        ],
        communications: [
          Communication(
            id: '1',
            type: 'email',
            sender: 'System',
            subject: 'Schedule Confirmation',
            content: 'This email confirms your scheduled service call for tomorrow at 10:00 AM.',
            date: DateTime.parse('2023-11-25'),
            time: '15:30',
          ),
          Communication(
            id: '2',
            type: 'sms',
            sender: 'System',
            subject: '',
            content: 'Your technician is on the way and will arrive in approximately 20 minutes.',
            date: DateTime.parse('2023-11-20'),
            time: '09:45',
          ),
          Communication(
            id: '3',
            type: 'email',
            sender: 'Alex Thompson',
            subject: 'Service Report',
            content: 'Please find attached the detailed service report from your recent maintenance visit.',
            date: DateTime.parse('2023-11-18'),
            time: '14:15',
          ),
        ],
        agreements: [
          UserAgreement(
            id: '1',
            name: 'Service Agreement 2023',
            date: DateTime.parse('2023-01-15'),
            type: 'Service',
            client: 'Acme Corp',
            status: 'active',
          ),
          UserAgreement(
            id: '2',
            name: 'Equipment Rental Contract',
            date: DateTime.parse('2023-06-22'),
            type: 'Rental',
            client: 'TechGiant Inc',
            status: 'active',
          ),
          UserAgreement(
            id: '3',
            name: 'Maintenance Agreement Q4',
            date: DateTime.parse('2023-10-01'),
            type: 'Maintenance',
            client: 'Stellar Systems',
            status: 'pending',
          ),
        ],
      ),
      
      // User 2
      User(
        id: '2',
        name: 'Unnamed User',
        email: 'office@office.com',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-02'),
        status: 'active',
      ),
      
      // User 3
      User(
        id: '3',
        name: 'Unnamed User',
        email: 'boq2828@gmail.com435',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-09'),
        status: 'active',
      ),
      
      // User 4
      User(
        id: '4',
        name: 'Unnamed User',
        email: 'aaaaaaaaaboq2828@gmail.com',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-09'),
        status: 'active',
      ),
      
      // User 5
      User(
        id: '5',
        name: 'Unnamed User',
        email: 'boq2828@gmail.comdfgfddg',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-09'),
        status: 'active',
      ),
      
      // User 6
      User(
        id: '6',
        name: 'Unnamed User',
        email: 'boq2828@gmail.comdfhg',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-09'),
        status: 'active',
      ),
      
      // User 7
      User(
        id: '7',
        name: 'Unnamed User',
        email: 'testqqw12312@gmail.com',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-10'),
        status: 'active',
      ),
      
      // User 8
      User(
        id: '8',
        name: 'Unnamed User',
        email: 'gera@gmail.com',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-10'),
        status: 'active',
      ),
      
      // User 9
      User(
        id: '9',
        name: 'Unnamed User',
        email: 'test@ldsadsa.com',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-10'),
        status: 'active',
      ),
      
      // User 10
      User(
        id: '10',
        name: 'Unnamed User',
        email: 'ronlo4534543ve54310@gmail.com',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-10'),
        status: 'active',
      ),
      
      // User 11
      User(
        id: '11',
        name: 'Unnamed User',
        email: 'active@gmail.com',
        role: 'Employee',
        lastActive: DateTime.parse('2025-05-13'),
        status: 'active',
      ),
    ];
  }
  
  static List<String> userRoles = [
    'Employee',
    'Client',
    'Foreman',
    'Subcontractor',
    'Supplier-Client',
  ];
  
  static List<UserPermission> getDefaultPermissions(String role) {
    if (role == 'Employee') {
      return [
        UserPermission(
          id: '1',
          name: 'View Own Data',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '2',
          name: 'View Reports',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '3',
          name: 'View Schedule',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '4',
          name: 'View Invoices',
          category: 'Dashboard Access',
          isEnabled: false,
        ),
        UserPermission(
          id: '5',
          name: 'View Analytics',
          category: 'Dashboard Access',
          isEnabled: false,
        ),
        UserPermission(
          id: '6',
          name: 'Request Service',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '7',
          name: 'View Own Schedule',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '8',
          name: 'Edit Schedule',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '9',
          name: 'Approve Schedule',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '10',
          name: 'Manage Own Profile',
          category: 'User Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '11',
          name: 'Invite Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '12',
          name: 'Manage Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '13',
          name: 'View Own Documents',
          category: 'Document Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '14',
          name: 'Create Documents',
          category: 'Document Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '15',
          name: 'Approve Documents',
          category: 'Document Management',
          isEnabled: false,
        ),
      ];
    } else if (role == 'Client') {
      return [
        UserPermission(
          id: '1',
          name: 'View Own Data',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '2',
          name: 'View Reports',
          category: 'Dashboard Access',
          isEnabled: false,
        ),
        UserPermission(
          id: '3',
          name: 'View Schedule',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '4',
          name: 'View Invoices',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '5',
          name: 'View Analytics',
          category: 'Dashboard Access',
          isEnabled: false,
        ),
        UserPermission(
          id: '6',
          name: 'Request Service',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '7',
          name: 'View Own Schedule',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '8',
          name: 'Edit Schedule',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '9',
          name: 'Approve Schedule',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '10',
          name: 'Manage Own Profile',
          category: 'User Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '11',
          name: 'Invite Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '12',
          name: 'Manage Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '13',
          name: 'View Own Documents',
          category: 'Document Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '14',
          name: 'Create Documents',
          category: 'Document Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '15',
          name: 'Approve Documents',
          category: 'Document Management',
          isEnabled: false,
        ),
      ];
    } else if (role == 'Foreman') {
      return [
        UserPermission(
          id: '1',
          name: 'View Own Data',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '2',
          name: 'View Reports',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '3',
          name: 'View Schedule',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '4',
          name: 'View Invoices',
          category: 'Dashboard Access',
          isEnabled: false,
        ),
        UserPermission(
          id: '5',
          name: 'View Analytics',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '6',
          name: 'Request Service',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '7',
          name: 'View Own Schedule',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '8',
          name: 'Edit Schedule',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '9',
          name: 'Approve Schedule',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '10',
          name: 'Manage Own Profile',
          category: 'User Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '11',
          name: 'Invite Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '12',
          name: 'Manage Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '13',
          name: 'View Own Documents',
          category: 'Document Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '14',
          name: 'Create Documents',
          category: 'Document Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '15',
          name: 'Approve Documents',
          category: 'Document Management',
          isEnabled: false,
        ),
      ];
    } else if (role == 'Subcontractor') {
      return [
        UserPermission(
          id: '1',
          name: 'View Own Data',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '2',
          name: 'View Reports',
          category: 'Dashboard Access',
          isEnabled: false,
        ),
        UserPermission(
          id: '3',
          name: 'View Schedule',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '4',
          name: 'View Invoices',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '5',
          name: 'View Analytics',
          category: 'Dashboard Access',
          isEnabled: false,
        ),
        UserPermission(
          id: '6',
          name: 'Request Service',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '7',
          name: 'View Own Schedule',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '8',
          name: 'Edit Schedule',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '9',
          name: 'Approve Schedule',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '10',
          name: 'Manage Own Profile',
          category: 'User Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '11',
          name: 'Invite Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '12',
          name: 'Manage Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '13',
          name: 'View Own Documents',
          category: 'Document Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '14',
          name: 'Create Documents',
          category: 'Document Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '15',
          name: 'Approve Documents',
          category: 'Document Management',
          isEnabled: false,
        ),
      ];
    } else {
      // Default or Supplier-Client
      return [
        UserPermission(
          id: '1',
          name: 'View Own Data',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '2',
          name: 'View Reports',
          category: 'Dashboard Access',
          isEnabled: false,
        ),
        UserPermission(
          id: '3',
          name: 'View Schedule',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '4',
          name: 'View Invoices',
          category: 'Dashboard Access',
          isEnabled: true,
        ),
        UserPermission(
          id: '5',
          name: 'View Analytics',
          category: 'Dashboard Access',
          isEnabled: false,
        ),
        UserPermission(
          id: '6',
          name: 'Request Service',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '7',
          name: 'View Own Schedule',
          category: 'Schedule Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '8',
          name: 'Edit Schedule',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '9',
          name: 'Approve Schedule',
          category: 'Schedule Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '10',
          name: 'Manage Own Profile',
          category: 'User Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '11',
          name: 'Invite Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '12',
          name: 'Manage Users',
          category: 'User Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '13',
          name: 'View Own Documents',
          category: 'Document Management',
          isEnabled: true,
        ),
        UserPermission(
          id: '14',
          name: 'Create Documents',
          category: 'Document Management',
          isEnabled: false,
        ),
        UserPermission(
          id: '15',
          name: 'Approve Documents',
          category: 'Document Management',
          isEnabled: false,
        ),
      ];
    }
  }
  
  static List<UserDocument> getRequiredDocuments(String role) {
    if (role == 'Employee') {
      return [
        UserDocument(
          id: '1',
          name: 'Employment Contract',
          type: 'Employment Documents',
          isRequired: true,
          uploadedDate: null,
        ),
        UserDocument(
          id: '2',
          name: 'ID Document',
          type: 'ID Documents',
          isRequired: true,
          uploadedDate: null,
        ),
        UserDocument(
          id: '3',
          name: 'Certifications',
          type: 'Training Certificates',
          isRequired: false,
          uploadedDate: null,
        ),
      ];
    } else if (role == 'Client') {
      return [
        UserDocument(
          id: '1',
          name: 'Service Agreement',
          type: 'Agreement Documents',
          isRequired: true,
          uploadedDate: null,
        ),
        UserDocument(
          id: '2',
          name: 'Company Registration',
          type: 'Business Documents',
          isRequired: true,
          uploadedDate: null,
        ),
      ];
    } else if (role == 'Foreman') {
      return [
        UserDocument(
          id: '1',
          name: 'Employment Contract',
          type: 'Employment Documents',
          isRequired: true,
          uploadedDate: null,
        ),
        UserDocument(
          id: '2',
          name: 'ID Document',
          type: 'ID Documents',
          isRequired: true,
          uploadedDate: null,
        ),
        UserDocument(
          id: '3',
          name: 'Certifications',
          type: 'Training Certificates',
          isRequired: true,
          uploadedDate: null,
        ),
        UserDocument(
          id: '4',
          name: 'Safety Training',
          type: 'Training Certificates',
          isRequired: true,
          uploadedDate: null,
        ),
      ];
    } else if (role == 'Subcontractor') {
      return [
        UserDocument(
          id: '1',
          name: 'Service Agreement',
          type: 'Agreement Documents',
          isRequired: true,
          uploadedDate: null,
        ),
        UserDocument(
          id: '2',
          name: 'Insurance Certificate',
          type: 'Business Documents',
          isRequired: true,
          uploadedDate: null,
        ),
        UserDocument(
          id: '3',
          name: 'Business License',
          type: 'Business Documents',
          isRequired: true,
          uploadedDate: null,
        ),
      ];
    } else {
      // Default or Supplier-Client
      return [
        UserDocument(
          id: '1',
          name: 'Service Agreement',
          type: 'Agreement Documents',
          isRequired: true,
          uploadedDate: null,
        ),
        UserDocument(
          id: '2',
          name: 'Company Profile',
          type: 'Business Documents',
          isRequired: true,
          uploadedDate: null,
        ),
      ];
    }
  }
} 