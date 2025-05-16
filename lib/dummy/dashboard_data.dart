import 'package:flutter/material.dart'; // For Color, if needed in data models

// --- Performance Data ---
class PerformanceEntry {
  final String name; // e.g., Month
  final double revenue;
  final int jobs;

  PerformanceEntry({required this.name, required this.revenue, required this.jobs});
}

final List<PerformanceEntry> performanceData = [
  PerformanceEntry(name: 'Jan', revenue: 4000, jobs: 24),
  PerformanceEntry(name: 'Feb', revenue: 3000, jobs: 13),
  PerformanceEntry(name: 'Mar', revenue: 2000, jobs: 18),
  PerformanceEntry(name: 'Apr', revenue: 2780, jobs: 21),
  PerformanceEntry(name: 'May', revenue: 1890, jobs: 15),
  PerformanceEntry(name: 'Jun', revenue: 2390, jobs: 20),
  PerformanceEntry(name: 'Jul', revenue: 3490, jobs: 28),
];

// --- Users Data ---
class UserPerformanceEntry {
  final String id;
  final String name;
  final String role;
  final int performance; // Percentage
  final String? avatarUrl; // Nullable for fallback

  UserPerformanceEntry({
    required this.id,
    required this.name,
    required this.role,
    required this.performance,
    this.avatarUrl,
  });
}

final List<UserPerformanceEntry> usersData = [
  UserPerformanceEntry(id: '1', name: 'John Doe', role: 'Operator', performance: 95, avatarUrl: 'https://randomuser.me/api/portraits/men/75.jpg'),
  UserPerformanceEntry(id: '2', name: 'Jane Smith', role: 'Foreman', performance: 88, avatarUrl: 'https://randomuser.me/api/portraits/women/75.jpg'),
  UserPerformanceEntry(id: '3', name: 'Robert Johnson', role: 'Operator', performance: 76, avatarUrl: null), // Fallback example
  UserPerformanceEntry(id: '4', name: 'Emily Brown', role: 'Office Manager', performance: 92, avatarUrl: 'https://randomuser.me/api/portraits/women/76.jpg'),
  UserPerformanceEntry(id: '5', name: 'Michael Wilson', role: 'Operator', performance: 83, avatarUrl: 'https://randomuser.me/api/portraits/men/78.jpg'),
];

// --- Customer Breakdown Data ---
class CustomerSegment {
  final String name;
  final double value; // Percentage or count
  // final Color color; // Optional: if colors are defined per segment

  CustomerSegment({required this.name, required this.value});
}

final List<CustomerSegment> customerBreakdownData = [
  CustomerSegment(name: 'Commercial', value: 40),
  CustomerSegment(name: 'Residential', value: 30),
  CustomerSegment(name: 'Industrial', value: 20),
  CustomerSegment(name: 'Government', value: 10),
];

// --- Recent Activity Data ---
enum ActivityType { agreement, job, user, system }

class ActivityEntry {
  final String id;
  final ActivityType type;
  final String title;
  final String? description;
  final DateTime timestamp;
  final String? user;

  ActivityEntry({
    required this.id,
    required this.type,
    required this.title,
    this.description,
    required this.timestamp,
    this.user,
  });
}

final List<ActivityEntry> recentActivityData = [
  ActivityEntry(
    id: '1',
    type: ActivityType.agreement,
    title: 'New agreement created',
    description: 'Acme Corp - Annual Concrete Supply',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    user: 'Jane Smith',
  ),
  ActivityEntry(
    id: '2',
    type: ActivityType.job,
    title: 'Job #1024 completed',
    description: 'Site X - Foundation Pouring',
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    user: 'John Doe',
  ),
  ActivityEntry(
    id: '3',
    type: ActivityType.user,
    title: 'User password reset',
    description: 'Robert Johnson requested a password reset.',
    timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    user: 'System',
  ),
  ActivityEntry(
    id: '4',
    type: ActivityType.system,
    title: 'System backup completed',
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
  ),
  ActivityEntry(
    id: '5',
    type: ActivityType.agreement,
    title: 'Agreement #AGR-004 updated',
    description: 'Updated payment terms for BuildFast Ltd.',
    timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 10)),
    user: 'Emily Brown',
  ),
];

// --- Stats Data (simulating fetched stats) ---
class DashboardStats {
  final double totalRevenue;
  final int completedJobs;
  final int activeCustomers;
  final double avgJobValue;
  // Add percentage changes if you want to model them directly
  final double revenueChangePercent;
  final double jobsChangePercent;
  final double customersChangePercent;
  final double avgJobValueChangePercent;

  DashboardStats({
    required this.totalRevenue,
    required this.completedJobs,
    required this.activeCustomers,
    required this.avgJobValue,
    required this.revenueChangePercent,
    required this.jobsChangePercent,
    required this.customersChangePercent,
    required this.avgJobValueChangePercent,
  });
}

// Example instance of DashboardStats
final DashboardStats dummyDashboardStats = DashboardStats(
  totalRevenue: 245673,
  completedJobs: 1284,
  activeCustomers: 243,
  avgJobValue: 1890,
  revenueChangePercent: 12.0,
  jobsChangePercent: 8.0,
  customersChangePercent: 5.0,
  avgJobValueChangePercent: -3.0, // Negative for decrease
); 