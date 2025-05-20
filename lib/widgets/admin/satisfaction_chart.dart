import 'package:flutter/material.dart';
import 'package:unidoc/theme/app_theme.dart';

class SatisfactionChart extends StatelessWidget {
  const SatisfactionChart({super.key});

  @override
  Widget build(BuildContext context) {
    const double satisfactionPercentage = 87;
    final theme = Theme.of(context);
    
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        children: [
          // Background circle
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.1),
                width: 16,
              ),
            ),
          ),
          // Progress circle
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.green,
                width: 16,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
            child: CustomPaint(
              painter: ProgressCirclePainter(
                progress: satisfactionPercentage / 100,
                progressColor: Colors.green,
                backgroundColor: theme.colorScheme.outline.withOpacity(0.1),
                strokeWidth: 16,
              ),
            ),
          ),
          // Percentage text
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$satisfactionPercentage%',
                  style: AppTextStyles.h2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Satisfaction',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for progress circle
class ProgressCirclePainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  ProgressCirclePainter({
    required this.progress,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);
    
    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    
    canvas.drawCircle(center, radius, backgroundPaint);
    
    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    
    final sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start from top
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// Math constant
const double pi = 3.1415926535897932; 