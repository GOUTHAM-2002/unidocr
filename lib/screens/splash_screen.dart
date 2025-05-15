import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:unidoc/theme/app_theme.dart';
import 'package:unidoc/widgets/animated_gradient_background.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedGradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                  border: Border.all(
                    color: AppTheme.neonBlue.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: AppTheme.neonShadow(AppTheme.neonBlue),
                ),
                child: const Icon(
                  Icons.school_outlined,
                  size: 60,
                  color: Colors.white,
                ),
              ).animate()
                .scale(
                  duration: 600.ms,
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                )
                .fadeIn(duration: 600.ms),

              const SizedBox(height: 24),

              // App Name
              Text(
                'UniDoc',
                style: AppTheme.headingStyle.copyWith(
                  fontSize: 48,
                  shadows: AppTheme.neonShadow(AppTheme.neonBlue),
                ),
              ).animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .slideY(
                  begin: -0.2,
                  end: 0,
                  duration: 600.ms,
                ),

              const SizedBox(height: 8),

              // Tagline
              Text(
                'Your Office Companion',
                style: AppTheme.subheadingStyle,
              ).animate()
                .fadeIn(delay: 400.ms, duration: 600.ms),

              const SizedBox(height: 48),

              // Loading Indicator
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.neonBlue),
                  strokeWidth: 3,
                ),
              ).animate()
                .fadeIn(delay: 600.ms, duration: 600.ms)
                .scale(
                  duration: 600.ms,
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                ),
            ],
          ),
        ),
      ),
    );
  }
} 