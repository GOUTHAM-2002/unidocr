import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class AnimatedGradientBackground extends StatelessWidget {
  final Widget child;

  const AnimatedGradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
      ),
      child: Stack(
        children: [
          // Animated circles in the background
          ...List.generate(3, (index) {
            return Positioned(
              top: -100 + (index * 100),
              right: -100 + (index * 50),
              child: Container(
                width: 300 - (index * 50),
                height: 300 - (index * 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ).animate(
                onPlay: (controller) => controller.repeat(),
              ).scale(
                duration: (4 + index).seconds,
                begin: const Offset(1, 1),
                end: const Offset(1.5, 1.5),
              ).fadeOut(
                duration: (4 + index).seconds,
              ),
            );
          }),

          // Neon glow effect
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.neonBlue.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Animated particles
          ...List.generate(20, (index) {
            return Positioned(
              left: (index * 50.0) % MediaQuery.of(context).size.width,
              top: (index * 30.0) % MediaQuery.of(context).size.height,
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
                ),
              ).animate(
                onPlay: (controller) => controller.repeat(),
              ).scale(
                duration: (2 + (index % 3)).seconds,
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.5, 1.5),
              ).fadeOut(
                duration: (2 + (index % 3)).seconds,
              ),
            );
          }),

          // Main content
          child,
        ],
      ),
    );
  }
} 