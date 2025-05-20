class User {
  final String id;
  final String email;
  final String name;
  final String role;
  final String? avatarUrl;
  final String status;
  final DateTime lastActive;
  final String? phone;
  final String? address;
  final String? addressLine2;
  final String? nickname;
  final List<UserPermission> permissions;
  final List<UserDocument> documents;
  final List<ServiceRecord> serviceHistory;
  final List<Communication> communications;
  final List<UserAgreement> agreements;
  final int completedJobs;
  final double averageRating;
  final int openTasks;
  final int documentsSubmitted;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    this.avatarUrl,
    this.status = 'active',
    required this.lastActive,
    this.phone,
    this.address,
    this.addressLine2,
    this.nickname,
    this.permissions = const [],
    this.documents = const [],
    this.serviceHistory = const [],
    this.communications = const [],
    this.agreements = const [],
    this.completedJobs = 0,
    this.averageRating = 0.0,
    this.openTasks = 0,
    this.documentsSubmitted = 0,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      avatarUrl: json['avatar_url'] as String?,
      status: json['status'] as String? ?? 'active',
      lastActive: json['last_active'] != null 
          ? DateTime.parse(json['last_active']) 
          : DateTime.now(),
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      addressLine2: json['address_line2'] as String?,
      nickname: json['nickname'] as String?,
      permissions: json['permissions'] != null
          ? (json['permissions'] as List).map((p) => UserPermission.fromJson(p)).toList()
          : [],
      documents: json['documents'] != null
          ? (json['documents'] as List).map((d) => UserDocument.fromJson(d)).toList()
          : [],
      serviceHistory: json['service_history'] != null
          ? (json['service_history'] as List).map((s) => ServiceRecord.fromJson(s)).toList()
          : [],
      communications: json['communications'] != null
          ? (json['communications'] as List).map((c) => Communication.fromJson(c)).toList()
          : [],
      agreements: json['agreements'] != null
          ? (json['agreements'] as List).map((a) => UserAgreement.fromJson(a)).toList()
          : [],
      completedJobs: json['completed_jobs'] as int? ?? 0,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      openTasks: json['open_tasks'] as int? ?? 0,
      documentsSubmitted: json['documents_submitted'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role,
      'avatar_url': avatarUrl,
      'status': status,
      'last_active': lastActive.toIso8601String(),
      'phone': phone,
      'address': address,
      'address_line2': addressLine2,
      'nickname': nickname,
      'permissions': permissions.map((p) => p.toJson()).toList(),
      'documents': documents.map((d) => d.toJson()).toList(),
      'service_history': serviceHistory.map((s) => s.toJson()).toList(),
      'communications': communications.map((c) => c.toJson()).toList(),
      'agreements': agreements.map((a) => a.toJson()).toList(),
      'completed_jobs': completedJobs,
      'average_rating': averageRating,
      'open_tasks': openTasks,
      'documents_submitted': documentsSubmitted,
    };
  }
}

class UserPermission {
  final String id;
  final String name;
  final String category;
  final bool isEnabled;

  UserPermission({
    required this.id,
    required this.name,
    required this.category,
    required this.isEnabled,
  });

  factory UserPermission.fromJson(Map<String, dynamic> json) {
    return UserPermission(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      isEnabled: json['is_enabled'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'is_enabled': isEnabled,
    };
  }
}

class UserDocument {
  final String id;
  final String name;
  final String type;
  final String? url;
  final bool isRequired;
  final DateTime? uploadedDate;

  UserDocument({
    required this.id,
    required this.name,
    required this.type,
    this.url,
    required this.isRequired,
    this.uploadedDate,
  });

  factory UserDocument.fromJson(Map<String, dynamic> json) {
    return UserDocument(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      url: json['url'] as String?,
      isRequired: json['is_required'] as bool,
      uploadedDate: json['uploaded_date'] != null 
          ? DateTime.parse(json['uploaded_date']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'url': url,
      'is_required': isRequired,
      'uploaded_date': uploadedDate?.toIso8601String(),
    };
  }
}

class ServiceRecord {
  final String id;
  final String serviceNumber;
  final String clientName;
  final String location;
  final DateTime date;
  final String status;
  final String description;

  ServiceRecord({
    required this.id,
    required this.serviceNumber,
    required this.clientName,
    required this.location,
    required this.date,
    required this.status,
    required this.description,
  });

  factory ServiceRecord.fromJson(Map<String, dynamic> json) {
    return ServiceRecord(
      id: json['id'] as String,
      serviceNumber: json['service_number'] as String,
      clientName: json['client_name'] as String,
      location: json['location'] as String,
      date: DateTime.parse(json['date']),
      status: json['status'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_number': serviceNumber,
      'client_name': clientName,
      'location': location,
      'date': date.toIso8601String(),
      'status': status,
      'description': description,
    };
  }
}

class Communication {
  final String id;
  final String type;
  final String sender;
  final String subject;
  final String content;
  final DateTime date;
  final String time;

  Communication({
    required this.id,
    required this.type,
    required this.sender,
    required this.subject,
    required this.content,
    required this.date,
    required this.time,
  });

  factory Communication.fromJson(Map<String, dynamic> json) {
    return Communication(
      id: json['id'] as String,
      type: json['type'] as String,
      sender: json['sender'] as String,
      subject: json['subject'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date']),
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'sender': sender,
      'subject': subject,
      'content': content,
      'date': date.toIso8601String(),
      'time': time,
    };
  }
}

class UserAgreement {
  final String id;
  final String name;
  final DateTime date;
  final String type;
  final String client;
  final String status;

  UserAgreement({
    required this.id,
    required this.name,
    required this.date,
    required this.type,
    required this.client,
    required this.status,
  });

  factory UserAgreement.fromJson(Map<String, dynamic> json) {
    return UserAgreement(
      id: json['id'] as String,
      name: json['name'] as String,
      date: DateTime.parse(json['date']),
      type: json['type'] as String,
      client: json['client'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'type': type,
      'client': client,
      'status': status,
    };
  }
} 