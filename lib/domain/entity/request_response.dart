/// Generic class for handling a request in the domain layer. Should
/// only be used in the domain layer. There are 2 states:
/// 1. Success - The request has successfully completed, with the data set.
/// 2. Error - The request has failed, with the error set. Note that the error can
/// be any type, and is not limited to a string.
sealed class RequestResponse<Data, ErrorInfo> {}

class SuccessRequestResponse<Data, ErrorInfo>
    extends RequestResponse<Data, ErrorInfo> {
  final Data data;
  SuccessRequestResponse(this.data);

  Data get() => data;
}

class ErrorRequestResponse<Data, ErrorInfo>
    extends RequestResponse<Data, ErrorInfo> {
  final ErrorInfo error;
  ErrorRequestResponse(this.error);
  ErrorInfo get() => error;
}
