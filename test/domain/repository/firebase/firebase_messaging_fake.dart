import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/firebase/firebase_messaging_repository_impl.dart';

class FirebaseMessagingFake extends FirebaseMessagingRepositoryImpl {
  FirebaseMessagingFake({required super.wrapper});

  Future<RequestResponse<String, Exception>> tokenResponse =
      Future.value(const SuccessRequestResponse('token'));

  Future<bool> hasAcceptedPermission = Future.value(true);

  @override
  Future<void> init() {
    return Future.value();
  }

  @override
  Future<bool> hasAcceptedPermissions() {
    return hasAcceptedPermission;
  }

  @override
  Future<RequestResponse<String, Exception>> getToken() {
    return tokenResponse;
  }

  @override
  Future<RequestResponse<bool, Exception>> requestPermissions() {
    return Future.value(const SuccessRequestResponse(true));
  }

  void changeTokenResponse(RequestResponse<String, Exception> tokenResponse) {
    this.tokenResponse = Future.value(tokenResponse);
  }
}
