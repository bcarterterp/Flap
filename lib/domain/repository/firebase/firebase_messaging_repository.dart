import 'package:flap_app/domain/entity/request_response.dart';

abstract class FirebaseMessagingRepository {
  Future<void> init();
  Future<bool> hasAcceptedPermissions();
  Future<RequestResponse<bool, Exception>> requestPermissions();
  Future<RequestResponse<String, Exception>> getToken();
}
