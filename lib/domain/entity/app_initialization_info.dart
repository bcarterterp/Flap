class AppInitializationInfo {
  const AppInitializationInfo({
    this.isUserAuthenticated,
    this.isFirstTimeAppLaunch,
  });

  final bool? isUserAuthenticated;
  final bool? isFirstTimeAppLaunch;

  bool getIsUserAuthenticated() => isUserAuthenticated ?? false;
  bool getIsFirstTimeAppLaunch() => isFirstTimeAppLaunch ?? true;
}
