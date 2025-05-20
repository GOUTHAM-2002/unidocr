import 'package:flutter/material.dart';
import 'package:unidoc/models/user.dart';
import 'package:unidoc/dummy/user_mock_data.dart';

class UserService with ChangeNotifier {
  // Singleton instance
  static final UserService _instance = UserService._internal();
  factory UserService() => _instance;
  UserService._internal();

  // State
  List<User> _users = [];
  User? _selectedUser;
  String _filterRole = 'All Users';
  String _searchQuery = '';
  bool _isGridView = true;

  // Getters
  List<User> get users => _getFilteredUsers();
  User? get selectedUser => _selectedUser;
  String get filterRole => _filterRole;
  String get searchQuery => _searchQuery;
  bool get isGridView => _isGridView;

  // Initialize user data
  Future<void> init() async {
    _users = UserMockData.getUsers();
    notifyListeners();
  }

  // Filter users based on role and search query
  List<User> _getFilteredUsers() {
    if (_filterRole == 'All Users' && _searchQuery.isEmpty) {
      return _users;
    }

    return _users.where((user) {
      bool roleMatch = _filterRole == 'All Users' || user.role == _filterRole;
      bool searchMatch = _searchQuery.isEmpty || 
          user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          user.email.toLowerCase().contains(_searchQuery.toLowerCase());
      
      return roleMatch && searchMatch;
    }).toList();
  }

  // Set selected user
  void selectUser(String userId) {
    _selectedUser = _users.firstWhere((user) => user.id == userId);
    notifyListeners();
  }

  // Clear selected user
  void clearSelectedUser() {
    _selectedUser = null;
    notifyListeners();
  }

  // Set filter role
  void setFilterRole(String role) {
    _filterRole = role;
    notifyListeners();
  }

  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Toggle view mode
  void toggleViewMode() {
    _isGridView = !_isGridView;
    notifyListeners();
  }

  // Create a new user
  Future<User> createUser({
    required String name,
    required String email,
    required String role,
    String? phone,
    String? address,
    String? addressLine2,
    String? nickname,
    List<UserPermission>? permissions,
    List<UserDocument>? documents,
  }) async {
    // Generate a unique ID for the new user
    final String id = DateTime.now().millisecondsSinceEpoch.toString();
    
    // Create a new user object
    final User newUser = User(
      id: id,
      name: name,
      email: email,
      role: role,
      lastActive: DateTime.now(),
      phone: phone,
      address: address,
      addressLine2: addressLine2,
      nickname: nickname,
      permissions: permissions ?? UserMockData.getDefaultPermissions(role),
      documents: documents ?? UserMockData.getRequiredDocuments(role),
    );
    
    // Add the user to the list
    _users.add(newUser);
    notifyListeners();
    
    return newUser;
  }

  // Update an existing user
  Future<User> updateUser({
    required String id,
    String? name,
    String? email,
    String? role,
    String? status,
    String? phone,
    String? address,
    String? addressLine2,
    String? nickname,
    List<UserPermission>? permissions,
    List<UserDocument>? documents,
  }) async {
    // Find the user by ID
    final int index = _users.indexWhere((user) => user.id == id);
    if (index == -1) {
      throw Exception('User not found');
    }
    
    // Get the existing user
    final User existingUser = _users[index];
    
    // Create an updated user
    final User updatedUser = User(
      id: id,
      name: name ?? existingUser.name,
      email: email ?? existingUser.email,
      role: role ?? existingUser.role,
      status: status ?? existingUser.status,
      lastActive: existingUser.lastActive,
      phone: phone ?? existingUser.phone,
      address: address ?? existingUser.address,
      addressLine2: addressLine2 ?? existingUser.addressLine2,
      nickname: nickname ?? existingUser.nickname,
      permissions: permissions ?? existingUser.permissions,
      documents: documents ?? existingUser.documents,
      serviceHistory: existingUser.serviceHistory,
      communications: existingUser.communications,
      agreements: existingUser.agreements,
      completedJobs: existingUser.completedJobs,
      averageRating: existingUser.averageRating,
      openTasks: existingUser.openTasks,
      documentsSubmitted: existingUser.documentsSubmitted,
      avatarUrl: existingUser.avatarUrl,
    );
    
    // Update the user in the list
    _users[index] = updatedUser;
    
    // If the selected user is being updated, update that too
    if (_selectedUser?.id == id) {
      _selectedUser = updatedUser;
    }
    
    notifyListeners();
    
    return updatedUser;
  }

  // Delete a user
  Future<void> deleteUser(String id) async {
    // Remove the user from the list
    _users.removeWhere((user) => user.id == id);
    
    // If the selected user is being deleted, clear the selection
    if (_selectedUser?.id == id) {
      _selectedUser = null;
    }
    
    notifyListeners();
  }

  // Upload a document for a user
  Future<User> uploadDocument({
    required String userId,
    required String documentId,
    required DateTime uploadDate,
  }) async {
    // Find the user
    final int userIndex = _users.indexWhere((user) => user.id == userId);
    if (userIndex == -1) {
      throw Exception('User not found');
    }
    
    final User user = _users[userIndex];
    
    // Find the document
    final int docIndex = user.documents.indexWhere((doc) => doc.id == documentId);
    if (docIndex == -1) {
      throw Exception('Document not found');
    }
    
    // Create a new document with uploaded date
    final UserDocument updatedDoc = UserDocument(
      id: user.documents[docIndex].id,
      name: user.documents[docIndex].name,
      type: user.documents[docIndex].type,
      isRequired: user.documents[docIndex].isRequired,
      uploadedDate: uploadDate,
      url: 'https://example.com/documents/${user.id}/${user.documents[docIndex].id}',
    );
    
    // Create a new document list
    final List<UserDocument> updatedDocs = List.from(user.documents);
    updatedDocs[docIndex] = updatedDoc;
    
    // Update the user
    return updateUser(
      id: userId,
      documents: updatedDocs,
    );
  }

  // Update user permissions
  Future<User> updatePermissions({
    required String userId,
    required List<UserPermission> permissions,
  }) async {
    return updateUser(
      id: userId,
      permissions: permissions,
    );
  }

  // Reset user password
  Future<void> resetPassword(String userId) async {
    // In a real app, this would generate a password reset link/token
    // and send it to the user's email
    print('Password reset for user $userId');
  }

  // Deactivate user
  Future<User> deactivateUser(String userId) async {
    return updateUser(
      id: userId,
      status: 'inactive',
    );
  }

  // Activate user
  Future<User> activateUser(String userId) async {
    return updateUser(
      id: userId,
      status: 'active',
    );
  }

  // Promote user (change role)
  Future<User> promoteUser({
    required String userId,
    required String newRole,
  }) async {
    return updateUser(
      id: userId,
      role: newRole,
    );
  }

  // Send message to user
  Future<void> sendMessage({
    required String userId,
    required String subject,
    required String content,
  }) async {
    // Find the user
    final int userIndex = _users.indexWhere((user) => user.id == userId);
    if (userIndex == -1) {
      throw Exception('User not found');
    }
    
    final User user = _users[userIndex];
    
    // Create a new communication
    final Communication newMessage = Communication(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: 'email',
      sender: 'Admin',
      subject: subject,
      content: content,
      date: DateTime.now(),
      time: '${DateTime.now().hour}:${DateTime.now().minute}',
    );
    
    // Add to communications list
    final List<Communication> updatedComms = List.from(user.communications)
      ..add(newMessage);
    
    // Update the user
    updateUser(
      id: userId,
      permissions: user.permissions,
      documents: user.documents,
    );
  }
} 