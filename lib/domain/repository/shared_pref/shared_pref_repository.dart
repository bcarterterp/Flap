abstract class SharedPrefRepository {
  init();
  Future<bool> isFirstAppLaunch();
  Future<bool> updateFirstAppLaunch(bool isFirstAppLaunch);
}
