import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:unidoc/dummy/dashboard_data.dart';
import 'package:unidoc/theme/app_theme.dart';

class PieChartWidget extends StatefulWidget {
  final List<CustomerSegment> customerSegments;

  const PieChartWidget({super.key, required this.customerSegments});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> with SingleTickerProviderStateMixin {
  int touchedIndex = -1;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: _generateSections(_animation.value),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 16,
          runSpacing: 8,
          children: _buildLegendItems(),
        ),
      ],
    );
  }

  List<PieChartSectionData> _generateSections(double animationValue) {
    return List.generate(
      widget.customerSegments.length,
      (index) {
        final segment = widget.customerSegments[index];
        final isTouched = index == touchedIndex;
        final double fontSize = isTouched ? 18 : 14;
        final double radius = isTouched ? 110 : 100;
        final Color color = _getColorForSegment(index);

        // Animate the pie slices
        return PieChartSectionData(
          color: color,
          value: segment.value * animationValue,
          title: animationValue > 0.5 ? '${segment.value.toInt()}%' : '',
          radius: radius * animationValue,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 2,
                offset: const Offset(1, 1),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildLegendItems() {
    return widget.customerSegments.asMap().entries.map((entry) {
      final int index = entry.key;
      final segment = entry.value;
      final Color color = _getColorForSegment(index);

      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            segment.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      );
    }).toList();
  }

  Color _getColorForSegment(int index) {
    // Colors matching the image
    List<Color> colors = [
      AppColors.unidocPrimaryBlue, // Commercial (blue)
      AppColors.unidocSecondaryOrange, // Residential (orange)
      const Color(0xFF34D399), // Industrial (green)
      const Color(0xFFFBBF24), // Government (yellow)
    ];

    return index < colors.length ? colors[index] : Colors.grey;
  }
} 