import 'dart:async';
import 'basic_state_machine.dart';
import 'state.dart';
import 'trans.dart';
import '../interfaces/trans_methods.dart';
import '../states/task_state.dart';
import '../events/event.dart';
import '../events/start_events.dart';
import '../events/delay_events.dart';
import '../events/break_events.dart';
import '../interfaces/i_controller.dart';

class TaskStateMachine extends BasicStateMachine {

  Timer? timer;
  late int delay = 5;
  late IController? controller = null;

  TaskStateMachine(super.currentState);

  TaskStateMachine setDelay(final int delay) {
    this.delay = delay;
    return this;
  }

  TaskStateMachine setController(final IController? controller) {
    this.controller = controller;
    return this;
  }

  @override
  void create() {
    states_ [state_(TaskStates.idle)]         = State([ Trans(Start(),  state_(TaskStates.measurement),  OnStart(this))]);
    states_ [state_(TaskStates.measurement)]  = State([ Trans(Delay(),  state_(TaskStates.idle),  OnDelay(this)),
                                                        Trans(Break(),  state_(TaskStates.idle),  OnBreak(this)),
                                              ]);
  }

  @override
  String? getEventName(int event) {
    // TODO: implement getEventName
    throw UnimplementedError();
  }

  @override
  String? getStateName(int state) {
    return "${TaskStates.values[state].name}";
  }

  @override
  void publishEvent(Event event) {
    print ("publishEvent->${event}");
  }

  @override
  void publishState(int state) {
    // TODO: implement publishState
  }



}
