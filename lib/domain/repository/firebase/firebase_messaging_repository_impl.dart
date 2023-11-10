import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flap_app/domain/repository/firebase/firebase_messaging_repository.dart';
import 'package:flap_app/domain/repository/firebase/firebase_wrapper.dart';

class FirebaseMessagingRepositoryImpl extends FirebaseMessagingRepository {
  FirebaseMessagingRepositoryImpl({required wrapper})
      : _firebaseWrapper = wrapper;

  final FirebaseWrapper _firebaseWrapper;
  late final FirebaseMessaging firebaseMessaging;

  @override
  Future<void> init() async {
    await _firebaseWrapper.init();
    firebaseMessaging = FirebaseMessaging.instance;
  }

  @override
  Future<bool> hasAcceptedPermissions() {
    return firebaseMessaging.getNotificationSettings().then((settings) {
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  Future<bool> requestPermissions() async {
    final settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  @override
  Future<String?> getToken() {
    return firebaseMessaging.getToken().then((token) {
      return token;
    });
  }
}
