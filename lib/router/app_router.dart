import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unidoc/screens/dashboard_screen.dart';
import 'package:unidoc/screens/splash_screen.dart';
import 'package:unidoc/screens/login_screen.dart';
import 'package:unidoc/screens/schedule_screen.dart';
import 'package:unidoc/widgets/layout/main_layout.dart';

// Placeholder screen generator
Widget _placeholderScreen(BuildContext context, GoRouterState state, String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text('Screen: $title\nPath: ${state.uri.toString()}')),
  );
}

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return MainLayout(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: RoutePaths.dashboard,
            name: RouteNames.dashboard,
            builder: (BuildContext context, GoRouterState state) => const DashboardScreen(),
          ),
          GoRoute(
            path: RoutePaths.customers,
            name: RouteNames.customers,
            builder: (c, s) => _placeholderScreen(c, s, 'Customers'),
          ),
          GoRoute(
            path: RoutePaths.agreements,
            name: RouteNames.agreements,
            builder: (c, s) => _placeholderScreen(c, s, 'Agreements'),
          ),
          GoRoute(
            path: RoutePaths.chat,
            name: RouteNames.chat,
            builder: (c, s) => _placeholderScreen(c, s, 'Chat'),
          ),
          GoRoute(
            path: RoutePaths.schedule,
            name: RouteNames.schedule,
            builder: (c, s) => const ScheduleScreen(),
          ),
          GoRoute(
            path: RoutePaths.documents,
            name: RouteNames.documents,
            builder: (c, s) => _placeholderScreen(c, s, 'Documents'),
          ),
          GoRoute(
            path: RoutePaths.users,
            name: RouteNames.users,
            builder: (c, s) => _placeholderScreen(c, s, 'Users'),
          ),
          GoRoute(
            path: RoutePaths.adminPanel,
            name: RouteNames.adminPanel,
            builder: (c, s) => _placeholderScreen(c, s, 'Admin Panel'),
          ),
          GoRoute(
            path: RoutePaths.agentManagement,
            name: RouteNames.agentManagement,
            builder: (c, s) => _placeholderScreen(c, s, 'Agent Management'),
          ),
          GoRoute(
            path: RoutePaths.settings,
            name: RouteNames.settings,
            builder: (c, s) => _placeholderScreen(c, s, 'Settings'),
          ),
        ],
      ),
      // Standalone routes (e.g., Auth, NotFound) that don't use the MainLayout shell
      // GoRoute(
      //   path: RoutePaths.auth,
      //   name: RouteNames.auth,
      //   builder: (c, s) => _placeholderScreen(c, s, 'Authentication'), 
      // ),
      // TODO: Add NotFoundScreen
      // GoRoute(
      //   path: '/404',
      //   name: RouteNames.notFound,
      //   builder: (BuildContext context, GoRouterState state) => const NotFoundScreen(),
      // ),
    ],
    // errorBuilder: (context, state) => const NotFoundScreen(), // Optional: global error page
  );
}

// Define route paths and names for type safety and easy management
class RoutePaths {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String customers = '/customers';
  static const String agreements = '/agreements';
  static const String chat = '/chat';
  static const String schedule = '/schedule';
  static const String documents = '/documents';
  static const String users = '/users';
  static const String adminPanel = '/admin';
  static const String agentManagement = '/agents';
  static const String settings = '/settings';
  static const String notFound = '/404';
}

class RouteNames {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String dashboard = 'dashboard';
  static const String customers = 'customers';
  static const String agreements = 'agreements';
  static const String chat = 'chat';
  static const String schedule = 'schedule';
  static const String documents = 'documents';
  static const String users = 'users';
  static const String adminPanel = 'adminPanel';
  static const String agentManagement = 'agentManagement';
  static const String settings = 'settings';
  static const String notFound = 'notFound';
} 