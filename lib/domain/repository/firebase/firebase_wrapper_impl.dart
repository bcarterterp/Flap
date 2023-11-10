import 'package:firebase_core/firebase_core.dart';
import 'package:flap_app/domain/repository/firebase/firebase_wrapper.dart';
import 'package:flap_app/firebase_options.dart';

class FirebaseWrapperImpl extends FirebaseWrapper {
  FirebaseWrapperImpl() : _initialized = false;

  bool _initialized = false;

  @override
  Future<void> init() async {
    if (!_initialized) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      _initialized = true;
    }
  }
}
