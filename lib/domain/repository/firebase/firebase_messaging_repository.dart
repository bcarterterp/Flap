abstract class FirebaseMessagingRepository {
  Future<void> init();
  Future<bool> hasAcceptedPermissions();
  Future<bool> requestPermissions();
  Future<String?> getToken();
}