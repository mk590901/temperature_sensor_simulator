import '../events/event.dart';

class Start<T> extends Event<T> {
  T? _data;
  Start();
  @override
  T? getData() {
    return _data;
  }

  @override
  Start<T> setData([T? data]) {
    _data = data;
    return this;
  }


}
