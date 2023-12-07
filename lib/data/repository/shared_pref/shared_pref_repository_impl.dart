import 'package:flap_app/domain/repository/shared_pref/shared_pref_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefRepositoryImpl extends SharedPrefRepository {
  late SharedPreferences _sharedPrefs;
  @override
  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> isFirstAppLaunch() async {
    // If its the first app launch, isFirstAppLaunch field will not be created yet and return null
    return _sharedPrefs.getBool("isFirstAppLaunch") ?? true;
  }

  @override
  Future<bool> updateFirstAppLaunch(bool isFirstAppLaunch) async {
    // If its the first app launch, isFirstAppLaunch field will not be created yet and return null
    return _sharedPrefs.setBool("isFirstAppLaunch", isFirstAppLaunch);
  }
}
