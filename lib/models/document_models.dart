import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

// Enum for document types
enum DocumentType {
  serviceCall,
  deliveryCertificate,
  report,
  agreement,
  invoice,
  other
}

// Enum for document status
enum DocumentStatus {
  draft,
  pending,
  scheduled,
  inProgress,
  awaitingSignature,
  approved,
  signed,
  completed,
  expired,
  archived
}

// Main document model
class Document {
  final String id;
  final String title;
  final DocumentType type;
  final DocumentStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? expirationDate;
  final String? customerId;
  final String? customerName;
  final String? createdBy;
  final String? approvedBy;
  final String? signedBy;
  final String? description;
  final Map<String, dynamic>? metadata;
  final List<DocumentHistory>? history;
  final String? fileUrl;
  final List<DocumentAttachment>? attachments;

  Document({
    required this.id,
    required this.title,
    required this.type,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.expirationDate,
    this.customerId,
    this.customerName,
    this.createdBy,
    this.approvedBy,
    this.signedBy,
    this.description,
    this.metadata,
    this.history,
    this.fileUrl,
    this.attachments,
  });

  // Get formatted created date
  String get formattedCreatedAt {
    return DateFormat('MM/dd/yyyy').format(createdAt);
  }
  
  // Formatted update date
  String? get formattedUpdatedAt => 
      updatedAt != null ? DateFormat('MM/dd/yyyy').format(updatedAt!) : null;
  
  // Formatted expiration date
  String? get formattedExpirationDate => 
      expirationDate != null ? DateFormat('MM/dd/yyyy').format(expirationDate!) : null;
  
  // Get display name for document type
  String get typeDisplayName {
    switch (type) {
      case DocumentType.serviceCall:
        return 'Service Call';
      case DocumentType.deliveryCertificate:
        return 'Delivery Certificate';
      case DocumentType.report:
        return 'Report';
      case DocumentType.agreement:
        return 'Agreement';
      case DocumentType.invoice:
        return 'Invoice';
      case DocumentType.other:
        return 'Other';
    }
  }
  
  // Get display name for document status
  String get statusDisplayName {
    return getStatusDisplayName(status);
  }
  
  // Get color for document status
  Color get statusColor {
    return getStatusColor(status);
  }
  
  // Get text color for document status
  Color get statusTextColor {
    return getStatusTextColor(status);
  }
  
  // Get icon for document type
  IconData get typeIcon {
    switch (type) {
      case DocumentType.serviceCall:
        return LucideIcons.fileText;
      case DocumentType.deliveryCertificate:
        return LucideIcons.fileCheck;
      case DocumentType.report:
        return LucideIcons.fileBarChart;
      case DocumentType.agreement:
        return LucideIcons.fileSignature;
      case DocumentType.invoice:
        return LucideIcons.fileSpreadsheet;
      case DocumentType.other:
        return LucideIcons.file;
    }
  }

  // Create a copy with updated fields
  Document copyWith({
    String? id,
    String? title,
    DocumentType? type,
    DocumentStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? expirationDate,
    String? customerId,
    String? customerName,
    String? createdBy,
    String? approvedBy,
    String? signedBy,
    String? description,
    Map<String, dynamic>? metadata,
    List<DocumentHistory>? history,
    String? fileUrl,
    List<DocumentAttachment>? attachments,
  }) {
    return Document(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      expirationDate: expirationDate ?? this.expirationDate,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      createdBy: createdBy ?? this.createdBy,
      approvedBy: approvedBy ?? this.approvedBy,
      signedBy: signedBy ?? this.signedBy,
      description: description ?? this.description,
      metadata: metadata ?? this.metadata,
      history: history ?? this.history,
      fileUrl: fileUrl ?? this.fileUrl,
      attachments: attachments ?? this.attachments,
    );
  }

  // Static helper to get status display name
  static String getStatusDisplayName(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.draft:
        return 'Draft';
      case DocumentStatus.pending:
        return 'Pending';
      case DocumentStatus.scheduled:
        return 'Scheduled';
      case DocumentStatus.inProgress:
        return 'In Progress';
      case DocumentStatus.awaitingSignature:
        return 'Awaiting Signature';
      case DocumentStatus.approved:
        return 'Approved';
      case DocumentStatus.signed:
        return 'Signed';
      case DocumentStatus.completed:
        return 'Completed';
      case DocumentStatus.expired:
        return 'Expired';
      case DocumentStatus.archived:
        return 'Archived';
      default:
        return 'Unknown';
    }
  }

  // Static helper to get status color
  static Color getStatusColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.draft:
        return Colors.grey.shade100;
      case DocumentStatus.pending:
        return Colors.blue.shade100;
      case DocumentStatus.scheduled:
        return Colors.yellow.shade100;
      case DocumentStatus.inProgress:
        return Colors.teal.shade100;
      case DocumentStatus.awaitingSignature:
        return Colors.purple.shade100;
      case DocumentStatus.approved:
        return Colors.teal.shade100;
      case DocumentStatus.signed:
        return Colors.green.shade100;
      case DocumentStatus.completed:
        return Colors.green.shade100;
      case DocumentStatus.expired:
        return Colors.red.shade100;
      case DocumentStatus.archived:
        return Colors.grey.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  // Static helper to get status text color
  static Color getStatusTextColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.draft:
        return Colors.grey.shade800;
      case DocumentStatus.pending:
        return Colors.blue.shade800;
      case DocumentStatus.scheduled:
        return Colors.yellow.shade800;
      case DocumentStatus.inProgress:
        return Colors.teal.shade800;
      case DocumentStatus.awaitingSignature:
        return Colors.purple.shade800;
      case DocumentStatus.approved:
        return Colors.teal.shade800;
      case DocumentStatus.signed:
        return Colors.green.shade800;
      case DocumentStatus.completed:
        return Colors.green.shade800;
      case DocumentStatus.expired:
        return Colors.red.shade800;
      case DocumentStatus.archived:
        return Colors.grey.shade800;
      default:
        return Colors.grey.shade800;
    }
  }
}

// Service Call document specific model
class ServiceCallDocument {
  final String id;
  final String companyName;
  final String? companyAddress;
  final String? companyPhone;
  final String? companyEmail;
  
  final String? customerName;
  final String? customerAddress;
  final String? customerContactPerson;
  final String? customerPhone;
  final String? customerEmail;
  final String? customerProjectSite;
  
  final DateTime serviceDate;
  final String? serviceTime;
  final String? serviceType;
  final String operatorName;
  final int serviceHours;
  final String? certificateStatus;
  final String? notes;
  
  ServiceCallDocument({
    required this.id,
    required this.companyName,
    this.companyAddress,
    this.companyPhone,
    this.companyEmail,
    this.customerName,
    this.customerAddress,
    this.customerContactPerson,
    this.customerPhone,
    this.customerEmail,
    this.customerProjectSite,
    required this.serviceDate,
    this.serviceTime,
    this.serviceType,
    required this.operatorName,
    required this.serviceHours,
    this.certificateStatus,
    this.notes,
  });
}

// Delivery Certificate document specific model
class DeliveryCertificateDocument {
  final String id;
  final String companyName;
  final String? companyAddress;
  final String? companyPhone;
  final String? companyEmail;
  
  final String? customerName;
  final String? customerAddress;
  final String? customerContactPerson;
  final String? customerProjectSite;
  
  final DateTime serviceDate;
  final String? serviceType;
  final String operatorName;
  final int serviceHours;
  final List<MaterialItem>? materials;
  final String? notes;
  
  DeliveryCertificateDocument({
    required this.id,
    required this.companyName,
    this.companyAddress,
    this.companyPhone,
    this.companyEmail,
    this.customerName,
    this.customerAddress,
    this.customerContactPerson,
    this.customerProjectSite,
    required this.serviceDate,
    this.serviceType,
    required this.operatorName,
    required this.serviceHours,
    this.materials,
    this.notes,
  });
}

// Report document specific model
class ReportDocument {
  final String id;
  final String title;
  final String reportPeriod;
  final DateTime reportDate;
  final String? customerName;
  
  final int totalServices;
  final int completedServices;
  final int pendingServices;
  final int totalHours;
  final double totalAmount;
  final String? additionalNotes;
  
  final List<ServiceDetail>? serviceDetails;
  
  ReportDocument({
    required this.id,
    required this.title,
    required this.reportPeriod,
    required this.reportDate,
    this.customerName,
    required this.totalServices,
    required this.completedServices,
    required this.pendingServices,
    required this.totalHours,
    required this.totalAmount,
    this.additionalNotes,
    this.serviceDetails,
  });
}

// Material item for delivery certificates
class MaterialItem {
  final String name;
  final double quantity;
  final String? unit;
  
  MaterialItem({
    required this.name,
    required this.quantity,
    this.unit,
  });
}

// Service detail for reports
class ServiceDetail {
  final String serviceType;
  final int count;
  final int hours;
  final double percentageOfTotal;
  
  ServiceDetail({
    required this.serviceType,
    required this.count,
    required this.hours,
    required this.percentageOfTotal,
  });
}

// Document history entry
class DocumentHistory {
  final String id;
  final DateTime timestamp;
  final String action; // 'created', 'updated', 'approved', 'signed', 'completed', 'expired', 'archived'
  final String? userId;
  final String? userName;
  final String? notes;

  DocumentHistory({
    required this.id,
    required this.timestamp,
    required this.action,
    this.userId,
    this.userName,
    this.notes,
  });
}

// Document attachment model
class DocumentAttachment {
  final String id;
  final String fileName;
  final String fileUrl;
  final String fileType;
  final int fileSize; // in bytes
  final DateTime uploadedAt;
  final String? uploadedBy;

  DocumentAttachment({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.fileType,
    required this.fileSize,
    required this.uploadedAt,
    this.uploadedBy,
  });
} 