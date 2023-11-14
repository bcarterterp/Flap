import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/presentation/providers/providers.dart';
import 'package:flap_app/presentation/screens/settings/notifier/settings_screen_state.dart';
import 'package:flap_app/presentation/screens/settings/view/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../domain/repository/firebase/firebase_messaging_fake.dart';
import '../../../../domain/repository/firebase/firebase_wrapper_fake.dart';
import '../notifier/settings_screen_state_notifier_fake.dart';
import '../settings_screen.dart';

void main() {
  // Note: This group performs the same validation as the integration
  // test example, difference being that these tests do not require
  // launching the app on an emulator for validation
  group('SettingsScreen Widget Tests', () {
    group("Unit tests with a fake SettingsScreenNotifier", () {
      testWidgets(
          'Given SettingsScreen is error state, then there should be firebaseMessageToken widget present.',
          (WidgetTester tester) async {
        // Causes test to wait for app to finish launch before testing
        final settingsScreen = Settingsscreen();
        final firebaseFake =
            FirebaseMessagingFake(wrapper: FirebaseWrapperFake());
        final settingsScreenStateNotifier =
            SettingsScreenStateNotifierFake(messageRepository: firebaseFake);

        settingsScreenStateNotifier.response = SettingsScreenState(
            tokenLoadEvent: EventError<String, Exception>(Exception()));

        await tester.pumpWidget(
            createContainerForSettingsWidget(settingsScreenStateNotifier));

        // Verify no errors present at first
        expect(settingsScreen.firebaseMessagingToken, findsNothing);
      });

      testWidgets(
          'Given SettingsScreen is in initial state, if token loads successfully, then expect firebaseMessageToken widget',
          (WidgetTester tester) async {
        // Causes test to wait for app to finish launch before testing
        final settingsScreen = Settingsscreen();
        final firebaseFake =
            FirebaseMessagingFake(wrapper: FirebaseWrapperFake());
        final settingsScreenStateNotifier =
            SettingsScreenStateNotifierFake(messageRepository: firebaseFake);

        settingsScreenStateNotifier.response = const SettingsScreenState(
            tokenLoadEvent: SuccessEvent<String, Exception>('token'));

        await tester.pumpWidget(
            createContainerForSettingsWidget(settingsScreenStateNotifier));

        await tester.pumpAndSettle();
        expect(settingsScreen.generalError, findsNothing);
        expect(settingsScreen.firebaseMessagingToken, findsOneWidget);
      });
    });
  });
}

ProviderScope createContainerForSettingsWidget(
    SettingsScreenStateNotifierFake? notifier) {
  return ProviderScope(
    overrides: [
      if (notifier != null)
        settingsPageStateProvider.overrideWith((ref) => notifier),
    ],
    child: const MaterialApp(
      home: SettingsScreen(),
    ),
  );
}
