import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:unidoc/dummy/admin_mock_data.dart';
import 'package:unidoc/models/admin_models.dart';

class RevenueChart extends StatelessWidget {
  const RevenueChart({super.key});

  @override
  Widget build(BuildContext context) {
    final revenueData = AdminMockData.getMonthlyRevenue();
    final theme = Theme.of(context);
    
    // Find max value for y-axis scaling
    double maxValue = 0;
    for (var entry in revenueData) {
      if (entry.amount > maxValue) {
        maxValue = entry.amount;
      }
    }
    
    // Round max value up to the nearest 10,000 for clean axis
    maxValue = ((maxValue / 10000).ceil() * 10000).toDouble();
    
    return BarChart(
      BarChartData(
        barGroups: _createBarGroups(revenueData, theme),
        alignment: BarChartAlignment.spaceAround,
        maxY: maxValue,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            
            tooltipPadding: const EdgeInsets.all(8),
            tooltipMargin: 8,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '\$${(rod.toY / 1000).toStringAsFixed(0)}K',
                TextStyle(
                  color: theme.colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (double value, TitleMeta meta) {
                if (value.toInt() >= 0 && value.toInt() < revenueData.length) {
                  return Text(
                    revenueData[value.toInt()].month,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (double value, TitleMeta meta) {
                // Show only a few reference points on y-axis
                if (value % (maxValue / 4) == 0 && value >= 0 && value <= maxValue) {
                  return Text(
                    '${(value / 1000).toInt()}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          horizontalInterval: maxValue / 4,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: theme.colorScheme.outline.withOpacity(0.2),
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups(List<MonthlyRevenue> data, ThemeData theme) {
    final primaryColor = theme.colorScheme.primary;
    
    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index].amount,
            color: primaryColor.withOpacity(0.7),
            width: 20,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
          ),
        ],
      );
    });
  }
} 