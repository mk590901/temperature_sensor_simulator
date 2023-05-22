import 'interfaces/i_thresholds.dart';

class BodyTemperatureThresholds implements IThresholds {

  final double  _lowCritical    = 33.0;
  final double  _lowWarning     = 34.8;
  final double  _highWarning    = 37.8;
  final double  _highCritical   = 40.0;
  final double  _outOfRangeLow  = 25.0;
  final double  _outOfRangeHigh = 47.0;

  @override
  double highCritical() {
    return _highCritical;
  }

  @override
  double highWarning() {
    return _highWarning;
  }

  @override
  double lowCritical() {
    return _lowCritical;
  }

  @override
  double lowWarning() {
    return _lowWarning;
  }

  @override
  double outOfRangeHigh() {
    return _outOfRangeHigh;
  }

  @override
  double outOfRangeLow() {
    return _outOfRangeLow;
  }

}