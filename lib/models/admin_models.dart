import 'package:flutter/material.dart';

// Office model for managing offices
class Office {
  final String id;
  final String name;
  final String type;
  final String location;
  final DateTime created;
  final DateTime lastActivity;
  final int employeeCount;
  final int customerCount;
  final int userLimit;
  final String status;
  final String? avatarUrl;
  final String? email;

  Office({
    required this.id,
    required this.name,
    required this.type, 
    required this.location,
    required this.created,
    required this.lastActivity,
    this.employeeCount = 0,
    this.customerCount = 0,
    this.userLimit = 100,
    this.status = 'active',
    this.avatarUrl,
    this.email,
  });
}

// Office Statistics
class OfficeStats {
  final String officeName;
  final int jobsCompleted;
  final double revenue;
  final double growthPercent;

  OfficeStats({
    required this.officeName,
    required this.jobsCompleted,
    required this.revenue,
    required this.growthPercent,
  });
}

// Dashboard Metrics
class DashboardMetrics {
  final int totalServiceJobs;
  final double totalServiceJobsGrowth;
  final int activeOperators;
  final double activeOperatorsGrowth;
  final int activeOffices;
  final int newOffices;
  final double totalRevenue;
  final double totalRevenueGrowth;

  DashboardMetrics({
    required this.totalServiceJobs,
    required this.totalServiceJobsGrowth,
    required this.activeOperators,
    required this.activeOperatorsGrowth,
    required this.activeOffices,
    required this.newOffices,
    required this.totalRevenue,
    required this.totalRevenueGrowth,
  });
}

// Revenue Data for Charts
class MonthlyRevenue {
  final String month;
  final double amount;

  MonthlyRevenue({required this.month, required this.amount});
}

// Customer Satisfaction Data
class SatisfactionMetric {
  final String name;
  final double percentage;
  final Color color;

  SatisfactionMetric({
    required this.name, 
    required this.percentage, 
    required this.color
  });
}

// Activity model for recent activities in admin panel
class AdminActivity {
  final String id;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? location;
  final String? person;
  final DateTime time;
  final String type;

  AdminActivity({
    required this.id,
    required this.icon,
    required this.iconColor,
    required this.title,
    this.location,
    this.person,
    required this.time,
    required this.type,
  });
}

// Admin user model (different from regular user)
class AdminUser {
  final String id;
  final String name;
  final String email;
  final String role;
  final DateTime lastActive;
  final String status;
  final String avatarInitials;

  AdminUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.lastActive,
    required this.status,
    required this.avatarInitials,
  });
} 