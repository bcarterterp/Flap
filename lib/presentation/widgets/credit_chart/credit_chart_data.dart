import 'package:flap_app/domain/entity/user_credit_history.dart';

class CreditChartData {
  const CreditChartData({
    this.relevantScoreData = const [],
    this.scoreInterval = 100,
    this.goal = 0,
    this.min = 200,
    this.max = 750,
  });

  final List<CreditHistoryItem> relevantScoreData;
  final double scoreInterval;
  final double goal;
  final double min;
  final double max;
}
