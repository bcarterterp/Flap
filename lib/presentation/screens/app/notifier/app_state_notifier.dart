import 'package:flap_app/domain/repository/firebase/firebase_messaging_repository.dart';
import 'package:flap_app/presentation/screens/app/notifier/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier({required FirebaseMessagingRepository firebaseMessaging})
      : _firebaseMessaging = firebaseMessaging,
        super(AppState.initial());

  final FirebaseMessagingRepository _firebaseMessaging;

  Future<void> initDependencies() async {
    state = AppState.loading();

    await _firebaseMessaging.init();
    state = AppState.success();
  }
}
