import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:unidoc/models/user.dart';
import 'package:unidoc/services/user_service.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/widgets/user/user_list_item.dart';
import 'package:unidoc/widgets/user/user_grid_item.dart';
import 'package:unidoc/widgets/user/user_detail_view.dart';
import 'package:unidoc/widgets/user/user_create_dialog.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserService _userService = UserService();
  late Future<void> _initFuture;
  
  @override
  void initState() {
    super.initState();
    _initFuture = _userService.init();
    _userService.addListener(_onServiceChanged);
  }
  
  @override
  void dispose() {
    _userService.removeListener(_onServiceChanged);
    super.dispose();
  }
  
  void _onServiceChanged() {
    // This is called whenever the service notifies listeners
    // We use setState to rebuild the UI with the latest data
    if (mounted) {
      setState(() {});
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return FutureBuilder(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: _userService.selectedUser != null
                    ? UserDetailView(
                        user: _userService.selectedUser!,
                        onClose: () => _userService.clearSelectedUser(),
                      )
                    : _buildUserListView(context),
              ),
            ],
          ),
          floatingActionButton: _userService.selectedUser == null
              ? FloatingActionButton(
                  onPressed: () => _showCreateUserDialog(context),
                  backgroundColor: colorScheme.primary,
                  child: const Icon(LucideIcons.plus, color: Colors.white),
                )
              : null,
        );
      },
    );
  }
  
  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Users',
                style: AppTextStyles.h1.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Manage system users, operators and employees',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  LucideIcons.barChart2,
                  color: theme.colorScheme.primary,
                ),
                onPressed: () {
                  // Show analytics view (modal or navigate)
                },
                tooltip: 'Analytics',
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => _showCreateUserDialog(context),
                icon: const Icon(LucideIcons.plus),
                label: const Text('Add New User'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildUserListView(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Text(
            'User Management',
            style: AppTextStyles.h2.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        _buildFilterBar(context),
        Expanded(
          child: _userService.users.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.users,
                        size: 64,
                        color: colorScheme.onSurfaceVariant.withOpacity(0.4),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'This is a placeholder',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'In a real application, this would show filtered client users',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                )
              : _userService.isGridView
                  ? _buildGridView(context)
                  : _buildListView(context),
        ),
      ],
    );
  }
  
  Widget _buildFilterBar(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Row(
        children: [
          // Tab bar for filtering by role
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterTab(context, 'All Users'),
                  _buildFilterTab(context, 'Clients'),
                  _buildFilterTab(context, 'Employees'),
                  _buildFilterTab(context, 'Foremen'),
                  _buildFilterTab(context, 'Subcontractors'),
                  _buildFilterTab(context, 'Supplier-Client'),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Search box
          Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
              border: Border.all(color: theme.colorScheme.outline.withOpacity(0.3)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              onChanged: (value) => _userService.setSearchQuery(value),
              decoration: InputDecoration(
                hintText: 'Search users...',
                border: InputBorder.none,
                icon: Icon(
                  LucideIcons.search,
                  size: 18,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // View toggle
          ToggleButtons(
            isSelected: [_userService.isGridView, !_userService.isGridView],
            onPressed: (index) {
              if (index == 0 && !_userService.isGridView) {
                _userService.toggleViewMode();
              } else if (index == 1 && _userService.isGridView) {
                _userService.toggleViewMode();
              }
            },
            borderRadius: BorderRadius.circular(8),
            constraints: const BoxConstraints(minHeight: 40, minWidth: 40),
            children: const [
              Icon(LucideIcons.layoutGrid),
              Icon(LucideIcons.list),
            ],
          ),
          const SizedBox(width: 16),
          // Filter button
          IconButton(
            icon: const Icon(LucideIcons.filter),
            onPressed: () {
              // Show advanced filter options
            },
            tooltip: 'Advanced Filters',
          ),
        ],
      ),
    );
  }
  
  Widget _buildFilterTab(BuildContext context, String role) {
    final theme = Theme.of(context);
    final isSelected = _userService.filterRole == role;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () => _userService.setFilterRole(role),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected 
                ? theme.colorScheme.primary
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outline.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Text(
            role,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isSelected
                  ? Colors.white
                  : theme.colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildGridView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _userService.users.length,
        itemBuilder: (context, index) {
          final user = _userService.users[index];
          return UserGridItem(
            user: user,
            onTap: () => _userService.selectUser(user.id),
          );
        },
      ),
    );
  }
  
  Widget _buildListView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Table header
          Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 8, left: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'User',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Role',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Status',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Last Active',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Actions column
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _userService.users.length,
              itemBuilder: (context, index) {
                final user = _userService.users[index];
                return UserListItem(
                  user: user,
                  onTap: () => _userService.selectUser(user.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  void _showCreateUserDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => UserCreateDialog(
        onUserCreated: (user) {
          // You might want to select the newly created user
          _userService.selectUser(user.id);
        },
      ),
    );
  }
} 