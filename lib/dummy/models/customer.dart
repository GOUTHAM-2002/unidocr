class Customer {
  final String id;
  final String name;
  final String nickname;
  final String email;
  final String phone;
  final String? officePhone;
  final String address;
  final String? address2;
  final String type;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? avatarUrl;
  final bool needsQuote;
  final String customerId;
  final String contactName;
  final DateTime lastActive;

  Customer({
    required this.id,
    required this.name,
    required this.nickname,
    required this.email,
    required this.phone,
    this.officePhone,
    required this.address,
    this.address2,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.avatarUrl,
    required this.needsQuote,
    required this.customerId,
    required this.contactName,
    required this.lastActive,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      officePhone: json['officePhone'] as String?,
      address: json['address'] as String,
      address2: json['address2'] as String?,
      type: json['type'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      avatarUrl: json['avatar_url'] as String?,
      needsQuote: json['needs_quote'] as bool,
      customerId: json['customerId'] as String,
      contactName: json['contactName'] as String,
      lastActive: DateTime.parse(json['last_active'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nickname': nickname,
      'email': email,
      'phone': phone,
      'officePhone': officePhone,
      'address': address,
      'address2': address2,
      'type': type,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'avatar_url': avatarUrl,
      'needs_quote': needsQuote,
      'customerId': customerId,
      'contactName': contactName,
      'last_active': lastActive.toIso8601String(),
    };
  }
} 