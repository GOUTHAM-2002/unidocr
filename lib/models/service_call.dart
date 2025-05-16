import 'package:flutter/material.dart';

enum ServiceCallStatus {
  scheduled,
  inProgress,
  incomplete,
  awaitingSignature,
  completed,
  pending,
}

class ServiceCall {
  final String id;
  final String companyName;
  final String initials;
  final Color initialsColor;
  final ServiceCallStatus status;
  final DateTime date;
  final String time;
  final String siteNumber;
  final String assignedTo;
  final String notes;
  final double progressValue; // 0.0 to 1.0
  
  ServiceCall({
    required this.id,
    required this.companyName,
    required this.initials,
    required this.initialsColor,
    required this.status,
    required this.date,
    required this.time,
    required this.siteNumber,
    required this.assignedTo,
    required this.notes,
    required this.progressValue,
  });
  
  static Color getStatusColor(ServiceCallStatus status) {
    switch (status) {
      case ServiceCallStatus.scheduled:
        return Colors.blue;
      case ServiceCallStatus.inProgress:
        return Colors.green;
      case ServiceCallStatus.incomplete:
        return Colors.red;
      case ServiceCallStatus.awaitingSignature:
        return Colors.orange;
      case ServiceCallStatus.completed:
        return Colors.green;
      case ServiceCallStatus.pending:
        return Colors.purple;
    }
  }
  
  static String getStatusText(ServiceCallStatus status) {
    switch (status) {
      case ServiceCallStatus.scheduled:
        return 'Scheduled';
      case ServiceCallStatus.inProgress:
        return 'In Progress';
      case ServiceCallStatus.incomplete:
        return 'Incomplete';
      case ServiceCallStatus.awaitingSignature:
        return 'Awaiting Signature';
      case ServiceCallStatus.completed:
        return 'Completed';
      case ServiceCallStatus.pending:
        return 'Pending';
    }
  }
}

// Sample data for testing
List<ServiceCall> getDummyServiceCalls() {
  return [
    ServiceCall(
      id: 'S9587',
      companyName: 'ABC Construction',
      initials: 'AC',
      initialsColor: Colors.blue,
      status: ServiceCallStatus.scheduled,
      date: DateTime(2025, 5, 17),
      time: '16:00 AM',
      siteNumber: 'Site 59',
      assignedTo: 'John Smith',
      notes: 'Service call notes for ABC Construction',
      progressValue: 0.3,
    ),
    ServiceCall(
      id: 'S9590',
      companyName: 'City Developers',
      initials: 'CD',
      initialsColor: Colors.green,
      status: ServiceCallStatus.inProgress,
      date: DateTime(2025, 5, 7),
      time: '15:00 AM',
      siteNumber: 'Site 90',
      assignedTo: 'John Smith',
      notes: 'Service call notes for City Developers',
      progressValue: 0.7,
    ),
    ServiceCall(
      id: 'S9554',
      companyName: 'ABC Construction',
      initials: 'AC',
      initialsColor: Colors.red,
      status: ServiceCallStatus.incomplete,
      date: DateTime(2025, 5, 3),
      time: '10:00 AM',
      siteNumber: 'Site 54',
      assignedTo: 'Sarah Johnson',
      notes: 'Service call notes for ABC Construction',
      progressValue: 0.6,
    ),
    ServiceCall(
      id: 'S9577',
      companyName: 'ABC Construction',
      initials: 'AC',
      initialsColor: Colors.orange,
      status: ServiceCallStatus.awaitingSignature,
      date: DateTime(2025, 5, 17),
      time: '18:00 PM',
      siteNumber: 'Site 77',
      assignedTo: 'Michael Brown',
      notes: 'Service call notes for ABC Construction',
      progressValue: 0.9,
    ),
    ServiceCall(
      id: 'S9592',
      companyName: 'FastBuild Inc.',
      initials: 'FI',
      initialsColor: Colors.green,
      status: ServiceCallStatus.inProgress,
      date: DateTime(2025, 5, 3),
      time: '8:00 AM',
      siteNumber: 'Site 92',
      assignedTo: 'Michael Brown',
      notes: 'Service call notes for FastBuild Inc.',
      progressValue: 0.5,
    ),
    ServiceCall(
      id: 'S9584',
      companyName: 'ABC Construction',
      initials: 'AC',
      initialsColor: Colors.green,
      status: ServiceCallStatus.inProgress,
      date: DateTime(2025, 5, 22),
      time: '11:00 PM',
      siteNumber: 'Site 84',
      assignedTo: 'John Smith',
      notes: 'Service call notes for ABC Construction',
      progressValue: 0.8,
    ),
    ServiceCall(
      id: 'S9571',
      companyName: 'XYZ Builders',
      initials: 'XB',
      initialsColor: Colors.green,
      status: ServiceCallStatus.inProgress,
      date: DateTime(2025, 5, 3),
      time: '11:00 PM',
      siteNumber: 'Site 71',
      assignedTo: 'Emily Davis',
      notes: 'Service call notes for XYZ Builders',
      progressValue: 0.6,
    ),
    ServiceCall(
      id: 'S9551',
      companyName: 'FastBuild Inc.',
      initials: 'FI',
      initialsColor: Colors.red,
      status: ServiceCallStatus.incomplete,
      date: DateTime(2025, 5, 8),
      time: '13:00 AM',
      siteNumber: 'Site 51',
      assignedTo: 'Michael Brown',
      notes: 'Service call notes for FastBuild Inc.',
      progressValue: 0.7,
    ),
    ServiceCall(
      id: 'S9511',
      companyName: 'XYZ Builders',
      initials: 'XB',
      initialsColor: Colors.orange,
      status: ServiceCallStatus.awaitingSignature,
      date: DateTime(2025, 5, 3),
      time: '9:00 PM',
      siteNumber: 'Site 11',
      assignedTo: 'Emily Davis',
      notes: 'Service call notes for XYZ Builders',
      progressValue: 0.9,
    ),
    ServiceCall(
      id: 'S9856',
      companyName: 'ABC Construction',
      initials: 'AC',
      initialsColor: Colors.green,
      status: ServiceCallStatus.inProgress,
      date: DateTime(2025, 5, 24),
      time: '12:00 PM',
      siteNumber: 'Site 56',
      assignedTo: 'Emily Davis',
      notes: 'Service call notes for ABC Construction',
      progressValue: 0.4,
    ),
    ServiceCall(
      id: 'S9857',
      companyName: 'Foundation Experts',
      initials: 'FE',
      initialsColor: Colors.purple,
      status: ServiceCallStatus.pending,
      date: DateTime(2025, 5, 27),
      time: '8:40 AM',
      siteNumber: 'Site 57',
      assignedTo: 'Amanda Miller',
      notes: 'Special service call for Foundation Experts on March 27',
      progressValue: 0.1,
    ),
    ServiceCall(
      id: 'S9876',
      companyName: 'Premium Pumping',
      initials: 'PP',
      initialsColor: Colors.purple,
      status: ServiceCallStatus.pending,
      date: DateTime(2025, 5, 27),
      time: '9:00 AM',
      siteNumber: 'Site 76',
      assignedTo: 'Robert Jones',
      notes: 'Special service call for Premium Pumping on March 27',
      progressValue: 0.1,
    ),
    // Completed service calls
    ServiceCall(
      id: 'S9506',
      companyName: 'ABC Construction',
      initials: 'AC',
      initialsColor: Colors.green,
      status: ServiceCallStatus.completed,
      date: DateTime(2025, 5, 23),
      time: '18:00 PM',
      siteNumber: 'Site 6',
      assignedTo: 'Sarah Johnson',
      notes: 'Service call notes for ABC Construction',
      progressValue: 1.0,
    ),
    ServiceCall(
      id: 'S9564',
      companyName: 'XYZ Builders',
      initials: 'XB',
      initialsColor: Colors.green,
      status: ServiceCallStatus.completed,
      date: DateTime(2025, 5, 3),
      time: '11:00 AM',
      siteNumber: 'Site 64',
      assignedTo: 'John Smith',
      notes: 'Service call notes for XYZ Builders',
      progressValue: 1.0,
    ),
  ];
} 