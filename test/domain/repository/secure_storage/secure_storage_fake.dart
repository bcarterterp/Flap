import 'package:flap_app/data/repository/secure_storage/secure_storage_impl.dart';
import 'package:flap_app/domain/entity/request_response.dart';
import 'package:flap_app/domain/entity/storage_error.dart';

class SecureStorageFake extends SecureStorageImpl {
  Future<RequestResponse<String, StorageError>> writeResponse =
      Future.value(const SuccessRequestResponse('Successfully saved jwt'));

  @override
  Future<RequestResponse<String, StorageError>> deleteJwt() async {
    return const SuccessRequestResponse('Successfully deleted');
  }

  @override
  Future<RequestResponse<String?, StorageError>> readJwt() async {
    return const SuccessRequestResponse('test_jwt');
  }

  Future<RequestResponse<String?, StorageError>> readJwtError() async {
    return const ErrorRequestResponse(StorageError.readError);
  }

  void changeWriteResponse(
      Future<RequestResponse<String, StorageError>> writeResponse) {
    this.writeResponse = writeResponse;
  }

  @override
  Future<RequestResponse<String, StorageError>> writeJwt(String token) async {
    return writeResponse;
  }
}
