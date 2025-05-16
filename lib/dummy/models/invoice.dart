class Invoice {
  final String id;
  final String quoteId;
  final String customerId;
  final String status;
  final double total;
  final DateTime dueDate;
  final DateTime? paidDate;
  final DateTime createdAt;

  Invoice({
    required this.id,
    required this.quoteId,
    required this.customerId,
    required this.status,
    required this.total,
    required this.dueDate,
    this.paidDate,
    required this.createdAt,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'] as String,
      quoteId: json['quoteId'] as String,
      customerId: json['customerId'] as String,
      status: json['status'] as String,
      total: (json['total'] as num).toDouble(),
      dueDate: DateTime.parse(json['dueDate'] as String),
      paidDate: json['paidDate'] != null
          ? DateTime.parse(json['paidDate'] as String)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quoteId': quoteId,
      'customerId': customerId,
      'status': status,
      'total': total,
      'dueDate': dueDate.toIso8601String(),
      'paidDate': paidDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
} 