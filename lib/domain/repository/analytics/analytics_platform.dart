/// Analytics Platform
/// Abstract Class used for implementing analytics platforms
abstract class AnalyticsPlatform {
  void logEvent(
      String name, Map<String, Object> parameters);

  void setUserProperties(
      String userId, Map<String, Object> properties);

  void screenView(String screenName);
}
