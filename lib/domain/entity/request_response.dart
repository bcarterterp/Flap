/// Generic class for handling a request in the domain layer. Should
/// only be used in the domain layer. There are 2 states:
/// 1. Success - The request has successfully completed, with the data set.
/// 2. Error - The request has failed, with the error set. Note that the error can
/// be any type, and is not limited to a string.
sealed class RequestResponse<Data, Info> {}

class Success<Data, Info> extends RequestResponse<Data, Info> {
  final Data data;
  Success(this.data);
}

class Error<Data, Info> extends RequestResponse<Data, Info> {
  final Info error;
  Error(this.error);
}
