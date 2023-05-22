import '../events/event.dart';

class Delay<T> extends Event<T> {
  T? _data;
  Delay();
  @override
  T? getData() {
    return _data;
  }

  @override
  Delay<T> setData([T? data]) {
    _data = data;
    return this;
  }


}
