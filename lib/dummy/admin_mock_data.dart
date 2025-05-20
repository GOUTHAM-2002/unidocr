import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/admin_models.dart';
import 'package:unidoc/theme/app_theme.dart';

class AdminMockData {
  // Dashboard metrics data
  static DashboardMetrics getDashboardMetrics() {
    return DashboardMetrics(
      totalServiceJobs: 1284,
      totalServiceJobsGrowth: 12.5,
      activeOperators: 245,
      activeOperatorsGrowth: 8.2,
      activeOffices: 24,
      newOffices: 2,
      totalRevenue: 1458289,
      totalRevenueGrowth: 15.3,
    );
  }

  // Monthly revenue data for charts
  static List<MonthlyRevenue> getMonthlyRevenue() {
    return [
      MonthlyRevenue(month: 'Jan', amount: 50000),
      MonthlyRevenue(month: 'Feb', amount: 52000),
      MonthlyRevenue(month: 'Mar', amount: 53000),
      MonthlyRevenue(month: 'Apr', amount: 51000),
      MonthlyRevenue(month: 'May', amount: 47000),
    ];
  }

  // Customer satisfaction data
  static List<SatisfactionMetric> getSatisfactionMetrics() {
    return [
      SatisfactionMetric(
        name: 'Service Quality',
        percentage: 92,
        color: Colors.green,
      ),
      SatisfactionMetric(
        name: 'Timeliness',
        percentage: 85,
        color: Colors.blue,
      ),
      SatisfactionMetric(
        name: 'Communication',
        percentage: 78,
        color: Colors.orange,
      ),
      SatisfactionMetric(
        name: 'Issue Resolution',
        percentage: 81,
        color: Colors.purple,
      ),
    ];
  }

  // Top performing offices
  static List<OfficeStats> getTopPerformingOffices() {
    return [
      OfficeStats(
        officeName: 'New York Office',
        jobsCompleted: 425,
        revenue: 250450,
        growthPercent: 12.5,
      ),
      OfficeStats(
        officeName: 'Los Angeles Office',
        jobsCompleted: 376,
        revenue: 198320,
        growthPercent: 8.7,
      ),
      OfficeStats(
        officeName: 'Chicago Office',
        jobsCompleted: 312,
        revenue: 175620,
        growthPercent: 15.2,
      ),
      OfficeStats(
        officeName: 'Miami Office',
        jobsCompleted: 289,
        revenue: 142800,
        growthPercent: 5.3,
      ),
      OfficeStats(
        officeName: 'Seattle Office',
        jobsCompleted: 253,
        revenue: 128950,
        growthPercent: 11.8,
      ),
    ];
  }

  // Recent activity items
  static List<AdminActivity> getRecentActivity() {
    return [
      AdminActivity(
        id: '1',
        icon: LucideIcons.checkCircle2,
        iconColor: Colors.green,
        title: 'Completed service job #4851',
        location: 'New York Office',
        person: 'John Smith',
        time: DateTime.now().subtract(const Duration(hours: 2)),
        type: 'service',
      ),
      AdminActivity(
        id: '2',
        icon: LucideIcons.fileText,
        iconColor: Colors.blue,
        title: 'Created new agreement with Acme Corp',
        location: 'Chicago Office',
        person: 'Emily Davis',
        time: DateTime.now().subtract(const Duration(hours: 4)),
        type: 'agreement',
      ),
      AdminActivity(
        id: '3',
        icon: LucideIcons.users,
        iconColor: Colors.purple,
        title: 'Added 3 new subcontractors',
        location: 'Los Angeles Office',
        person: 'Admin',
        time: DateTime.now().subtract(const Duration(days: 1)),
        type: 'user',
      ),
      AdminActivity(
        id: '4',
        icon: LucideIcons.creditCard,
        iconColor: Colors.orange,
        title: 'Received payment of \$15,250 from TechCorp',
        location: 'Miami Office',
        person: 'System',
        time: DateTime.now().subtract(const Duration(days: 1)),
        type: 'payment',
      ),
      AdminActivity(
        id: '5',
        icon: LucideIcons.clipboardCheck,
        iconColor: Colors.blue,
        title: 'Customer signed delivery certificate #2845',
        location: 'Seattle Office',
        person: 'Jane Wilson',
        time: DateTime.now().subtract(const Duration(days: 2)),
        type: 'document',
      ),
    ];
  }

  // System notifications
  static List<AdminActivity> getSystemNotifications() {
    return [
      AdminActivity(
        id: '1',
        icon: LucideIcons.alertCircle,
        iconColor: Colors.blue,
        title: 'System Update Complete',
        time: DateTime.now().subtract(const Duration(hours: 1)),
        type: 'system',
      ),
      AdminActivity(
        id: '2',
        icon: LucideIcons.messageSquare,
        iconColor: Colors.orange,
        title: 'New Message from Support',
        time: DateTime.now().subtract(const Duration(hours: 3)),
        type: 'message',
      ),
      AdminActivity(
        id: '3',
        icon: LucideIcons.checkCircle2,
        iconColor: Colors.green,
        title: 'Target Achieved',
        time: DateTime.now().subtract(const Duration(days: 1)),
        type: 'achievement',
      ),
    ];
  }

  // Service completion rate data
  static Map<String, double> getServiceCompletionRateData() {
    return {
      'Jan': 90.0,
      'Feb': 92.0,
      'Mar': 94.0,
      'Apr': 91.0,
      'May': 90.0,
      'Jun': 89.0,
      'Jul': 91.0,
      'Aug': 93.0,
      'Sep': 95.0,
      'Oct': 97.0,
      'Nov': 98.0,
      'Dec': 96.0,
    };
  }

  // Mock offices data
  static List<Office> getOffices() {
    return [
      Office(
        id: '1',
        name: 'אלסנדר גרינבוים',
        type: 'concrete-pumping',
        location: 'וינגייט',
        created: DateTime.parse('2023-05-09'),
        lastActivity: DateTime.parse('2023-05-09'),
        email: 'boq2828@gmail.com435',
      ),
      Office(
        id: '2',
        name: 'אלסנדר גרינבוים',
        type: 'concrete-pumping',
        location: 'וינגייט',
        created: DateTime.parse('2023-05-09'),
        lastActivity: DateTime.parse('2023-05-09'),
        email: 'aaaaaaaaaboq2828@gmail.com',
      ),
      Office(
        id: '3',
        name: 'אלסנדר גרינבוים',
        type: 'concrete-pumping',
        location: 'וינגייט',
        created: DateTime.parse('2023-05-09'),
        lastActivity: DateTime.parse('2023-05-09'),
        email: 'boq2828@gmail.comdfgfddg',
      ),
      Office(
        id: '4',
        name: 'אלסנדר גרינבוים',
        type: 'concrete-pumping',
        location: 'וינגייט',
        created: DateTime.parse('2023-05-09'),
        lastActivity: DateTime.parse('2023-05-09'),
        email: 'boq2828@gmail.comdfhg',
      ),
      Office(
        id: '5',
        name: 'TEST',
        type: 'concrete-pumping',
        location: 'וינגייט',
        created: DateTime.parse('2023-05-10'),
        lastActivity: DateTime.parse('2023-05-10'),
        email: 'testqqw12312@gmail.com',
      ),
      Office(
        id: '6',
        name: 'Alex G',
        type: 'concrete-pumping',
        location: 'N/A',
        created: DateTime.parse('2023-05-10'),
        lastActivity: DateTime.parse('2023-05-10'),
        email: 'gera@gmail.com',
      ),
      Office(
        id: '7',
        name: 'Alex G',
        type: 'concrete-pumping',
        location: 'N/A',
        created: DateTime.parse('2023-05-10'),
        lastActivity: DateTime.parse('2023-05-10'),
        email: 'test@ldsadsa.com',
      ),
      Office(
        id: '8',
        name: 'ron david love53454',
        type: 'concrete-pumping',
        location: 'moris fisher 19 jerusalem',
        created: DateTime.parse('2023-05-10'),
        lastActivity: DateTime.parse('2023-05-10'),
        email: 'ronlo453454ve54310@gmail.com',
      ),
      Office(
        id: '9',
        name: 'Active',
        type: 'concrete-pumping',
        location: 'וינגייט',
        created: DateTime.parse('2023-05-11'),
        lastActivity: DateTime.parse('2023-05-11'),
        email: 'active@gmail.com',
      ),
      Office(
        id: '10',
        name: 'New York Office',
        type: 'service-operations',
        location: '123 Broadway, New York',
        created: DateTime.parse('2023-01-15'),
        lastActivity: DateTime.now().subtract(const Duration(days: 1)),
        employeeCount: 45,
        customerCount: 156,
        email: 'newyork@unidoc.com',
      ),
      Office(
        id: '11',
        name: 'Los Angeles Office',
        type: 'service-operations',
        location: '456 Hollywood Blvd, Los Angeles',
        created: DateTime.parse('2023-02-20'),
        lastActivity: DateTime.now().subtract(const Duration(hours: 12)),
        employeeCount: 38,
        customerCount: 142,
        email: 'losangeles@unidoc.com',
      ),
    ];
  }

  // Admin users data
  static List<AdminUser> getAdminUsers() {
    return [
      AdminUser(
        id: '1',
        name: 'John Smith',
        email: 'john.smith@example.com',
        role: 'Admin',
        lastActive: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'active',
        avatarInitials: 'JS',
      ),
      AdminUser(
        id: '2',
        name: 'Emily Johnson',
        email: 'emily.johnson@example.com',
        role: 'Office Staff',
        lastActive: DateTime.now().subtract(const Duration(days: 1)),
        status: 'active',
        avatarInitials: 'EJ',
      ),
      AdminUser(
        id: '3',
        name: 'Michael Davis',
        email: 'michael.davis@example.com',
        role: 'Foreman',
        lastActive: DateTime.now().subtract(const Duration(days: 5)),
        status: 'inactive',
        avatarInitials: 'MD',
      ),
      AdminUser(
        id: '4',
        name: 'Sarah Wilson',
        email: 'sarah.wilson@example.com',
        role: 'Employee',
        lastActive: DateTime.now(),
        status: 'pending',
        avatarInitials: 'SW',
      ),
      AdminUser(
        id: '5',
        name: 'David Thompson',
        email: 'david.thompson@example.com',
        role: 'Subcontractor',
        lastActive: DateTime.now().subtract(const Duration(hours: 3)),
        status: 'active',
        avatarInitials: 'DT',
      ),
    ];
  }

  // Current service rate data
  static Map<String, dynamic> getCurrentRateData() {
    return {
      'current': 86.4,
      'change': 3.2, 
      'target': 90.0,
      'remaining': 3.6,
    };
  }
} 