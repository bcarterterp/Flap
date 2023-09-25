/// Event class to encapsulate the state of an event, which
/// should only be used in the presentation layer. There are 4 states:
/// 1. Initial - The default state of the event. Signifies nothing has happened.
/// 2. Loading - The event is currently loading. Should set this as you are
/// making a request to the domain layer,
/// 3. Success - The event has successfully completed, with the data set.
/// 4. Error - The event has failed, with the error set. Note that the error can
/// be any type, and is not limited to a string.
/// 
/// Refer to [RequestResponse] for the domain layer equivilant.
class Event<D, E> {
  final bool loading;
  final D? data;
  final E? error;

  Event._({required this.loading, this.data, this.error});

  factory Event.initial() => Event._(loading: false);
  factory Event.success(D data) => Event._(data: data, loading: false);
  factory Event.error(E error) => Event._(error: error, loading: false);
  factory Event.loading() => Event._(loading: true);

  bool get isInitial => !loading && data == null && error == null;
  bool get isLoading => loading;
  bool get isSuccess => data != null;
  bool get isError => error != null;
}
