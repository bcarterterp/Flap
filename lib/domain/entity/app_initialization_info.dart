class AppInitializationInfo {
  const AppInitializationInfo({
    this.isUserAuthenticated,
    this.isFirstTimeAppLaunch,
  });

  final bool? isUserAuthenticated;
  final bool? isFirstTimeAppLaunch;

  bool getIsUserAuthenticated() => false; //isUserAuthenticated ?? false;
  bool getIsFirstTimeAppLaunch() => false; //isFirstTimeAppLaunch ?? true;
}
