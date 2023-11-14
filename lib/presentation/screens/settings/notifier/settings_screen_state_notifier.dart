import 'package:flap_app/domain/entity/event.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/firebase/firebase_messaging_repository_impl.dart';
import 'package:flap_app/presentation/screens/settings/notifier/settings_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreenStateNotifier extends StateNotifier<SettingsScreenState> {
  SettingsScreenStateNotifier({required messageRepository})
      : _messagingRepository = messageRepository,
        super(SettingsScreenState.initial());

  final FirebaseMessagingRepositoryImpl _messagingRepository;

  Future<void> fetchFirebaseMessagingToken() async {
    if (state.tokenLoadEvent is LoadingEvent) {
      return;
    }
    state = SettingsScreenState.loading();

    final response = await _messagingRepository.getToken();

    switch (response) {
      case SuccessRequestResponse<String, Exception>():
        state = SettingsScreenState.success(response.data);
      case ErrorRequestResponse<String, Exception>():
        state = SettingsScreenState.error(response.error);
    }
  }
}
