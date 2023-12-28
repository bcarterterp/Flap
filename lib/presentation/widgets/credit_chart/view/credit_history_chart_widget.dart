import 'package:flap_app/domain/entity/credit_error.dart';
import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_bar_chart_widget.dart';
import 'package:flap_app/presentation/widgets/credit_chart/credit_chart_data.dart';
import 'package:flap_app/presentation/widgets/credit_chart/view/credit_line_chart_widget.dart';
import 'package:flap_app/presentation/widgets/credit_chart/notifier/credit_chart_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreditHistoryChartWidget extends ConsumerStatefulWidget {
  const CreditHistoryChartWidget({
    super.key,
    required this.chartType,
    required this.goal,
  });

  final double goal;
  final ChartType chartType;

  @override
  ConsumerState<CreditHistoryChartWidget> createState() {
    return _CreditHistoryChartWidgetState();
  }
}

class _CreditHistoryChartWidgetState
    extends ConsumerState<CreditHistoryChartWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchChartData(Period.past5Months, DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(creditChartStateNotifierProvider);

    const period = Period.past5Months;
    final currentDate = DateTime.now();

    const cardColor = Color.fromARGB(255, 250, 250, 250);
    BoxShadow cardShadow = const BoxShadow(
      color: Color.fromARGB(96, 109, 109, 109),
      offset: Offset(0, 2),
      blurRadius: 22,
      spreadRadius: -3,
    );

    bool errorVisible = state.viewData is EventError;
    bool isLoading = state.viewData is LoadingEvent;

    Widget bodyWidget = SizedBox(
      width: double.infinity,
      height: 270,
      child: _getBodyWidget(state.viewData),
    );

    final getScoreButton = FilledButton(
      onPressed: isLoading
          ? null
          : () {
              fetchChartData(period, currentDate);
            },
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(
          EdgeInsets.symmetric(vertical: 13, horizontal: 22),
        ),
        backgroundColor: MaterialStateProperty.resolveWith((states) =>
            states.contains(MaterialState.disabled)
                ? const Color.fromARGB(182, 24, 63, 95)
                : const Color(0xff183f5f)),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(
              color: Color(0xffC9EAF9),
              strokeAlign: BorderSide.strokeAlignOutside,
              width: 4,
            ),
          ),
        ),
      ),
      child: Text(errorVisible ? "Retry" : "Get an Updated Score",
          style: const TextStyle(
              color: Color(0xfffafafa),
              fontWeight: FontWeight.w600,
              fontSize: 16)),
    );

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(32),
        padding: const EdgeInsets.fromLTRB(20, 26, 20, 20),
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
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 19),
            ),
            const SizedBox(height: 24),
            bodyWidget,
            const SizedBox(height: 38),
            getScoreButton,
          ],
        ),
      ),
    );
  }

  Widget _getBodyWidget(Event<CreditChartData, CreditError> event) {
    switch (event) {
      case SuccessEvent():
        return widget.chartType == ChartType.bar
            ? CreditBarChartWidget(chartData: event.data)
            : CreditLineChartWidget(chartData: event.data);
      case LoadingEvent():
        return const Center(child: CircularProgressIndicator());
      case EventError():
        return const Center(child: Text("Error fetching data."));
      case InitialEvent():
        return const SizedBox();
    }
  }

  void fetchChartData(Period period, DateTime currentDate) {
    ref.read(creditChartStateNotifierProvider.notifier).getChartData(
          period,
          widget.goal,
          currentDate,
        );
  }
}

enum ChartType { bar, linear }

enum Period {
  past5Months(lengthInMonths: 5),
  oneYear(lengthInMonths: 12);

  const Period({required this.lengthInMonths});

  final int lengthInMonths;
}
