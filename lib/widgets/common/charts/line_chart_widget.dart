import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:unidoc/dummy/dashboard_data.dart';
import 'package:unidoc/theme/app_theme.dart';

class LineChartWidget extends StatefulWidget {
  final List<PerformanceEntry> performanceData;

  const LineChartWidget({super.key, required this.performanceData});

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1000,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: AppColors.border.withOpacity(0.3),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: AppColors.border.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1000,
                  getTitlesWidget: leftTitleWidgets,
                  reservedSize: 40,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            minX: 0,
            maxX: widget.performanceData.length - 1,
            minY: 0,
            maxY: _getMaxY(),
            lineBarsData: [
              // Revenue line
              LineChartBarData(
                spots: _createRevenueSpots(_animation.value),
                isCurved: true,
                color: AppColors.unidocPrimaryBlue,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                    radius: 4,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: AppColors.unidocPrimaryBlue,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.unidocPrimaryBlue.withOpacity(0.1),
                ),
              ),
              // Jobs line
              LineChartBarData(
                spots: _createJobsSpots(_animation.value),
                isCurved: true,
                color: AppColors.unidocSecondaryOrange,
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                    radius: 4,
                    color: Colors.white,
                    strokeWidth: 2,
                    strokeColor: AppColors.unidocSecondaryOrange,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: false,
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.white,
                tooltipRoundedRadius: 8,
                tooltipBorder: BorderSide(
                  color: AppColors.border,
                  width: 1,
                ),
                tooltipPadding: const EdgeInsets.all(8),
                getTooltipItems: (List<LineBarSpot> touchedSpots) {
                  return touchedSpots.map((spot) {
                    final index = spot.x.toInt();
                    final data = widget.performanceData[index];

                    final TextStyle textStyle = TextStyle(
                      color: spot.barIndex == 0
                          ? AppColors.unidocPrimaryBlue
                          : AppColors.unidocSecondaryOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    );

                    return LineTooltipItem(
                      spot.barIndex == 0
                          ? '\$${data.revenue.toInt()}'
                          : '${data.jobs} jobs',
                      textStyle,
                    );
                  }).toList();
                },
              ),
            ),
          ),
        );
      },
    );
  }

  double _getMaxY() {
    double maxRevenue = widget.performanceData.map((entry) => entry.revenue).reduce((a, b) => a > b ? a : b);
    return maxRevenue * 1.2; // Add 20% padding to the top
  }

  List<FlSpot> _createRevenueSpots(double animationValue) {
    return List.generate(widget.performanceData.length, (index) {
      return FlSpot(index.toDouble(), widget.performanceData[index].revenue * animationValue);
    });
  }

  List<FlSpot> _createJobsSpots(double animationValue) {
    // Normalize job counts to fit on the revenue scale
    double maxRevenue = _getMaxY();
    double maxJobs = widget.performanceData.map((entry) => entry.jobs.toDouble()).reduce((a, b) => a > b ? a : b);
    double scaleFactor = maxRevenue / maxJobs * 0.25; // Scale jobs to ~25% of the chart height

    return List.generate(widget.performanceData.length, (index) {
      return FlSpot(index.toDouble(), widget.performanceData[index].jobs * scaleFactor * animationValue);
    });
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.unidocMedium,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );

    final int index = value.toInt();
    String text = '';
    if (index >= 0 && index < widget.performanceData.length) {
      text = widget.performanceData[index].name;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: AppColors.unidocMedium,
      fontWeight: FontWeight.w500,
      fontSize: 12,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(value.toInt().toString(), style: style),
    );
  }
} 