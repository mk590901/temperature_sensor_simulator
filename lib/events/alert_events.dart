import '../events/event.dart';

//  All alert events
class Outrange<T> extends Event<T> {
  T? _data;
  Outrange();
  Outrange.ext(this._data);
  @override
  T? getData() {
    return _data;
  }

  @override
  Outrange<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class Normal<T> extends Event<T> {
  T? _data;
  Normal();
  Normal.ext(this._data);
  @override
  T? getData() {
    return _data;
  }

  @override
  Normal<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class BelowCriticalLow<T> extends Event<T> {
  T? _data;
  BelowCriticalLow();
  BelowCriticalLow.ext(this._data);
  @override
  T? getData() {
    return _data;
  }

  @override
  BelowCriticalLow<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class AboveCriticalHigh<T> extends Event<T> {
  T? _data;
  AboveCriticalHigh();
  AboveCriticalHigh.ext(this._data);
  @override
  T? getData() {
    return _data;
  }

  @override
  AboveCriticalHigh<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class BelowWarningLow<T> extends Event<T> {
  T? _data;
  BelowWarningLow();
  BelowWarningLow.ext(this._data);
  @override
  T? getData() {
    return _data;
  }

  @override
  BelowWarningLow<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class AboveWarningHigh<T> extends Event<T> {
  T? _data;
  AboveWarningHigh();
  AboveWarningHigh.ext(this._data);
  @override
  T? getData() {
    return _data;
  }

  @override
  AboveWarningHigh<T> setData([T? data]) {
    _data = data;
    return this;
  }
}
