import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:unidoc/router/app_router.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/widgets/common/unidoc_logo.dart'; // Assuming a logo widget exists or will be created

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        // In a real app, you might check auth status here
        // For now, always go to login
        context.go(RoutePaths.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      // Use a gradient background similar to the Auth page's decorative pane
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.primaryGradient(theme.colorScheme),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const UnidocLogo(size: 100, lightColor: Colors.white, darkColor: AppColors.unidocBlue) // Example color usage
                  .animate()
                  .fadeIn(duration: 1000.ms)
                  .scale(delay: 200.ms, duration: 800.ms, curve: Curves.elasticOut),
              const SizedBox(height: 24),
              Text(
                'Unidoc',
                style: textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 1000.ms)
                  .slideY(begin: 0.5, end: 0, duration: 800.ms, curve: Curves.easeOutCirc),
              const SizedBox(height: 12),
              Text(
                'Your office is in your pocket.',
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  color: Colors.white.withOpacity(0.85),
                ),
              )
                  .animate()
                  .fadeIn(delay: 1000.ms, duration: 1000.ms)
                  .slideY(begin: 0.5, end: 0, duration: 800.ms, curve: Curves.easeOutCirc),
            ],
          ),
        ),
      ),
    );
  }
} 