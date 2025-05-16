import '../dummy/mock_data.dart';
import '../dummy/models/customer.dart';
import '../dummy/models/quote.dart';
import '../dummy/models/invoice.dart';
import '../dummy/models/activity.dart';

class DataService {
  // Customer operations
  static List<Customer> getAllCustomers() {
    return MockData.customers;
  }

  static Customer? getCustomerById(String id) {
    try {
      return MockData.customers.firstWhere((customer) => customer.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Customer> getCustomersByType(String type) {
    return MockData.customers.where((customer) => customer.type == type).toList();
  }

  // Quote operations
  static List<Quote> getAllQuotes() {
    return MockData.quotes;
  }

  static Quote? getQuoteById(String id) {
    try {
      return MockData.quotes.firstWhere((quote) => quote.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Quote> getQuotesByCustomerId(String customerId) {
    return MockData.quotes
        .where((quote) => quote.customerId == customerId)
        .toList();
  }

  // Invoice operations
  static List<Invoice> getAllInvoices() {
    return MockData.invoices;
  }

  static Invoice? getInvoiceById(String id) {
    try {
      return MockData.invoices.firstWhere((invoice) => invoice.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Invoice> getInvoicesByCustomerId(String customerId) {
    return MockData.invoices
        .where((invoice) => invoice.customerId == customerId)
        .toList();
  }

  // Activity operations
  static List<Activity> getAllActivities() {
    return MockData.activities;
  }

  static List<Activity> getActivitiesByCustomerId(String customerId) {
    return MockData.activities
        .where((activity) => activity.customerId == customerId)
        .toList();
  }

  // Dashboard statistics
  static Map<String, dynamic> getDashboardStats() {
    return {
      'totalCustomers': MockData.customers.length,
      'activeCustomers': MockData.customers
          .where((customer) => customer.status == 'active')
          .length,
      'totalQuotes': MockData.quotes.length,
      'pendingQuotes': MockData.quotes
          .where((quote) => quote.status == 'pending')
          .length,
      'totalInvoices': MockData.invoices.length,
      'pendingInvoices': MockData.invoices
          .where((invoice) => invoice.status == 'pending')
          .length,
      'totalRevenue': MockData.invoices
          .where((invoice) => invoice.status == 'paid')
          .fold(0.0, (sum, invoice) => sum + invoice.total),
    };
  }
} 