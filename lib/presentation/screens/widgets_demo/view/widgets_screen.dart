import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/widgets/credit_score_widget.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final creditInfoState = ref.watch(userCreditInfoProvider);

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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30),
          CreditScoreWidget(creditInfo: creditInfoState),
        ],
      ),
    );
  }
}
