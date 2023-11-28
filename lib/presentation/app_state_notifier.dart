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

    //This Future.delayed is to simulate a lengthy amount of time for the app to initialize
    //For real development, free to remove this block of code except for lines 18-19
    Future.delayed(const Duration(milliseconds: 1200), () {
      _sharedPrefRepository.init();
      state = AppState.success();
    });
  }
}
