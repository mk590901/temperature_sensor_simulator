import '../errors/errors.dart';
import '../interfaces/i_sink.dart';

class Sink<T> implements ISink<T> {
  final String? _uuid;
  late bool? _progress = true;
  late MeasurementError? _error = null;
  late DateTime? _dateTime = null;

  T? _data = null;

  Sink(this._uuid, [this._data]);

  Sink.value(this._uuid,
      [this._data, this._progress, this._error, this._dateTime]);

  Sink.short(this._uuid,
      [this._data, this._error]);

  @override
  String? uuid() {
    return _uuid;
  }

  @override
  T? data() {
    return _data;
  }

  @override
  bool? progress() {
    return _progress;
  }

  @override
  DateTime? dateTime() {
    return _dateTime;
  }

  @override
  MeasurementError? error() {
    return _error;
  }
}
