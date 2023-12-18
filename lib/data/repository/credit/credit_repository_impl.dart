import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_history.dart';
import 'package:flap_app/domain/entity/user_credit_info.dart';
import 'package:flap_app/domain/repository/credit/credit_repository.dart';

class CreditScoreRepositoryImpl extends CreditScoreRepository {
  final creditHistoryData = [
    CreditHistoryItem(date: DateTime(2023, 1), score: 500),
    CreditHistoryItem(date: DateTime(2023, 2), score: 530),
    CreditHistoryItem(date: DateTime(2023, 3), score: 522),
    CreditHistoryItem(date: DateTime(2023, 4), score: 570),
    CreditHistoryItem(date: DateTime(2023, 5), score: 612),
    CreditHistoryItem(date: DateTime(2023, 6), score: 615),
    CreditHistoryItem(date: DateTime(2023, 7), score: 650),
    CreditHistoryItem(date: DateTime(2023, 8), score: 665),
    CreditHistoryItem(date: DateTime(2023, 9), score: 678),
    CreditHistoryItem(date: DateTime(2023, 10), score: 692),
    CreditHistoryItem(date: DateTime(2023, 11), score: 699),
    CreditHistoryItem(date: DateTime(2023, 12), score: 750),
  ];

  @override
  Future<RequestResponse<UserCreditInfo, CreditError>> getCurrentScore() async {
    await Future.delayed(const Duration(seconds: 1));

    return Future.value(
      SuccessRequestResponse(
        UserCreditInfo(score: 801, scoreDifference: 28),
      ),
    );
  }

  @override
  Future<RequestResponse<UserCreditHistory, CreditError>>
      getCreditHistory() async {
    await Future.delayed(const Duration(seconds: 1));

    return Future.value(
      SuccessRequestResponse(
        UserCreditHistory(data: creditHistoryData),
      ),
    );
  }
}
