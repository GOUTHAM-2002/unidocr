class Activity {
  final String id;
  final String customerId;
  final String type;
  final String description;
  final DateTime createdAt;

  Activity({
    required this.id,
    required this.customerId,
    required this.type,
    required this.description,
    required this.createdAt,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String,
      customerId: json['customerId'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': customerId,
      'type': type,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
} 