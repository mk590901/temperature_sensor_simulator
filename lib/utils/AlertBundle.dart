import '../interfaces/i_alert_response.dart';

class AlertBundle {
  final IAlertResponse _response;
  final String _value;
  AlertBundle(this._response, this._value);
  IAlertResponse response() {
    return _response;
  }

  String value() {
    return _value;
  }
}