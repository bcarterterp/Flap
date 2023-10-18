/// Generic class for handling a request in the domain layer. Should
/// only be used in the domain layer. There are 2 states:
/// 1. Success - The request has successfully completed, with the data set.
/// 2. Error - The request has failed, with the error set. Note that the error can
/// be any type, and is not limited to a string.
sealed class RequestResponse<Data, ErrorInfo> {}

class Loading<Data, ErrorInfo> extends RequestResponse<Data, ErrorInfo> {
  Loading();
}

class Success<Data, ErrorInfo> extends RequestResponse<Data, ErrorInfo> {
  final Data data;
  Success(this.data);
}

class Error<Data, ErrorInfo> extends RequestResponse<Data, ErrorInfo> {
  final ErrorInfo error;
  Error(this.error);
}
