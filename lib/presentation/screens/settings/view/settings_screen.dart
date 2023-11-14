import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/home/widgets/screen_states/error_screen.dart';
import 'package:flap_app/presentation/screens/home/widgets/screen_states/loading_screen.dart';
import 'package:flap_app/presentation/screens/settings/notifier/settings_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() {
    return _SettingsScreenState();
  }
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(settingsPageStateProvider.notifier)
          .fetchFirebaseMessagingToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsPageStateProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: switch (state.tokenLoadEvent) {
          InitialEvent() => const LoadingScreenWidget(),
          LoadingEvent() => const LoadingScreenWidget(),
          SuccessEvent() => SettingsPageContent(state: state),
          EventError() => const ErrorScreenWidget(),
        });
  }
}

class SettingsPageContent extends ConsumerWidget {
  final SettingsScreenState state;

  const SettingsPageContent({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          if (state.tokenLoadEvent is SuccessEvent)
            Row(
              children: [
                const Text("Firebase Messaging\nToken"),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    (state.tokenLoadEvent as SuccessEvent).data,
                    key: const ValueKey('firebaseMessagingToken'),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
