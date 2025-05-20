import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:unidoc/dummy/admin_mock_data.dart';

class CompletionRateChart extends StatelessWidget {
  const CompletionRateChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completionData = AdminMockData.getServiceCompletionRateData();
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          drawHorizontalLine: true,
          horizontalInterval: 25,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: theme.colorScheme.outline.withOpacity(0.2),
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                final months = completionData.keys.toList();
                if (value >= 0 && value < months.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      months[value.toInt()],
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
              reservedSize: 28,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 25,
              getTitlesWidget: (value, _) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '${value.toInt()}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                );
              },
              reservedSize: 32,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: 0,
        maxX: completionData.length.toDouble() - 1,
        minY: 0,
        maxY: 100,
        lineBarsData: [
          // Completion line
          LineChartBarData(
            spots: _createCompletionSpots(completionData),
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: true,
              getDotPainter: _getCompletionDotPainter,
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.1),
            ),
          ),
          // Target line
          LineChartBarData(
            spots: _createTargetSpots(completionData),
            isCurved: false,
            color: Colors.red,
            barWidth: 2,
            isStrokeCapRound: true,
            dashArray: [5, 5],
            dotData: const FlDotData(
              show: true,
              getDotPainter: _getTargetDotPainter,
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
        
            tooltipPadding: const EdgeInsets.all(8),
            tooltipMargin: 8,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final isActual = spot.barIndex == 0;
                return LineTooltipItem(
                  '${isActual ? 'Completed: ' : 'Target: '}${spot.y.toInt()}%',
                  TextStyle(
                    color: theme.colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  List<FlSpot> _createCompletionSpots(Map<String, double> data) {
    final List<FlSpot> spots = [];
    final months = data.keys.toList();
    
    for (int i = 0; i < months.length; i++) {
      spots.add(FlSpot(i.toDouble(), data[months[i]]!));
    }
    
    return spots;
  }

  List<FlSpot> _createTargetSpots(Map<String, double> data) {
    final List<FlSpot> spots = [];
    final months = data.keys.toList();
    const double targetValue = 90;
    
    for (int i = 0; i < months.length; i++) {
      spots.add(FlSpot(i.toDouble(), targetValue));
    }
    
    return spots;
  }

  static FlDotPainter _getCompletionDotPainter(spot, _, __, ___) {
    return FlDotCirclePainter(
      color: Colors.blue,
      strokeWidth: 1,
      strokeColor: Colors.white,
    );
  }

  static FlDotPainter _getTargetDotPainter(spot, _, __, ___) {
    return FlDotCirclePainter(
      color: Colors.red,
      strokeWidth: 1,
      strokeColor: Colors.white,
    );
  }
} 