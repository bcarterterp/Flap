import 'package:flap_app/domain/repository/analytics/analytics_repository.dart';
class AnalyticsRepositoryImpl {
  /// List of analytics platforms to send events to.
  final List<AnalyticsRepository> _analyticsPlatforms = [];

  void logEvent(String name, Map<String, Object> parameters) {
    for (var analyticsPlatform in _analyticsPlatforms) {
      analyticsPlatform.logEvent(name, parameters);
    }
  }

  void setUserProperties(String userId, Map<String, Object> properties) {
    for (var analyticsPlatform in _analyticsPlatforms) {
      analyticsPlatform.setUserProperties(userId, properties);
    }
  }

  void screenView(String screenName) {
    for (var analyticsPlatform in _analyticsPlatforms) {
      analyticsPlatform.screenView(screenName);
    }
  }
}
