import 'package:flutter/material.dart';

// Agreement model with detailed fields
class Agreement {
  final String id;
  final String customerId;
  final String customerName;
  final String title;
  final String status; // 'active', 'draft', 'expired'
  final String type; // 'standard', 'premium', 'custom'
  final DateTime createdAt;
  final DateTime effectiveDate;
  final DateTime expirationDate;
  final double value;
  final String currency;
  final List<String>? documentIds;
  final List<AgreementItem>? items;
  final String? notes;
  final String? createdBy;
  final String? approvedBy;
  final DateTime? approvedDate;
  final String? signedBy;
  final DateTime? signedDate;
  final List<AgreementHistory>? history;

  Agreement({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.title,
    required this.status,
    this.type = 'standard',
    required this.createdAt,
    required this.effectiveDate,
    required this.expirationDate,
    required this.value,
    this.currency = 'USD',
    this.documentIds,
    this.items,
    this.notes,
    this.createdBy,
    this.approvedBy,
    this.approvedDate,
    this.signedBy,
    this.signedDate,
    this.history,
  });

  // Calculate days remaining until expiration
  int get daysRemaining {
    final now = DateTime.now();
    if (expirationDate.isBefore(now)) {
      return 0;
    }
    return expirationDate.difference(now).inDays;
  }

  // Check if agreement is about to expire (within 30 days)
  bool get isExpiringSoon {
    return daysRemaining > 0 && daysRemaining <= 30;
  }

  // Format value with currency
  String get formattedValue {
    return '\$${value.toStringAsFixed(2)}';
  }

  // Get duration of agreement in months
  int get durationInMonths {
    return (expirationDate.difference(effectiveDate).inDays / 30).round();
  }

  // Format the date range of the agreement
  String get dateRange {
    return '${_formatDate(effectiveDate)} - ${_formatDate(expirationDate)}';
  }

  // Get background color based on status
  Color get statusColor {
    switch (status) {
      case 'active':
        return Colors.green.shade100;
      case 'draft':
        return Colors.orange.shade100;
      case 'expired':
        return Colors.grey.shade200;
      default:
        return Colors.grey.shade100;
    }
  }

  // Get text color based on status
  Color get statusTextColor {
    switch (status) {
      case 'active':
        return Colors.green.shade700;
      case 'draft':
        return Colors.orange.shade700;
      case 'expired':
        return Colors.grey.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  // Get status icon based on status
  IconData get statusIcon {
    switch (status) {
      case 'active':
        return Icons.check_circle_outline;
      case 'draft':
        return Icons.edit_note;
      case 'expired':
        return Icons.event_busy;
      default:
        return Icons.help_outline;
    }
  }

  // Helper method to format dates
  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  // Copy with method for creating modified copies
  Agreement copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? title,
    String? status,
    String? type,
    DateTime? createdAt,
    DateTime? effectiveDate,
    DateTime? expirationDate,
    double? value,
    String? currency,
    List<String>? documentIds,
    List<AgreementItem>? items,
    String? notes,
    String? createdBy,
    String? approvedBy,
    DateTime? approvedDate,
    String? signedBy,
    DateTime? signedDate,
    List<AgreementHistory>? history,
  }) {
    return Agreement(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      title: title ?? this.title,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      effectiveDate: effectiveDate ?? this.effectiveDate,
      expirationDate: expirationDate ?? this.expirationDate,
      value: value ?? this.value,
      currency: currency ?? this.currency,
      documentIds: documentIds ?? this.documentIds,
      items: items ?? this.items,
      notes: notes ?? this.notes,
      createdBy: createdBy ?? this.createdBy,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedDate: approvedDate ?? this.approvedDate,
      signedBy: signedBy ?? this.signedBy,
      signedDate: signedDate ?? this.signedDate,
      history: history ?? this.history,
    );
  }
}

// Items included in an agreement
class AgreementItem {
  final String id;
  final String description;
  final String? productCode;
  final double unitPrice;
  final double quantity;
  final String? unit; // e.g., hour, day, item
  final double discount;
  final double tax;
  final String? notes;

  AgreementItem({
    required this.id,
    required this.description,
    this.productCode,
    required this.unitPrice,
    required this.quantity,
    this.unit,
    this.discount = 0.0,
    this.tax = 0.0,
    this.notes,
  });

  // Calculate total price for the item
  double get totalPrice {
    double subtotal = unitPrice * quantity;
    double discountAmount = subtotal * (discount / 100);
    double taxAmount = (subtotal - discountAmount) * (tax / 100);
    return subtotal - discountAmount + taxAmount;
  }

  AgreementItem copyWith({required String description, required double unitPrice, required double quantity}) {
    return AgreementItem(
      id: id,
      description: description,
      productCode: productCode,
      unitPrice: unitPrice,
      quantity: quantity,
      unit: unit,
      discount: discount,
      tax: tax,
      notes: notes,
    );
  }

}

// History of agreement changes
class AgreementHistory {
  final String id;
  final DateTime timestamp;
  final String action; // 'created', 'updated', 'approved', 'signed', 'expired'
  final String? userId;
  final String? userName;
  final String? notes;

  AgreementHistory({
    required this.id,
    required this.timestamp,
    required this.action,
    this.userId,
    this.userName,
    this.notes,
  });
}

// Template for creating agreements
class AgreementTemplate {
  final String id;
  final String name;
  final String description;
  final List<AgreementItemTemplate> items;
  final String? terms;
  final String? category;
  final bool isDefault;

  AgreementTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    this.terms,
    this.category,
    this.isDefault = false,
  });
}

// Template for agreement items
class AgreementItemTemplate {
  final String id;
  final String description;
  final String? productCode;
  final double defaultUnitPrice;
  final String? unit;
  final double defaultTax;

  AgreementItemTemplate({
    required this.id,
    required this.description,
    this.productCode,
    required this.defaultUnitPrice,
    this.unit,
    this.defaultTax = 0.0,
  });
} 