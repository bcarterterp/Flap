/**
 * Analytics Repository
 * Abstract Class used for implementing analytics platforms
 */
abstract class AnalyticsRepository {
  void logEvent(
      String name, Map<String, dynamic> parameters);

  void setUserProperties(
      String userId, Map<String, dynamic> properties);

  void screenView(String screenName);
}
