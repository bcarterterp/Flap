import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/presentation/screens/settings/notifier/settings_screen_state.dart';
import 'package:flap_app/presentation/screens/settings/notifier/settings_screen_state_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../domain/repository/firebase/firebase_messaging_fake.dart';
import '../../../../domain/repository/firebase/firebase_wrapper_fake.dart';

void main() {
  group('testSettingsScreen', () {
    test(
        'returns success and updates SettingsPageState with firebase messaging token',
        () async {
      const mockToken = 'token';
      const successResponse =
          SuccessRequestResponse<String, Exception>(mockToken);

      final fakeFirebaseMessagingImpl =
          FirebaseMessagingFake(wrapper: FirebaseWrapperFake());
      final notifier = SettingsScreenStateNotifier(
          messageRepository: fakeFirebaseMessagingImpl);

      //Below is stubbed behavior for the getRandomRecipes call to return a successResponse
      fakeFirebaseMessagingImpl.changeTokenResponse(successResponse);

      // Call the getRandomRecipes method
      await notifier.fetchFirebaseMessagingToken();

      // Verify that SettingsScreenState is updated with a firebase messaging token
      expect(
          (notifier.state.tokenLoadEvent as SuccessEvent).data,
          (SettingsScreenState.success(mockToken).tokenLoadEvent
                  as SuccessEvent)
              .data);
    });

    test('returns error and updates SettingsPageState with error state',
        () async {
      final fakeFirebaseMessagingImpl =
          FirebaseMessagingFake(wrapper: FirebaseWrapperFake());

      final error = Exception('invalid');
      final errorResponse = ErrorRequestResponse<String, Exception>(error);
      fakeFirebaseMessagingImpl.changeTokenResponse(errorResponse);

      final notifier = SettingsScreenStateNotifier(
          messageRepository: fakeFirebaseMessagingImpl);

      // Call the getRandomRecipes method
      await notifier.fetchFirebaseMessagingToken();

      expect((notifier.state.tokenLoadEvent as EventError).error, error);
    });
  });
}
