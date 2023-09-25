
/// Generic class for handling a request in the domain layer. Should
/// only be used in the domain layer. There are 2 states:
/// 1. Success - The request has successfully completed, with the data set.
/// 2. Error - The request has failed, with the error set. Note that the error can
/// be any type, and is not limited to a string. 
class RequestResponse<D, E> {
  final D? data;
  final E? error;

  RequestResponse._({this.data, this.error});
  factory RequestResponse.success(D data) => RequestResponse._(data: data);
  factory RequestResponse.error(E error) => RequestResponse._(error: error);

  bool get isSuccess => data != null;
  bool get isError => error != null;
}
