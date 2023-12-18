import 'dart:math';

import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_history.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/domain/repository/credit/credit_repository.dart';
import 'package:flap_app/domain/usecase/credit/credit_score_use_case.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_history_chart_widget.dart';

class CreditScoreUseCaseImpl extends CreditScoreUseCase {
  CreditScoreUseCaseImpl({required creditScoreRepository})
      : _creditScoreRepository = creditScoreRepository;

  final CreditScoreRepository _creditScoreRepository;

  @override
  Future<RequestResponse<CreditChartData, CreditError>>
      getCreditHistoryChartData(
          Period period, double goal, DateTime currentDate) async {
    final response = await _creditScoreRepository.getCreditHistory();

    if (response is SuccessRequestResponse) {
      (response as SuccessRequestResponse<UserCreditHistory, CreditError>);

      final allData = response.data.data;

      final creditHistoryChartData =
          getChartData(allData, period, currentDate, goal);

      return SuccessRequestResponse(creditHistoryChartData);
    } else {
      (response as ErrorRequestResponse<UserCreditHistory, CreditError>);

      return ErrorRequestResponse(response.error);
    }
  }

  @override
  Future<RequestResponse<UserCreditInfo, CreditError>> getCurrentScore() {
    return _creditScoreRepository.getCurrentScore();
  }

  CreditChartData getChartData(
    List<CreditHistoryItem> creditScoreHistory,
    Period period,
    DateTime currentDate,
    double goal,
  ) {
    final monthsToShow = period.lengthInMonths;
    const scoreInterval = 100;

    final List<CreditHistoryItem> relevantScoreData = [];

    var monthsAdded = 0;
    // Grab data only from months within [monthsToShow] of [currentDate]
    for (CreditHistoryItem item in creditScoreHistory) {
      final differenceInMonths = (currentDate.month - item.date.month).abs();

      if (monthsAdded < period.lengthInMonths &&
          differenceInMonths < monthsToShow &&
          currentDate.year == DateTime.now().year) {
        relevantScoreData.add(item);
        monthsAdded++;
      }
    }

    // create [UserCreditHistory] items for projected months from
    // [currentDate] score to user's goal score (only if applicable)
    if (currentDate.month == DateTime.now().month &&
        relevantScoreData.isNotEmpty) {
      final latestScore = relevantScoreData[relevantScoreData.length - 1];
      final differenceToGoal = goal - latestScore.score;

      if (differenceToGoal > 0) {
        var nextScore =
            latestScore.score + (differenceToGoal ~/ (monthsToShow - 1));
        var tempCurDate = currentDate;
        for (int i = 0; i < monthsToShow - 1; i++) {
          final now = DateTime.now();

          final nextMonth = tempCurDate.month == DateTime.december
              ? DateTime.january
              : tempCurDate.month + 1;
          final nextYear =
              nextMonth == DateTime.january ? now.year + 1 : tempCurDate.year;
          relevantScoreData.add(
            CreditHistoryItem(
                date: DateTime(nextYear, nextMonth), score: nextScore),
          );

          tempCurDate = DateTime(nextYear, nextMonth);
          nextScore += (differenceToGoal ~/ (monthsToShow - 1));
        }
      }
    }

    var minScore = ScoreGroup.excellent.range.max;
    var maxScore = 0;

    for (CreditHistoryItem item in relevantScoreData) {
      if (item.score < minScore) {
        minScore = item.score;
      }
      if (item.score > maxScore) {
        maxScore = item.score;
      }
    }

    maxScore = ((max(maxScore, goal) / scoreInterval).ceil()) * scoreInterval;
    minScore =
        (((minScore / scoreInterval).ceil()) * scoreInterval) - scoreInterval;
    var tempMin = minScore;

    while (tempMin <= maxScore) {
      tempMin += scoreInterval;
    }

    return CreditChartData(
      relevantScoreData: relevantScoreData,
      scoreInterval: scoreInterval.toDouble(),
      goal: goal.toDouble(),
      min: minScore.toDouble(),
      max: maxScore.toDouble(),
    );
  }
}
