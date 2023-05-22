import '../events/event.dart';

class Break<T> extends Event<T> {
  T? _data;
  Break();
  @override
  T? getData() {
    return _data;
  }

  @override
  Break<T> setData([T? data]) {
    _data = data;
    return this;
  }


}
