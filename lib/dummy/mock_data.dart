import 'models/customer.dart';
import 'models/quote.dart';
import 'models/invoice.dart';
import 'models/activity.dart';

class MockData {
  static final List<Customer> customers = [
    Customer(
      id: '1',
      name: 'Acme Corporation',
      nickname: 'Acme',
      email: 'contact@acme.com',
      phone: '+1 (555) 123-4567',
      officePhone: '+1 (555) 987-6543',
      address: '123 Main St, New York, NY 10001',
      address2: 'Suite 500',
      type: 'business',
      status: 'active',
      createdAt: DateTime.parse('2023-06-15T10:00:00Z'),
      updatedAt: DateTime.parse('2023-09-20T14:30:00Z'),
      avatarUrl: null,
      needsQuote: true,
      customerId: 'ACME001',
      contactName: 'John Smith',
      lastActive: DateTime.parse('2023-11-05T09:30:00Z'),
    ),
    Customer(
      id: '2',
      name: 'TechNova Solutions',
      nickname: 'TechNova',
      email: 'info@technova.com',
      phone: '+1 (555) 234-5678',
      officePhone: '+1 (555) 876-5432',
      address: '456 Innovation Ave, San Francisco, CA 94107',
      address2: 'Floor 3',
      type: 'business',
      status: 'active',
      createdAt: DateTime.parse('2023-07-22T09:15:00Z'),
      updatedAt: DateTime.parse('2023-10-05T11:45:00Z'),
      avatarUrl: null,
      needsQuote: false,
      customerId: 'TECH002',
      contactName: 'Sarah Johnson',
      lastActive: DateTime.parse('2023-12-10T14:20:00Z'),
    ),
    Customer(
      id: '3',
      name: 'Green Earth Landscaping',
      nickname: 'Green Earth',
      email: 'contact@greenearth.com',
      phone: '+1 (555) 345-6789',
      officePhone: '+1 (555) 765-4321',
      address: '789 Green St, Portland, OR 97201',
      address2: '',
      type: 'business',
      status: 'active',
      createdAt: DateTime.parse('2023-08-10T13:20:00Z'),
      updatedAt: DateTime.parse('2023-10-12T16:10:00Z'),
      avatarUrl: null,
      needsQuote: false,
      customerId: 'GREEN003',
      contactName: 'Michael Brown',
      lastActive: DateTime.parse('2023-12-15T11:45:00Z'),
    ),
  ];

  static final List<Quote> quotes = [
    Quote(
      id: '1',
      customerId: 'ACME001',
      status: 'pending',
      total: 15000.00,
      createdAt: DateTime.parse('2023-11-01T09:00:00Z'),
      updatedAt: DateTime.parse('2023-11-01T09:00:00Z'),
      items: [
        QuoteItem(
          id: '1',
          name: 'Document Management System',
          quantity: 1,
          price: 10000.00,
          description: 'Enterprise document management solution',
        ),
        QuoteItem(
          id: '2',
          name: 'Training Sessions',
          quantity: 5,
          price: 1000.00,
          description: 'On-site training for staff',
        ),
      ],
    ),
    Quote(
      id: '2',
      customerId: 'TECH002',
      status: 'approved',
      total: 25000.00,
      createdAt: DateTime.parse('2023-11-15T10:30:00Z'),
      updatedAt: DateTime.parse('2023-11-20T14:00:00Z'),
      items: [
        QuoteItem(
          id: '3',
          name: 'Cloud Storage Solution',
          quantity: 1,
          price: 20000.00,
          description: 'Enterprise cloud storage with backup',
        ),
        QuoteItem(
          id: '4',
          name: 'Security Audit',
          quantity: 1,
          price: 5000.00,
          description: 'Annual security assessment',
        ),
      ],
    ),
  ];

  static final List<Invoice> invoices = [
    Invoice(
      id: '1',
      quoteId: '2',
      customerId: 'TECH002',
      status: 'paid',
      total: 25000.00,
      dueDate: DateTime.parse('2023-12-20T00:00:00Z'),
      paidDate: DateTime.parse('2023-12-15T09:30:00Z'),
      createdAt: DateTime.parse('2023-11-20T14:00:00Z'),
    ),
    Invoice(
      id: '2',
      quoteId: '1',
      customerId: 'ACME001',
      status: 'pending',
      total: 15000.00,
      dueDate: DateTime.parse('2023-12-25T00:00:00Z'),
      paidDate: null,
      createdAt: DateTime.parse('2023-12-01T10:00:00Z'),
    ),
  ];

  static final List<Activity> activities = [
    Activity(
      id: '1',
      customerId: 'ACME001',
      type: 'quote_created',
      description: 'New quote created for Document Management System',
      createdAt: DateTime.parse('2023-11-01T09:00:00Z'),
    ),
    Activity(
      id: '2',
      customerId: 'TECH002',
      type: 'invoice_paid',
      description: 'Invoice #1 paid for Cloud Storage Solution',
      createdAt: DateTime.parse('2023-12-15T09:30:00Z'),
    ),
    Activity(
      id: '3',
      customerId: 'GREEN003',
      type: 'meeting_scheduled',
      description: 'Scheduled meeting to discuss landscaping project',
      createdAt: DateTime.parse('2023-12-10T14:00:00Z'),
    ),
  ];
} 