import 'package:flap_app/domain/repository/analytics/analytics_platform.dart';

class AnalyticsPlatformManager  extends AnalyticsPlatform{
  /// List of analytics platforms to send events to.
  final List<AnalyticsPlatform> _analyticsPlatforms = [];

  @override
  void logEvent(String name, Map<String, Object> parameters) {
    for (var analyticsPlatform in _analyticsPlatforms) {
      analyticsPlatform.logEvent(name, parameters);
    }
  }

  @override
  void setUserProperties(String userId, Map<String, Object> properties) {
    for (var analyticsPlatform in _analyticsPlatforms) {
      analyticsPlatform.setUserProperties(userId, properties);
    }
  }

  @override
  void screenView(String screenName) {
    for (var analyticsPlatform in _analyticsPlatforms) {
      analyticsPlatform.screenView(screenName);
    }
  }
}
