import 'package:fl_chart/fl_chart.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flutter/material.dart';

class CreditHistoryChartWidget extends StatelessWidget {
  const CreditHistoryChartWidget({
    super.key,
    required this.creditInfo,
  });

  final UserCreditInfo creditInfo;

  @override
  Widget build(BuildContext context) {
    const cardColor = Color.fromARGB(255, 250, 250, 250);
    BoxShadow cardShadow = const BoxShadow(
      color: Color.fromARGB(96, 109, 109, 109),
      offset: Offset(0, 2),
      blurRadius: 22,
      spreadRadius: -3,
    );

    final getScoreButton = FilledButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 18, horizontal: 22),
        ),
        backgroundColor: const MaterialStatePropertyAll(Color(0xff183F5F)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(
              color: Color(0xffC9EAF9),
              strokeAlign: BorderSide.strokeAlignOutside,
              width: 4,
            ),
          ),
        ),
      ),
      child: const Text(
        "Get an Updated Score",
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      ),
    );

    return SizedBox(
      width: double.infinity,
      height: 550,
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [cardShadow],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Your Credit History',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
            ),
            Expanded(child: CreditBarChartWidget()),
            getScoreButton,
          ],
        ),
      ),
    );
  }
}

class CreditBarChartWidget extends StatelessWidget {
  CreditBarChartWidget({super.key});

  final scoreData = {
    "Jan": 300,
    "Feb": 330,
    "Mar": 322,
    "Apr": 400,
    "May": 412,
    "Jun": 415,
    "Jul": 400,
    "Aug": 405,
    "Sep": 420,
    "Oct": 434,
    "Nov": 452,
    "Dec": 460,
  };

  @override
  Widget build(BuildContext context) {
    final List<BarChartGroupData> barGroupRods = [];

    var x = 0;
    scoreData.forEach((key, value) {
      barGroupRods.add(
        BarChartGroupData(
          x: x,
          barRods: [createBar(value.toDouble())],
          barsSpace: 0,
        ),
      );
      x += 20;
    });

    return BarChart(
      BarChartData(
        groupsSpace: 0,
        alignment: BarChartAlignment.start,
        maxY: 850,
        minY: 200,
        barGroups: barGroupRods,
      ),
      swapAnimationDuration: const Duration(milliseconds: 150),
      swapAnimationCurve: Curves.linear,
    );
  }

  BarChartRodData createBar(double score) {
    return BarChartRodData(
      fromY: 0,
      toY: score,
      color: const Color.fromARGB(255, 7, 157, 79),
      width: 20.0,
    );
  }
}
