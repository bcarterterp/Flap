import 'package:flap_app/presentation/widgets/credit_chart/view/credit_history_chart_widget.dart';
import 'package:flap_app/presentation/widgets/credit_score/credit_score_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WidgetsScreen extends ConsumerStatefulWidget {
  const WidgetsScreen({super.key});

  @override
  ConsumerState<WidgetsScreen> createState() {
    return _WidgetsScreenState();
  }
}

class _WidgetsScreenState extends ConsumerState<WidgetsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 238, 238),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          leading: BackButton(
            onPressed: () => context.pop(),
          ),
          title: const Text('Demo Widgets'),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 45),
            CreditScoreWidget(),
            CreditHistoryChartWidget(
              chartType: ChartType.linear,
              goal: 790,
            ),
            SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
