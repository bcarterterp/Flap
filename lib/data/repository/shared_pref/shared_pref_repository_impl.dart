import 'package:flap_app/domain/repository/shared_pref/shared_pref_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepositoryImpl extends SharedPrefRepository {
  late SharedPreferences sharedPrefs;
  @override
  Future<void> init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  @override
  bool isFirstAppLaunch() {
    // If its the first app launch, isFirstAppLaunch field will not be created yet and return null
    return sharedPrefs.getBool("isFirstAppLaunch") ?? true;
  }

  @override
  Future<bool> updateFirstAppLaunch(bool isFirstAppLaunch) async {
    // If its the first app launch, isFirstAppLaunch field will not be created yet and return null
    return sharedPrefs.setBool("isFirstAppLaunch", isFirstAppLaunch);
  }
}
