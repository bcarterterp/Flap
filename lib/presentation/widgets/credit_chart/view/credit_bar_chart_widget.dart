import 'package:fl_chart/fl_chart.dart';
import 'package:flap_app/domain/entity/user_credit_history.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreditBarChartWidget extends StatelessWidget {
  const CreditBarChartWidget({
    super.key,
    required this.chartData,
  });

  final CreditChartData chartData;

  @override
  Widget build(BuildContext context) {
    final List<BarChartGroupData> barGroupRods = [];
    final List<CreditHistoryItem> relevantScoreData =
        chartData.relevantScoreData;

    var x = 0;
    for (CreditHistoryItem item in relevantScoreData) {
      barGroupRods.add(
        BarChartGroupData(
          x: x,
          barRods: [createBar(item, 265 / relevantScoreData.length)],
          barsSpace: 0,
          showingTooltipIndicators:
              DateTime.now().month == item.date.month ? [0] : null,
        ),
      );
      x += 1;
    }

    return BarChart(
      BarChartData(
        groupsSpace: 0,
        alignment: BarChartAlignment.spaceBetween,
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 20,
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                if (value == 0 ||
                    value == relevantScoreData.length - 1 ||
                    value == (relevantScoreData.length ~/ 2)) {
                  final title = relevantScoreData[value.toInt()].date.month ==
                          DateTime.now().month
                      ? "Today"
                      : DateFormat("MMM")
                          .format(relevantScoreData[value.toInt()].date);
                  return SideTitleWidget(
                    axisSide: AxisSide.bottom,
                    child: Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          rightTitles: const AxisTitles(),
          topTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 40,
              showTitles: true,
              interval: chartData.scoreInterval,
              getTitlesWidget: (value, meta) {
                return SideTitleWidget(
                  axisSide: AxisSide.left,
                  child: Text("${value.toInt()}"),
                );
              },
            ),
          ),
        ),
        maxY: chartData.max,
        minY: chartData.min,
        barGroups: barGroupRods,
        gridData: FlGridData(
          drawVerticalLine: false,
          horizontalInterval: chartData.scoreInterval,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color.fromARGB(135, 142, 155, 175),
              strokeWidth: 0.6,
              dashArray: [2, 2],
            );
          },
        ),
        borderData: FlBorderData(show: false),
        barTouchData: BarTouchData(
          enabled: false,
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.transparent,
            fitInsideHorizontally: true,
            tooltipPadding: const EdgeInsets.all(0),
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              if (group.showingTooltipIndicators.isNotEmpty) {
                return BarTooltipItem(
                  rod.toY.toInt().toString(),
                  const TextStyle(
                    color: Color(0xFF183f5f),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                );
              } else {
                return null;
              }
            },
          ),
        ),
      ),
      swapAnimationDuration: const Duration(milliseconds: 250),
      swapAnimationCurve: Curves.decelerate,
    );
  }

  BarChartRodData createBar(CreditHistoryItem item, double barWidth) {
    bool isProjectionBar = item.date.isAfter(DateTime.now());

    return BarChartRodData(
      fromY: 0,
      toY: item.score.toDouble(),
      borderRadius: BorderRadius.zero,
      gradient: LinearGradient(
        colors: [
          const Color.fromARGB(0, 255, 255, 255),
          Color(ScoreGroup.getGroupForScore(item.score).color)
              .withAlpha(isProjectionBar ? 40 : 100),
          Color(ScoreGroup.getGroupForScore(item.score).color)
              .withAlpha(isProjectionBar ? 80 : 255),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      width: barWidth,
    );
  }
}
