import 'errors/errors.dart';
import 'interfaces/i_alert_response.dart';

class AlertResponse implements IAlertResponse {
  @override
  void response(ErrorType errorType) {
    print ('response->$errorType');
  }

}