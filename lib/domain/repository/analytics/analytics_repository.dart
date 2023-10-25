import 'package:flap_app/domain/entity/request_response.dart';

abstract class AnalyticsRepository {
  Future<RequestResponse<void, void>> logEvent(
      String name, Map<String, dynamic> parameters);

  Future<RequestResponse<void, void>> setUserProperties(
      String userId, Map<String, dynamic> properties);

  Future<RequestResponse<void, void>> screenView(String screenName);
}
