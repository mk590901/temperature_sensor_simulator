import '../events/alert_events.dart';
import '../events/event.dart';
import '../interfaces/trans_methods.dart';
import '../states/alert_state.dart';
import 'basic_state_machine.dart';
import 'state.dart';
import 'trans.dart';

class AlertStateMachine extends BasicStateMachine {

  AlertStateMachine(super.currentState);
  
  @override
  void create() {

    states_ [state_(AlertStates.idle)]         = State([Trans(Outrange(),         state_(AlertStates.out_of_range), OutOfRangeAlert(this)),
                                                        Trans(Normal(),           state_(AlertStates.normal),       NormalAlert(this)),
                                                        Trans(BelowCriticalLow(), state_(AlertStates.critical_low), BelowCriricalLowAlert(this)),
                                                        Trans(AboveCriticalHigh(),state_(AlertStates.critical_high),AboveCriricalHighAlert(this)),
                                                        Trans(BelowWarningLow(),  state_(AlertStates.warning_low),  BelowWarningLowAlert(this)),
                                                        Trans(AboveWarningHigh(), state_(AlertStates.warning_high), AboveWarningHighAlert(this)),
                                                  ]);

    states_ [state_(AlertStates.out_of_range)] = State([Trans(Outrange(),         state_(AlertStates.out_of_range), OutOfRangeAlertDummy(this)),
                                                        Trans(Normal(),           state_(AlertStates.normal),       NormalAlert(this)),
                                                        Trans(BelowCriticalLow(), state_(AlertStates.critical_low), BelowCriricalLowAlert(this)),
                                                        Trans(AboveCriticalHigh(),state_(AlertStates.critical_high),AboveCriricalHighAlert(this)),
                                                        Trans(BelowWarningLow(),  state_(AlertStates.warning_low),  BelowWarningLowAlert(this)),
                                                        Trans(AboveWarningHigh(), state_(AlertStates.warning_high), AboveWarningHighAlert(this)),
                                                  ]);

    states_ [state_(AlertStates.normal)] =       State([Trans(Outrange(),         state_(AlertStates.out_of_range), OutOfRangeAlert(this)),
                                                        Trans(Normal(),           state_(AlertStates.normal),       NormalAlertDummy(this)),
                                                        Trans(BelowCriticalLow(), state_(AlertStates.critical_low), BelowCriricalLowAlert(this)),
                                                        Trans(AboveCriticalHigh(),state_(AlertStates.critical_high),AboveCriricalHighAlert(this)),
                                                        Trans(BelowWarningLow(),  state_(AlertStates.warning_low),  BelowWarningLowAlert(this)),
                                                        Trans(AboveWarningHigh(), state_(AlertStates.warning_high), AboveWarningHighAlert(this)),
                                                  ]);

    states_ [state_(AlertStates.critical_low)] = State([Trans(Outrange(),         state_(AlertStates.out_of_range), OutOfRangeAlert(this)),
                                                        Trans(Normal(),           state_(AlertStates.normal),       NormalAlert(this)),
                                                        Trans(BelowCriticalLow(), state_(AlertStates.critical_low), BelowCriticalLowAlertDummy(this)),
                                                        Trans(AboveCriticalHigh(),state_(AlertStates.critical_high),AboveCriricalHighAlert(this)),
                                                        Trans(BelowWarningLow(),  state_(AlertStates.warning_low),  BelowWarningLowAlert(this)),
                                                        Trans(AboveWarningHigh(), state_(AlertStates.warning_high), AboveWarningHighAlert(this)),
                                                  ]);

    states_ [state_(AlertStates.critical_high)] =State([Trans(Outrange(),         state_(AlertStates.out_of_range), OutOfRangeAlert(this)),
                                                        Trans(Normal(),           state_(AlertStates.normal),       NormalAlert(this)),
                                                        Trans(BelowCriticalLow(), state_(AlertStates.critical_low), BelowCriricalLowAlert(this)),
                                                        Trans(AboveCriticalHigh(),state_(AlertStates.critical_high),AboveCriticalHighAlertDummy(this)),
                                                        Trans(BelowWarningLow(),  state_(AlertStates.warning_low),  BelowWarningLowAlert(this)),
                                                        Trans(AboveWarningHigh(), state_(AlertStates.warning_high), AboveWarningHighAlert(this)),
                                                 ]);

    states_ [state_(AlertStates.warning_low)] =  State([Trans(Outrange(),         state_(AlertStates.out_of_range), OutOfRangeAlert(this)),
                                                        Trans(Normal(),           state_(AlertStates.normal),       NormalAlert(this)),
                                                        Trans(BelowCriticalLow(), state_(AlertStates.critical_low), BelowCriricalLowAlert(this)),
                                                        Trans(AboveCriticalHigh(),state_(AlertStates.critical_high),AboveCriricalHighAlert(this)),
                                                        Trans(BelowWarningLow(),  state_(AlertStates.warning_low),  BelowWarningLowDummyAlert(this)),
                                                        Trans(AboveWarningHigh(), state_(AlertStates.warning_high), AboveWarningHighAlert(this)),
                                                 ]);

    states_ [state_(AlertStates.warning_high)] = State([Trans(Outrange(),         state_(AlertStates.out_of_range), OutOfRangeAlert(this)),
                                                        Trans(Normal(),           state_(AlertStates.normal),       NormalAlert(this)),
                                                        Trans(BelowCriticalLow(), state_(AlertStates.critical_low), BelowCriricalLowAlert(this)),
                                                        Trans(AboveCriticalHigh(),state_(AlertStates.critical_high),AboveCriricalHighAlert(this)),
                                                        Trans(BelowWarningLow(),  state_(AlertStates.warning_low),  BelowWarningLowAlert(this)),
                                                        Trans(AboveWarningHigh(), state_(AlertStates.warning_high), AboveWarningHighDummyAlert(this)),
                                                 ]);

  }

  @override
  String? getEventName(int event) {
    // TODO: implement getEventName
    throw UnimplementedError();
  }

  @override
  String? getStateName(int state) {
    return "${AlertStates.values[state].name}";
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





/*
    public void create() {
        states.put(AlertState.ALERT_STATE_IDLE.value(), new StateEntity(
                new Transfer(OutOfRange_.value(), AlertState.ALERT_STATE_OUT_OF_RANGE.value(), outOfRangeAlert()),
                new Transfer(Normal_.value(), AlertState.ALERT_STATE_NORMAL.value(), normalAlert()),
                new Transfer(BelowCriticalLow_.value(), AlertState.ALERT_STATE_CRITICAL_LOW.value(), belowCriticalLowAlert()),
                new Transfer(AboveCriticalHigh_.value(), AlertState.ALERT_STATE_CRITICAL_HIGH.value(), aboveCriticalHighAlert()),
                new Transfer(BelowWarningLow_.value(), AlertState.ALERT_STATE_WARNING_LOW.value(), belowWarningLowAlert()),
                new Transfer(AboveWarningHigh_.value(), AlertState.ALERT_STATE_WARNING_HIGH.value(), aboveWarningHighAlert())
        ));
        states.put(AlertState.ALERT_STATE_OUT_OF_RANGE.value(), new StateEntity(
                new Transfer(OutOfRange_.value(), AlertState.ALERT_STATE_OUT_OF_RANGE.value(), outRangeAlertDummy()),
                new Transfer(Normal_.value(), AlertState.ALERT_STATE_NORMAL.value(), normalAlert()),
                new Transfer(BelowCriticalLow_.value(), AlertState.ALERT_STATE_CRITICAL_LOW.value(), belowCriticalLowAlert()),
                new Transfer(AboveCriticalHigh_.value(), AlertState.ALERT_STATE_CRITICAL_HIGH.value(), aboveCriticalHighAlert()),
                new Transfer(BelowWarningLow_.value(), AlertState.ALERT_STATE_WARNING_LOW.value(), belowWarningLowAlert()),
                new Transfer(AboveWarningHigh_.value(), AlertState.ALERT_STATE_WARNING_HIGH.value(), aboveWarningHighAlert())
        ));
        states.put(AlertState.ALERT_STATE_NORMAL.value(), new StateEntity(
                new Transfer(OutOfRange_.value(), AlertState.ALERT_STATE_OUT_OF_RANGE.value(), outOfRangeAlert()),
                new Transfer(Normal_.value(), AlertState.ALERT_STATE_NORMAL.value(), normalAlertDummy() ),
                new Transfer(BelowCriticalLow_.value(), AlertState.ALERT_STATE_CRITICAL_LOW.value(), belowCriticalLowAlert()),
                new Transfer(AboveCriticalHigh_.value(), AlertState.ALERT_STATE_CRITICAL_HIGH.value(), aboveCriticalHighAlert()),
                new Transfer(BelowWarningLow_.value(), AlertState.ALERT_STATE_WARNING_LOW.value(), belowWarningLowAlert()),
                new Transfer(AboveWarningHigh_.value(), AlertState.ALERT_STATE_WARNING_HIGH.value(), aboveWarningHighAlert())
        ));
        states.put(AlertState.ALERT_STATE_CRITICAL_LOW.value(), new StateEntity(
                new Transfer(OutOfRange_.value(), AlertState.ALERT_STATE_OUT_OF_RANGE.value(), outOfRangeAlert()),
                new Transfer(Normal_.value(), AlertState.ALERT_STATE_NORMAL.value(), normalAlert()),
                new Transfer(BelowCriticalLow_.value(), AlertState.ALERT_STATE_CRITICAL_LOW.value(), belowCriticalLowAlertDummy()),
                new Transfer(AboveCriticalHigh_.value(), AlertState.ALERT_STATE_CRITICAL_HIGH.value(), aboveCriticalHighAlert()),
                new Transfer(BelowWarningLow_.value(), AlertState.ALERT_STATE_WARNING_LOW.value(), belowWarningLowAlert()),
                new Transfer(AboveWarningHigh_.value(), AlertState.ALERT_STATE_WARNING_HIGH.value(), aboveWarningHighAlert())
        ));
        states.put(AlertState.ALERT_STATE_CRITICAL_HIGH.value(), new StateEntity(
                new Transfer(OutOfRange_.value(), AlertState.ALERT_STATE_OUT_OF_RANGE.value(), outOfRangeAlert()),
                new Transfer(Normal_.value(), AlertState.ALERT_STATE_NORMAL.value(), normalAlert()),
                new Transfer(BelowCriticalLow_.value(), AlertState.ALERT_STATE_CRITICAL_LOW.value(), belowCriticalLowAlert()),
                new Transfer(AboveCriticalHigh_.value(), AlertState.ALERT_STATE_CRITICAL_HIGH.value(), aboveCriticalHighAlertDummy()),
                new Transfer(BelowWarningLow_.value(), AlertState.ALERT_STATE_WARNING_LOW.value(), belowWarningLowAlert()),
                new Transfer(AboveWarningHigh_.value(), AlertState.ALERT_STATE_WARNING_HIGH.value(), aboveWarningHighAlert())
        ));
        states.put(AlertState.ALERT_STATE_WARNING_HIGH.value(), new StateEntity(
                new Transfer(OutOfRange_.value(), AlertState.ALERT_STATE_OUT_OF_RANGE.value(), outOfRangeAlert()),
                new Transfer(Normal_.value(), AlertState.ALERT_STATE_NORMAL.value(), normalAlert()),
                new Transfer(BelowCriticalLow_.value(), AlertState.ALERT_STATE_CRITICAL_LOW.value(), belowCriticalLowAlert()),
                new Transfer(AboveCriticalHigh_.value(), AlertState.ALERT_STATE_CRITICAL_HIGH.value(), aboveCriticalHighAlert()),
                new Transfer(BelowWarningLow_.value(), AlertState.ALERT_STATE_WARNING_LOW.value(), belowWarningLowAlert()),
                new Transfer(AboveWarningHigh_.value(), AlertState.ALERT_STATE_WARNING_HIGH.value(), aboveWarningHighAlertDummy())
        ));
        states.put(AlertState.ALERT_STATE_WARNING_LOW.value(), new StateEntity(
                new Transfer(OutOfRange_.value(), AlertState.ALERT_STATE_OUT_OF_RANGE.value(), outOfRangeAlert()),
                new Transfer(Normal_.value(), AlertState.ALERT_STATE_NORMAL.value(), normalAlert()),
                new Transfer(BelowCriticalLow_.value(), AlertState.ALERT_STATE_CRITICAL_LOW.value(), belowCriticalLowAlert()),
                new Transfer(AboveCriticalHigh_.value(), AlertState.ALERT_STATE_CRITICAL_HIGH.value(), aboveCriticalHighAlert()),
                new Transfer(BelowWarningLow_.value(), AlertState.ALERT_STATE_WARNING_LOW.value(), belowWarningLowAlertDummy()),
                new Transfer(AboveWarningHigh_.value(), AlertState.ALERT_STATE_WARNING_HIGH.value(), aboveWarningHighAlert())
        ));
    }

 */
