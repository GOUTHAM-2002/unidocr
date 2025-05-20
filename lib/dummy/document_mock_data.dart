import 'package:unidoc/models/document_models.dart';

class DocumentMockData {
  // Get all documents
  static List<Document> getDocuments() {
    return [
      ...getServiceCallDocuments(),
      ...getDeliveryCertificateDocuments(),
      ...getReportDocuments(),
    ];
  }
  
  // Get service call documents
  static List<Document> getServiceCallDocuments() {
    return [
      Document(
        id: 'SC-2817',
        title: 'Service Call - ABC Construction',
        type: DocumentType.serviceCall,
        status: DocumentStatus.scheduled,
        createdAt: DateTime(2025, 5, 16),
        updatedAt: DateTime(2025, 5, 16),
        customerId: 'customer-001',
        customerName: 'ABC Construction',
        createdBy: 'Admin User',
        description: 'Regular maintenance service call',
        metadata: {
          'serviceType': 'Concrete Pumping',
          'operator': 'john doe',
          'serviceHours': 4,
          'serviceDate': '5/18/2025',
          'projectSite': 'Site 123',
        },
      ),
      Document(
        id: 'SC-2840',
        title: 'Service Call - Peak Construction',
        type: DocumentType.serviceCall,
        status: DocumentStatus.inProgress,
        createdAt: DateTime(2025, 5, 15),
        updatedAt: DateTime(2025, 5, 16),
        customerId: 'customer-002',
        customerName: 'Peak Construction',
        createdBy: 'Admin User',
        description: 'Urgent repair service call',
        metadata: {
          'serviceType': 'Emergency Repair',
          'operator': 'jane smith',
          'serviceHours': 6,
          'serviceDate': '5/16/2025',
          'projectSite': 'Peak Tower Site',
        },
      ),
      Document(
        id: 'SC-2821',
        title: 'Service Call - City Developers',
        type: DocumentType.serviceCall,
        status: DocumentStatus.completed,
        createdAt: DateTime(2025, 5, 10),
        updatedAt: DateTime(2025, 5, 12),
        customerId: 'customer-003',
        customerName: 'City Developers',
        createdBy: 'Admin User',
        signedBy: 'City Developers Rep',
        description: 'Weekly maintenance service',
        metadata: {
          'serviceType': 'Concrete Pumping',
          'operator': 'michael white',
          'serviceHours': 3,
          'serviceDate': '5/11/2025',
          'projectSite': 'City Center Project',
        },
      ),
      Document(
        id: 'SC-2798',
        title: 'Service Call - Premium Builders',
        type: DocumentType.serviceCall,
        status: DocumentStatus.awaitingSignature,
        createdAt: DateTime(2025, 5, 13),
        updatedAt: DateTime(2025, 5, 15),
        customerId: 'customer-004',
        customerName: 'Premium Builders',
        createdBy: 'Admin User',
        description: 'Foundation pour service',
        metadata: {
          'serviceType': 'Foundation Work',
          'operator': 'robert johnson',
          'serviceHours': 8,
          'serviceDate': '5/14/2025',
          'projectSite': 'Premium Estates',
        },
      ),
    ];
  }
  
  // Get delivery certificate documents
  static List<Document> getDeliveryCertificateDocuments() {
    return [
      Document(
        id: 'DC-1817',
        title: 'Delivery Certificate - ABC Construction',
        type: DocumentType.deliveryCertificate,
        status: DocumentStatus.draft,
        createdAt: DateTime(2025, 5, 16),
        updatedAt: DateTime(2025, 5, 16),
        customerId: 'customer-001',
        customerName: 'ABC Construction',
        createdBy: 'Admin User',
        description: 'Concrete materials delivery',
        metadata: {
          'serviceType': 'Concrete Pumping',
          'operator': 'john doe',
          'serviceHours': 4,
          'serviceDate': '5/18/2025',
          'projectSite': 'Site 123',
          'materials': [
            {'name': 'Concrete Mix', 'quantity': 5.0, 'unit': 'tons'},
            {'name': 'Reinforcement Steel', 'quantity': 2.0, 'unit': 'tons'},
          ],
        },
      ),
      Document(
        id: 'DC-1829',
        title: 'Delivery Certificate - City Developers',
        type: DocumentType.deliveryCertificate,
        status: DocumentStatus.signed,
        createdAt: DateTime(2025, 5, 8),
        updatedAt: DateTime(2025, 5, 10),
        customerId: 'customer-003',
        customerName: 'City Developers',
        createdBy: 'Admin User',
        signedBy: 'City Developers Rep',
        description: 'Weekly material delivery',
        metadata: {
          'serviceType': 'Material Delivery',
          'operator': 'michael white',
          'serviceHours': 2,
          'serviceDate': '5/9/2025',
          'projectSite': 'City Center Project',
          'materials': [
            {'name': 'Concrete Mix', 'quantity': 3.0, 'unit': 'tons'},
            {'name': 'Sand', 'quantity': 1.5, 'unit': 'tons'},
          ],
        },
      ),
      Document(
        id: 'DC-1801',
        title: 'Delivery Certificate - Premium Builders',
        type: DocumentType.deliveryCertificate,
        status: DocumentStatus.pending,
        createdAt: DateTime(2025, 5, 15),
        updatedAt: DateTime(2025, 5, 15),
        customerId: 'customer-004',
        customerName: 'Premium Builders',
        createdBy: 'Admin User',
        description: 'Special materials for foundation',
        metadata: {
          'serviceType': 'Foundation Materials',
          'operator': 'robert johnson',
          'serviceHours': 4,
          'serviceDate': '5/16/2025',
          'projectSite': 'Premium Estates',
          'materials': [
            {'name': 'High-Strength Concrete', 'quantity': 4.0, 'unit': 'tons'},
            {'name': 'Premium Reinforcement Steel', 'quantity': 3.0, 'unit': 'tons'},
          ],
        },
      ),
    ];
  }
  
  // Get report documents
  static List<Document> getReportDocuments() {
    return [
      Document(
        id: 'RPT-3495',
        title: 'Service Activity Report - May 2025',
        type: DocumentType.report,
        status: DocumentStatus.completed,
        createdAt: DateTime(2025, 5, 18),
        updatedAt: DateTime(2025, 5, 18),
        customerId: 'all',
        customerName: 'All Customers',
        createdBy: 'Admin User',
        description: 'Monthly service activity summary',
        metadata: {
          'reportPeriod': 'May 2025',
          'reportDate': '5/18/2025',
          'totalServices': 15,
          'completedServices': 12,
          'pendingServices': 3,
          'totalHours': 45,
          'totalAmount': 5250.0,
          'serviceDetails': [
            {'serviceType': 'Concrete Pumping', 'count': 8, 'hours': 24, 'percentage': 53.0},
            {'serviceType': 'Transportation', 'count': 4, 'hours': 16, 'percentage': 27.0},
            {'serviceType': 'Other Services', 'count': 3, 'hours': 5, 'percentage': 20.0},
          ],
        },
      ),
      Document(
        id: 'RPT-8245',
        title: 'Service Activity Report - May 2025',
        type: DocumentType.report,
        status: DocumentStatus.completed,
        createdAt: DateTime(2025, 5, 18),
        updatedAt: DateTime(2025, 5, 18),
        customerId: 'customer-001',
        customerName: 'ABC Construction',
        createdBy: 'Admin User',
        description: 'Client-specific monthly report',
        metadata: {
          'reportPeriod': 'May 2025',
          'reportDate': '5/18/2025',
          'totalServices': 8,
          'completedServices': 7,
          'pendingServices': 1,
          'totalHours': 28,
          'totalAmount': 3420.0,
          'serviceDetails': [
            {'serviceType': 'Concrete Pumping', 'count': 5, 'hours': 15, 'percentage': 62.5},
            {'serviceType': 'Transportation', 'count': 2, 'hours': 10, 'percentage': 25.0},
            {'serviceType': 'Other Services', 'count': 1, 'hours': 3, 'percentage': 12.5},
          ],
        },
      ),
      Document(
        id: 'RPT-8132',
        title: 'Quarterly Performance Report - Q1 2025',
        type: DocumentType.report,
        status: DocumentStatus.archived,
        createdAt: DateTime(2025, 4, 2),
        updatedAt: DateTime(2025, 4, 2),
        customerId: 'all',
        customerName: 'All Customers',
        createdBy: 'Admin User',
        description: 'Quarterly performance summary',
        metadata: {
          'reportPeriod': 'Q1 2025',
          'reportDate': '4/2/2025',
          'totalServices': 42,
          'completedServices': 38,
          'pendingServices': 4,
          'totalHours': 156,
          'totalAmount': 18720.0,
          'serviceDetails': [
            {'serviceType': 'Concrete Pumping', 'count': 24, 'hours': 96, 'percentage': 57.0},
            {'serviceType': 'Transportation', 'count': 10, 'hours': 40, 'percentage': 24.0},
            {'serviceType': 'Other Services', 'count': 8, 'hours': 20, 'percentage': 19.0},
          ],
        },
      ),
    ];
  }

  // Get service call document data
  static ServiceCallDocument getServiceCallDocumentData(String id) {
    return ServiceCallDocument(
      id: id,
      companyName: 'UNIDOC Solutions',
      companyAddress: '123 Business Avenue, Suite 100, Enterprise City',
      companyPhone: '+1 (555) 123-4567',
      companyEmail: 'service@unidoc.com',
      customerName: 'ABC Construction',
      customerAddress: '456 Construction Blvd, Builder City',
      customerContactPerson: 'John Builder',
      customerPhone: '+1 (555) 987-6543',
      customerEmail: 'john@abcconstruction.com',
      customerProjectSite: 'Site 123',
      serviceDate: DateTime(2025, 5, 18),
      serviceTime: '9:00 AM',
      serviceType: 'Concrete Pumping',
      operatorName: 'john doe',
      serviceHours: 4,
      certificateStatus: 'Scheduled',
      notes: 'Regular maintenance service as per agreement.',
    );
  }
  
  // Get delivery certificate document data
  static DeliveryCertificateDocument getDeliveryCertificateDocumentData(String id) {
    return DeliveryCertificateDocument(
      id: id,
      companyName: 'UNIDOC Solutions',
      companyAddress: '123 Business Avenue, Suite 100, Enterprise City',
      companyPhone: '+1 (555) 123-4567',
      companyEmail: 'service@unidoc.com',
      customerName: 'ABC Construction',
      customerAddress: '456 Construction Blvd, Builder City',
      customerContactPerson: 'John Builder',
      customerProjectSite: 'Site 123',
      serviceDate: DateTime(2025, 5, 18),
      serviceType: 'Concrete Pumping',
      operatorName: 'john doe',
      serviceHours: 4,
      materials: [
        MaterialItem(name: 'Concrete Mix', quantity: 5.0, unit: 'tons'),
        MaterialItem(name: 'Reinforcement Steel', quantity: 2.0, unit: 'tons'),
      ],
      notes: 'Delivery completed as per customer specifications.',
    );
  }
  
  // Get report document data
  static ReportDocument getReportDocumentData(String id) {
    return ReportDocument(
      id: id,
      title: 'Service Activity Report',
      reportPeriod: 'May 2025',
      reportDate: DateTime(2025, 5, 18),
      customerName: 'Customer Name',
      totalServices: 15,
      completedServices: 12,
      pendingServices: 3,
      totalHours: 45,
      totalAmount: 5250.0,
      additionalNotes: 'Monthly service activity summary for all clients.',
      serviceDetails: [
        ServiceDetail(
          serviceType: 'Concrete Pumping',
          count: 8,
          hours: 24,
          percentageOfTotal: 53.0,
        ),
        ServiceDetail(
          serviceType: 'Transportation',
          count: 4,
          hours: 16,
          percentageOfTotal: 27.0,
        ),
        ServiceDetail(
          serviceType: 'Other Services',
          count: 3,
          hours: 5,
          percentageOfTotal: 20.0,
        ),
      ],
    );
  }
} 