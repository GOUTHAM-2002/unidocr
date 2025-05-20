import 'package:flutter/material.dart';

// Customer model with expanded fields matching the UI
class Customer {
  final String id;
  final String name;
  final String? nickname;
  final String email;
  final String? phone;
  final String? officePhone;
  final String? address;
  final String? address2;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final String type; // 'business', 'individual', etc.
  final String status; // 'active', 'inactive'
  final String? businessType;
  final String? taxId;
  final DateTime? customerSince;
  final String? paymentTerms;
  final String? requiredDocuments;
  final String? notes;
  final bool needsAgreement;
  final String? tier; // 'standard', 'premium', 'elite'
  final DateTime? lastActivity;
  final String? contactName;
  final String? contactEmail;
  final String? contactPhone;
  final String? contactPosition;
  final String? businessId;

  Customer({
    required this.id,
    required this.name,
    this.nickname,
    required this.email,
    this.phone,
    this.officePhone,
    this.address,
    this.address2,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    required this.type,
    required this.status,
    this.businessType,
    this.taxId,
    this.customerSince,
    this.paymentTerms,
    this.requiredDocuments,
    this.notes,
    this.needsAgreement = false,
    this.tier = 'standard',
    this.lastActivity,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.contactPosition,
    this.businessId,
  });

  Customer copyWith({
    String? id,
    String? name,
    String? nickname,
    String? email,
    String? phone,
    String? officePhone,
    String? address,
    String? address2,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    String? type,
    String? status,
    String? businessType,
    String? taxId,
    DateTime? customerSince,
    String? paymentTerms,
    String? requiredDocuments,
    String? notes,
    bool? needsAgreement,
    String? tier,
    DateTime? lastActivity,
    String? contactName,
    String? contactEmail,
    String? contactPhone,
    String? contactPosition,
    String? businessId,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      officePhone: officePhone ?? this.officePhone,
      address: address ?? this.address,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      type: type ?? this.type,
      status: status ?? this.status,
      businessType: businessType ?? this.businessType,
      taxId: taxId ?? this.taxId,
      customerSince: customerSince ?? this.customerSince,
      paymentTerms: paymentTerms ?? this.paymentTerms,
      requiredDocuments: requiredDocuments ?? this.requiredDocuments,
      notes: notes ?? this.notes,
      needsAgreement: needsAgreement ?? this.needsAgreement,
      tier: tier ?? this.tier,
      lastActivity: lastActivity ?? this.lastActivity,
      contactName: contactName ?? this.contactName,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
      contactPosition: contactPosition ?? this.contactPosition,
      businessId: businessId ?? this.businessId,
    );
  }
}

// Customer dispute model
class Dispute {
  final String id;
  final String customerId;
  final String title;
  final String description;
  final String status; // 'open', 'in_progress', 'resolved'
  final DateTime createdAt;
  final DateTime? resolvedAt;
  final String? assignedTo;

  Dispute({
    required this.id,
    required this.customerId,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.resolvedAt,
    this.assignedTo,
  });
}

// Customer agreement model
class Agreement {
  final String id;
  final String customerId;
  final String title;
  final String status; // 'active', 'draft', 'expired'
  final DateTime createdAt;
  final DateTime effectiveDate;
  final DateTime expirationDate;
  final double value;
  final List<String>? documentIds;

  Agreement({
    required this.id,
    required this.customerId,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.effectiveDate,
    required this.expirationDate,
    required this.value,
    this.documentIds,
  });
}

// Document model for customer files
class CustomerDocument {
  final String id;
  final String customerId;
  final String name;
  final String type; // 'agreement', 'invoice', 'certificate', 'report'
  final DateTime uploadedAt;
  final String? url;
  final String? category;

  CustomerDocument({
    required this.id,
    required this.customerId,
    required this.name,
    required this.type,
    required this.uploadedAt,
    this.url,
    this.category,
  });
}

// Service history model
class ServiceCall {
  final String id;
  final String customerId;
  final DateTime date;
  final String status; // 'completed', 'scheduled', 'in_progress'
  final String? description;
  final String? technicianId;
  final String? technicianName;
  final String? location;

  ServiceCall({
    required this.id,
    required this.customerId,
    required this.date,
    required this.status,
    this.description,
    this.technicianId,
    this.technicianName,
    this.location,
  });
}

// Service certificate model
class ServiceCertificate {
  final String id;
  final String customerId;
  final String serviceCallId;
  final DateTime issuedDate;
  final String? documentUrl;

  ServiceCertificate({
    required this.id,
    required this.customerId,
    required this.serviceCallId,
    required this.issuedDate,
    this.documentUrl,
  });
}

// Customer overview metrics model
class CustomerMetrics {
  final double thisMonthRevenue;
  final double lastMonthRevenue;
  final double changePercent;
  final double satisfactionScore;
  final int totalServiceCalls;
  final int totalCertificates;
  final int totalAgreements;
  final int totalDisputes;
  final int activeAgreements;
  final int pendingCertificates;
  final int completedServiceCalls;
  final int openDisputes;

  CustomerMetrics({
    required this.thisMonthRevenue,
    required this.lastMonthRevenue,
    required this.changePercent,
    required this.satisfactionScore,
    required this.totalServiceCalls,
    required this.totalCertificates,
    required this.totalAgreements,
    required this.totalDisputes,
    required this.activeAgreements,
    required this.pendingCertificates,
    required this.completedServiceCalls,
    required this.openDisputes,
  });
}

// Document category for organization
class DocumentCategory {
  final String name;
  final int documentCount;
  final IconData icon;
  final Color color;

  DocumentCategory({
    required this.name,
    required this.documentCount,
    required this.icon,
    required this.color,
  });
} 