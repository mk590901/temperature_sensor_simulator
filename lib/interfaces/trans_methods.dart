import 'dart:async';
import 'package:collage_mb_multitypes/utils/AlertBundle.dart';
import '../core/controller.dart';
import 'i_transition_method.dart';
import '../errors/errors.dart';
import '../events/delay_events.dart';
import '../state_machines/task_state_machine.dart';
import '../state_machines/alerts_state_machine.dart';

class OnPlay implements ITransitionMethod {
  @override
  void execute([var data]) {
    print ("@OnPlay $data -> ${data.runtimeType}");
    Controller? controller = Controller.controller();
    //String uuid = controller == null ? '' : controller.firstUuid();
    //Controller.controller()?.start(uuid);
    Controller.controller()?.startContinuosMeasurement();
  }
}

class OnStop implements ITransitionMethod {
  @override
  void execute([var data]) {
    print ("@OnStop $data -> ${data.runtimeType}");
    Controller? controller = Controller.controller();
    //String uuid = controller == null ? '' : controller.firstUuid();
    //Controller.controller()?.start(uuid);
    Controller.controller()?.finalContinuosMeasurement();
  }
}

class OnNothing implements ITransitionMethod {
  @override
  void execute([var hashMap]) {
    //@print ("@OnNothing $hashMap");
  }
}

class OnStart implements ITransitionMethod {
  final TaskStateMachine _stateMachine;

  OnStart(this._stateMachine);

  @override
  Future<void> execute([var hashMap]) async {
    print("@OnStart $hashMap");

    if (_stateMachine.timer != null) {
      print("OnStart - timer <> null");
      return;
    }

    _stateMachine.timer = Timer(Duration(seconds: _stateMachine.delay), () {
      print('Start ${_stateMachine.delay} seconds have elapsed');
      _stateMachine.controller?.sensor()?.measure();
      _stateMachine.dispatch(Delay());
      print(
          'current state->${_stateMachine.getStateName(_stateMachine.state())}');
    });
  }
}

class OnDelay implements ITransitionMethod {
  final TaskStateMachine _stateMachine;

  OnDelay(this._stateMachine);

  @override
  Future<void> execute([var hashMap]) async {
    print("@OnDelay $hashMap");
    if (_stateMachine.timer != null) {
      print("OnDelay - timer <> null");
      _stateMachine.timer?.cancel();
      _stateMachine.timer = null;
      print("OnDelay - timer was destroyed");
    } else {
      print("OnDelay - timer is null");
    }
  }
}

class OnBreak implements ITransitionMethod {
  final TaskStateMachine _stateMachine;

  OnBreak(this._stateMachine);

  @override
  Future<void> execute([var hashMap]) async {
    print("@OnBreak $hashMap");

    _stateMachine.controller?.sensor()?.cancel();

    if (_stateMachine.timer != null) {
      print("OnBreak - timer <> null");
      _stateMachine.timer?.cancel();
      _stateMachine.timer = null;
      print("OnBreak - timer was destroyed");
    } else {
      print("OnBreak - timer is null");
    }
  }
}

//  Alerts
class OutOfRangeAlert implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  OutOfRangeAlert(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @OutOfRangeAlert");
    data.response().response(ErrorType.out_range);
  }
}

class NormalAlert implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  NormalAlert(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @NormalAlert");
    data.response().response(ErrorType.ok);
  }
}

class BelowCriricalLowAlert implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  BelowCriricalLowAlert(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @BelowCriricalLowAlert");
    data.response().response(ErrorType.critical_low);
  }
}

class AboveCriricalHighAlert implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  AboveCriricalHighAlert(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[${value}] -- @AboveCriricalHighAlert");
    data.response().response(ErrorType.critical_high);
  }
}

class BelowWarningLowAlert implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  BelowWarningLowAlert(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @BelowWarningLowAlert");
    data.response().response(ErrorType.warning_low);
  }
}

class AboveWarningHighAlert implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  AboveWarningHighAlert(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @AboveWarningHighAlert");
    data.response().response(ErrorType.warning_high);
  }
}

class OutOfRangeAlertDummy implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  OutOfRangeAlertDummy(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @OutOfRangeAlertDummy");
    data.response().response(ErrorType.out_range);
  }
}

class NormalAlertDummy implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  NormalAlertDummy(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @NormalAlertDummy");
    data.response().response(ErrorType.ok);
  }
}

class BelowCriticalLowAlertDummy implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  BelowCriticalLowAlertDummy(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @BelowCriticalLowAlertDummy");
    data.response().response(ErrorType.critical_low);
  }
}

class AboveCriticalHighAlertDummy implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  AboveCriticalHighAlertDummy(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @AboveCriticalHighAlertDummy");
    data.response().response(ErrorType.critical_high);
  }
}

class BelowWarningLowDummyAlert implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  BelowWarningLowDummyAlert(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @BelowWarningLowDummyAlert");
    data.response().response(ErrorType.warning_low);
  }
}

class AboveWarningHighDummyAlert implements ITransitionMethod {
  final AlertStateMachine _stateMachine;
  AboveWarningHighDummyAlert(this._stateMachine);
  @override
  void execute([var data]) {
    String value = (data is AlertBundle) ? data.value() : "?";
    print ("[$value] -- @AboveWarningHighDummyAlert");
    data.response().response(ErrorType.warning_high);
  }
}


