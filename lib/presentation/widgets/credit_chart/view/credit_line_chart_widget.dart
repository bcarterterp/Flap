import 'package:fl_chart/fl_chart.dart';
import 'package:flap_app/domain/entity/user_credit_history.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreditLineChartWidget extends StatelessWidget {
  const CreditLineChartWidget({
    super.key,
    required this.chartData,
  });

  final CreditChartData chartData;

  @override
  Widget build(BuildContext context) {
    final List<LineChartBarData> chartBarsData = [];
    final List<CreditHistoryItem> relevantScoreData =
        chartData.relevantScoreData;
    var x = 0;

    for (int i = 0; i < relevantScoreData.length; i++) {
      final item = relevantScoreData[i];

      if (i + 1 < relevantScoreData.length) {
        final item2 = relevantScoreData[i + 1];
        chartBarsData.add(
          createBar(x, x + 1, item, item2),
        );
      } else {}
      x += 1;
    }

    return LineChart(
      LineChartData(
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
        lineBarsData: chartBarsData,
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
        lineTouchData: LineTouchData(
          enabled: true,
          getTouchLineStart: (barData, spotIndex) => 0,
          getTouchLineEnd: (barData, spotIndex) => barData.spots[0].y + 20,
          getTouchedSpotIndicator: (barData, spotIndexes) {
            List<TouchedSpotIndicatorData> items = [];

            for (int i = 0; i < spotIndexes.length; i++) {
              items.add(
                const TouchedSpotIndicatorData(
                    FlLine(
                        color: Color(0xff183f5f),
                        strokeWidth: 1.8,
                        dashArray: [5, 4]),
                    FlDotData(show: false)),
              );
            }
            return items;
          },
          touchTooltipData: LineTouchTooltipData(
            tooltipMargin: 30,
            tooltipBgColor: Colors.transparent,
            fitInsideHorizontally: true,
            tooltipPadding: const EdgeInsets.all(0),
            getTooltipItems: (List<LineBarSpot> spots) {
              List<LineTooltipItem> items = [];

              for (int i = 0; i < spots.length; i++) {
                if ((i == 0 && spots.length == 1) ||
                    (i == 1 && spots.length == 2)) {
                  items.add(LineTooltipItem(
                    spots[i].y.toInt().toString(),
                    const TextStyle(
                      color: Color(0xFF183f5f),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ));
                } else {
                  items.add(const LineTooltipItem("", TextStyle()));
                }
              }
              return items;
            },
          ),
        ),
      ),
    );
  }

  LineChartBarData createBar(
    int minX,
    int maxX,
    CreditHistoryItem item,
    CreditHistoryItem nextItem,
  ) {
    bool isProjectionBar = nextItem.date.isAfter(DateTime.now());
    bool isTodayBar = item.date.month == DateTime.now().month;

    return LineChartBarData(
      spots: [
        FlSpot(minX.toDouble(), item.score.toDouble()),
        FlSpot(maxX.toDouble(), nextItem.score.toDouble())
      ],
      color: Colors.transparent,
      showingIndicators: isTodayBar ? [0] : [],
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(0, 255, 255, 255),
            Color(ScoreGroup.getGroupForScore(nextItem.score).color)
                .withAlpha(isProjectionBar ? 40 : 100),
            Color(ScoreGroup.getGroupForScore(nextItem.score).color)
                .withAlpha(isProjectionBar ? 80 : 255),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }
}
