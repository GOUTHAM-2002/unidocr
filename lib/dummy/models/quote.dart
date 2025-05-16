class Quote {
  final String id;
  final String customerId;
  final String status;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<QuoteItem> items;

  Quote({
    required this.id,
    required this.customerId,
    required this.status,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      status: json['status'] as String,
      total: (json['total'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      items: (json['items'] as List)
          .map((item) => QuoteItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'status': status,
      'total': total,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class QuoteItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final String description;

  QuoteItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.description,
  });

  factory QuoteItem.fromJson(Map<String, dynamic> json) {
    return QuoteItem(
      id: json['id'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'description': description,
    };
  }
} 