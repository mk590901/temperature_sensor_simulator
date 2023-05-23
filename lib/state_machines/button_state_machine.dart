import 'state.dart';
import 'trans.dart';
import '../events/event.dart';
import '../events/button_events.dart';
import '../interfaces/trans_methods.dart';
import '../states/button_state.dart';
import 'basic_state_machine.dart';

class ButtonStateMachine extends BasicStateMachine {

  ButtonStateMachine(super.currentState);

  @override
  void create() {
    states_ [state_(ButtonStates.stop)] = State([ Trans(Reset(),  state_(ButtonStates.stop), OnNothing()),
                                                  Trans(Click(),  state_(ButtonStates.play), OnPlay())
                                                ]);

    states_ [state_(ButtonStates.play)] = State([ Trans(Reset(),  state_(ButtonStates.stop), OnNothing()),
                                                  Trans(Click(),  state_(ButtonStates.stop), OnStop())
                                                ]);
  }

  @override
  String? getEventName(int event) {
    // TODO: implement getEventName
    throw UnimplementedError();
  }

  @override
  String? getStateName(int state) {
    // TODO: implement getStateName
    throw UnimplementedError();
  }

  @override
  void publishEvent(Event event) {
    // TODO: implement publishEvent
  }

  @override
  void publishState(int state) {
    // TODO: implement publishState
  }

}