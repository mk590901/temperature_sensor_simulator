import 'dart:math';
import 'package:collage_mb_multitypes/errors/errors.dart';

import './../events/break_events.dart';
import './../events/start_events.dart';
import './../states/task_state.dart';
import './../state_machines/task_state_machine.dart';
import './../interfaces/i_controller.dart';
import './../interfaces/i_sensor.dart';

class TemperatureSensor implements ISensor {

  static TemperatureSensor? _instance;

  final TaskStateMachine _task =
      TaskStateMachine(state_(TaskStates.idle)).setDelay(1);  //  5
  final random = Random();
  late IController? _controller;

  static void initInstance() {
    _instance ??= TemperatureSensor();
  }

  static TemperatureSensor? sensor() {
    if (_instance == null) {
      throw Exception("--- TemperatureSensor wasn't initialized ---");
    }
    return _instance;
  }

  @override
  void start() {
    _task.dispatch(Start());
  }

  @override
  void stop() {
    _task.dispatch(Break());
  }

  @override
  void setController(IController? controller) {
    _task.setController(controller);
    _controller = controller;
    _controller?.setSensor(this);
  }

  @override
  void measure() {
    int min = 0;
    int max = 100;
    int randomNumber = min + random.nextInt(max - min + 1);
    if (randomNumber < 20) {
      _controller?.onFailed(ErrorType.failed);
    } else {
      _controller?.onSucceed(getTemperature());
    }
  }

  String getTemperature() {
    String result ='';
    int min = 320;
    int max = 480;
    int randomNumber = min + random.nextInt(max - min + 1);
    result = (randomNumber/10).toString();
    return result;
  }

  @override
  void cancel() {
    _controller?.onFailed(ErrorType.cancel);
  }

  @override
  bool busy() {
    String? stateName = _task.getStateName(_task.state());
    if (stateName == null) {
      return false;
    }
    return (stateName == "idle") ? false : true;
  }

  @override
  String ident() {
    return 'Temperature sensor';
  }

}
