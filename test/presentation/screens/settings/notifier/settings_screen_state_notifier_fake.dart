import 'package:flap_app/presentation/screens/settings/notifier/settings_screen_state.dart';
import 'package:flap_app/presentation/screens/settings/notifier/settings_screen_state_notifier.dart';

class SettingsScreenStateNotifierFake extends SettingsScreenStateNotifier {
  SettingsScreenStateNotifierFake({required super.messageRepository});

  SettingsScreenState response = SettingsScreenState.initial();

  void changeResponse(SettingsScreenState response) {
    this.response = response;
  }

  @override
  Future<void> fetchFirebaseMessagingToken() async {
    state = response;
    return;
  }
}
