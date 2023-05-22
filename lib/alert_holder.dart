import 'package:collage_mb_multitypes/utils/AlertBundle.dart';

import 'interfaces/i_alert_response.dart';
import 'body_temperature_thresholdss.dart';
import 'events/alert_events.dart';
import 'interfaces/i_thresholds.dart';
import 'state_machines/alerts_state_machine.dart';
import 'states/alert_state.dart';

class AlertHolder {
  final AlertStateMachine _stateMachine = AlertStateMachine(state_(AlertStates.idle));
  final IThresholds _thresholds = BodyTemperatureThresholds();

  void process (double originalValue, double value, IAlertResponse response) {
    String out = composeString(originalValue,value);
    AlertBundle bundle = AlertBundle(response,out);
    if (value < _thresholds.outOfRangeLow() || value > _thresholds.outOfRangeHigh()) {
      _stateMachine.dispatch(Outrange.ext(bundle));
    }
    else
    if (value < _thresholds.lowCritical() && value >= _thresholds.outOfRangeLow()) {
      _stateMachine.dispatch(BelowCriticalLow.ext(bundle));
    }
    else
    if (value < _thresholds.lowWarning() && value >= _thresholds.lowCritical()) {
      _stateMachine.dispatch(BelowWarningLow.ext(bundle));
    }
    else
    if (value > _thresholds.highWarning() && value <= _thresholds.highCritical()) {
      _stateMachine.dispatch(AboveWarningHigh.ext(bundle));
    }
    else
    if (value > _thresholds.highCritical() && value <=_thresholds.outOfRangeHigh()) {
      _stateMachine.dispatch(AboveCriticalHigh.ext(bundle));
    }
    else {
      _stateMachine.dispatch(Normal.ext(bundle));
    }
  }
}

String composeString(double v1, double v2) {
  String result = '${v1.toStringAsFixed(3)} -> ${v2.toStringAsFixed(3)}';
  return result;
}
