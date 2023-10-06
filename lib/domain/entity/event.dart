/// Event class to encapsulate the state of an event, which
/// should only be used in the presentation layer. There are 4 states:
/// 1. InitialEvent - The default state of the event. Signifies nothing has happened.
/// 2. LoadingEvent - The event is currently loading. Should set this as you are
/// making a request to the domain layer,
/// 3. EventSuccess - The event has successfully completed, with the data set.
/// 4. EventError - The event has failed, with the error set. Note that the error can
/// be any type, and is not limited to a string.
/// 
/// Refer to [RequestResponse] for the domain layer equivilant.

sealed class Event<Data, ErrorInfo> {}

class InitialEvent<Data, ErrorInfo> extends Event<Data, ErrorInfo> {}

class LoadingEvent<Data, ErrorInfo> extends Event<Data, ErrorInfo> {}

class EventSuccess<Data, ErrorInfo> extends Event<Data, ErrorInfo> {
  final Data data;
  EventSuccess(this.data);
}

class EventError<Data, ErrorInfo> extends Event<Data, ErrorInfo> {
  final ErrorInfo error;
  EventError(this.error);
}
