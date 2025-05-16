import 'package:flutter/material.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/router/app_router.dart';
// import 'screens/splash_screen.dart';
// import 'screens/dashboard_page.dart';
// import 'screens/customers_page.dart';

void main() {
  // It's good practice to ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const UniDocApp());
}

class UniDocApp extends StatelessWidget {
  const UniDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Unidoc',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
      // routes: {
      //   '/dashboard': (context) => const DashboardPage(),
      //   '/customers': (context) => const CustomersPage(),
      // },
    );
  }
} 