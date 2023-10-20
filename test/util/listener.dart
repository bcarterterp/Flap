///Listenr to keep track of previous and next states that come from
///notifiers while using Fakes. Feel free to change any of the implementation,
///to fit your needs.
class Listener<Data> {
  //Records previous and next states
  final List<(Data? prev, Data next)> _data = [];

  void call(Data? previous, Data next) {
    _data.add((previous, next));
  }

  List<(Data?, Data)> get data => _data;
}
