import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/user_credit_history.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_history_chart_widget.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../util/provider_container.dart';
import '../../repository/credit/credit_repository_fake.dart';

main() {
  final creditRepository = CreditRepositoryFake();
  group("CreditScoreUseCase Unit Tests", () {
    test(
      "Given initial CreditScoreUseCase, when getCreditHistoryChartData called expect min is the closest 100th value to lowest score in user's history.",
      () async {
        final container = createContainer(
          overrides: [
            creditScoreRepositoryProvider
                .overrideWith((ref) => creditRepository),
          ],
        );

        final creditHistory = UserCreditHistory(data: [
          CreditHistoryItem(date: DateTime(2023, 8), score: 665),
          CreditHistoryItem(date: DateTime(2023, 9), score: 703),
        ]);

        final now = DateTime(2023, 12, 1);

        creditRepository
            .changeCreditHistoryResponse(SuccessRequestResponse(creditHistory));

        final useCase = container.read(creditScoreUseCaseProvider);
        final response =
            await useCase.getCreditHistoryChartData(Period.past5Months, 0, now);

        response as SuccessRequestResponse<CreditChartData, CreditError>;

        expect(response.data.min, 600);
      },
    );

    test(
      "Given initial CreditScoreUseCase, when getCreditHistoryChartData called expect max is the closest 100th value above highest credit score in user's history.",
      () async {
        final container = createContainer(
          overrides: [
            creditScoreRepositoryProvider
                .overrideWith((ref) => creditRepository),
          ],
        );

        final creditHistory = UserCreditHistory(data: [
          CreditHistoryItem(date: DateTime(2023, 8), score: 665),
          CreditHistoryItem(date: DateTime(2023, 9), score: 599),
        ]);

        final now = DateTime(2023, 12, 1);

        creditRepository
            .changeCreditHistoryResponse(SuccessRequestResponse(creditHistory));

        final useCase = container.read(creditScoreUseCaseProvider);
        final response =
            await useCase.getCreditHistoryChartData(Period.past5Months, 0, now);

        response as SuccessRequestResponse<CreditChartData, CreditError>;

        expect(response.data.max, 700);
      },
    );

    test(
      "Given initial CreditScoreUseCase, when getCreditHistoryChartData called with Past5Months period, return only last 5 months of data.",
      () async {
        final container = createContainer(
          overrides: [
            creditScoreRepositoryProvider
                .overrideWith((ref) => creditRepository),
          ],
        );

        final creditHistory = UserCreditHistory(data: [
          CreditHistoryItem(date: DateTime(2023, 6), score: 615),
          CreditHistoryItem(date: DateTime(2023, 7), score: 650),
          CreditHistoryItem(date: DateTime(2023, 8), score: 665),
          CreditHistoryItem(date: DateTime(2023, 9), score: 678),
          CreditHistoryItem(date: DateTime(2023, 10), score: 692),
          CreditHistoryItem(date: DateTime(2023, 11), score: 699),
          CreditHistoryItem(date: DateTime(2023, 12), score: 750),
        ]);

        final now = DateTime(2023, 12, 1);

        creditRepository
            .changeCreditHistoryResponse(SuccessRequestResponse(creditHistory));

        final useCase = container.read(creditScoreUseCaseProvider);
        final response =
            await useCase.getCreditHistoryChartData(Period.past5Months, 0, now);

        final expectedData = creditHistory.data
            .getRange(creditHistory.data.length - 5, creditHistory.data.length)
            .toList();

        response as SuccessRequestResponse<CreditChartData, CreditError>;

        expect(response.data.relevantScoreData, expectedData);
      },
    );

    test(
      "Given initial CreditScoreUseCase, when getCreditHistoryChartData called with OneYear period, return only last 12 months of data.",
      () async {
        final container = createContainer(
          overrides: [
            creditScoreRepositoryProvider
                .overrideWith((ref) => creditRepository),
          ],
        );

        final creditHistory = UserCreditHistory(data: [
          CreditHistoryItem(date: DateTime(2022, 10), score: 500),
          CreditHistoryItem(date: DateTime(2022, 11), score: 515),
          CreditHistoryItem(date: DateTime(2022, 12), score: 502),
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
        ]);

        final now = DateTime(2023, 12, 1);

        creditRepository
            .changeCreditHistoryResponse(SuccessRequestResponse(creditHistory));

        final useCase = container.read(creditScoreUseCaseProvider);
        final response =
            await useCase.getCreditHistoryChartData(Period.oneYear, 0, now);

        final expectedData = creditHistory.data.getRange(0, 12).toList();

        response as SuccessRequestResponse<CreditChartData, CreditError>;

        expect(response.data.relevantScoreData, expectedData);
      },
    );

    test(
      "Given initial CreditScoreUseCase, when getCreditHistoryChartData called with a goal above their current score, return [Period] months of data PLUS projected month score data.",
      () async {
        final container = createContainer(
          overrides: [
            creditScoreRepositoryProvider
                .overrideWith((ref) => creditRepository),
          ],
        );

        final creditHistory = UserCreditHistory(data: [
          CreditHistoryItem(date: DateTime(2023, 6), score: 615),
          CreditHistoryItem(date: DateTime(2023, 7), score: 650),
          CreditHistoryItem(date: DateTime(2023, 8), score: 665),
          CreditHistoryItem(date: DateTime(2023, 9), score: 678),
          CreditHistoryItem(date: DateTime(2023, 10), score: 692),
          CreditHistoryItem(date: DateTime(2023, 11), score: 699),
          CreditHistoryItem(date: DateTime(2023, 12), score: 750),
        ]);

        final projectedScores = UserCreditHistory(data: [
          CreditHistoryItem(date: DateTime(2024, 1), score: 775),
          CreditHistoryItem(date: DateTime(2024, 2), score: 800),
          CreditHistoryItem(date: DateTime(2024, 3), score: 825),
          CreditHistoryItem(date: DateTime(2024, 4), score: 850),
        ]);

        final now = DateTime(2023, 12, 1);

        creditRepository
            .changeCreditHistoryResponse(SuccessRequestResponse(creditHistory));

        final useCase = container.read(creditScoreUseCaseProvider);
        final response = await useCase.getCreditHistoryChartData(
            Period.past5Months, 850, now);

        final expectedData = creditHistory.data
            .getRange(creditHistory.data.length - 5, creditHistory.data.length)
            .toList();

        expectedData.addAll(projectedScores.data);

        response as SuccessRequestResponse<CreditChartData, CreditError>;

        expect(response.data.relevantScoreData, expectedData);
      },
    );
  });
}
