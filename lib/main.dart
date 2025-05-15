import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/dashboard_page.dart';

void main() {
  runApp(const UniDocApp());
}

class UniDocApp extends StatelessWidget {
  const UniDocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniDoc',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF00F5FF),
          secondary: const Color(0xFFB026FF),
          background: const Color(0xFF1E1E2C),
          surface: const Color(0xFF2D2D44),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/dashboard': (context) => const DashboardPage(),
      },
    );
  }
} 