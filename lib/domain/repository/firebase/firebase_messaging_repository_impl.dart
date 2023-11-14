import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/repository/firebase/firebase_messaging_repository.dart';
import 'package:flap_app/domain/repository/firebase/firebase_wrapper.dart';

class FirebaseMessagingRepositoryImpl extends FirebaseMessagingRepository {
  FirebaseMessagingRepositoryImpl({required wrapper})
      : _firebaseWrapper = wrapper;

  final FirebaseWrapper _firebaseWrapper;
  late final FirebaseMessaging firebaseMessaging;

  @override
  Future<void> init() async {
    final initialized = await _firebaseWrapper.init();
    if (initialized) firebaseMessaging = FirebaseMessaging.instance;
  }

  @override
  Future<bool> hasAcceptedPermissions() {
    return firebaseMessaging.getNotificationSettings().then((settings) {
      return settings.authorizationStatus == AuthorizationStatus.authorized;
    });
  }

  @override
  Future<RequestResponse<bool, Exception>> requestPermissions() async {
    try {
      final settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      final isAuthorized =
          settings.authorizationStatus == AuthorizationStatus.authorized;
      return SuccessRequestResponse(isAuthorized);
    } on Exception catch (e) {
      return ErrorRequestResponse(e);
    }
  }

  @override
  Future<RequestResponse<String, Exception>> getToken() async {
    try {
      final token = await firebaseMessaging.getToken();

      if (token != null) {
        return SuccessRequestResponse(token);
      } else {
        return ErrorRequestResponse(Exception("Null token"));
      }
    } on Exception catch (e) {
      return ErrorRequestResponse(e);
    }
  }
}
