import 'interfaces/i_alert_response.dart';
import 'circle_buffer.dart';
import 'alert_holder.dart';

class AlertsWrapper {
  late CircularBuffer _circularBuffer;
  final AlertHolder _alertHolder = AlertHolder();

  AlertsWrapper(final int capacity) {
    _circularBuffer = CircularBuffer(capacity);
  }

  void process(final double value, IAlertResponse response) {
  //  Maybe outranges not need to processing
    _circularBuffer.write(value);
    if (_circularBuffer.full()) {
      _alertHolder.process(value, _circularBuffer.average(), response);
    } else {
      //print('Failed to process alert');
      _alertHolder.process(value, 36.6, response);
    }
  }
}
