import 'package:flap_app/domain/repository/analytics/analytics_repository.dart';
import 'package:flap_app/domain/entity/request_response.dart';

class AnalyticsDummyPlatform implements AnalyticsRepository {
  @override
  Future<RequestResponse<void, void>> logEvent(
      String name, Map<String, dynamic> parameters) async {
    print('AnalyticsDummyPlatform: logEvent: $name, $parameters');
    return Future.value(Success(null));
  }

  @override
  Future<RequestResponse<void, void>> setUserProperties(
      String userId, Map<String, dynamic> properties) {
    print('AnalyticsDummyPlatform: setUserProperties: $userId, $properties');
    return Future.value(Success(null));
  }

  @override
  Future<RequestResponse<void, void>> screenView(String screenName) {
    print('AnalyticsDummyPlatform: screenView: $screenName');
    return Future.value(Success(null));
  }
}

class AnalyticsRepositoryImpl {
  final List<AnalyticsRepository> _analyticsPlatforms = [AnalyticsDummyPlatform()];

  void logEvent(String name, Map<String, dynamic> parameters) {
    for (var analyticsPlatform in _analyticsPlatforms) {
      analyticsPlatform.logEvent(name, parameters);
    }
  }

  void setUserProperties(String userId, Map<String, dynamic> properties) {
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
