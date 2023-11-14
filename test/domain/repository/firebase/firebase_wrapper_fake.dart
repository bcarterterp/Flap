import 'package:flap_app/domain/repository/firebase/firebase_wrapper.dart';

class FirebaseWrapperFake extends FirebaseWrapper {
  @override
  Future<bool> init() {
    return Future.value(true);
  }
}
