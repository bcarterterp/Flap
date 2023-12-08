abstract class SharedPrefRepository {
  init();
  bool isFirstAppLaunch();
  Future<bool> updateFirstAppLaunch(bool isFirstAppLaunch);
}
