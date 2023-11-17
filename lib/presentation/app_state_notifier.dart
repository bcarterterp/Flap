import 'package:flap_app/domain/repository/shared_pref/shared_pref_repository.dart';
import 'package:flap_app/presentation/app_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier({required SharedPrefRepository sharedPrefRepository})
      : _sharedPrefRepository = sharedPrefRepository,
        super(AppState.initial());

  final SharedPrefRepository _sharedPrefRepository;

  Future<void> initDependencies() async {
    state = AppState.loading();

    await _sharedPrefRepository.init();
    state = AppState.success();
  }
}