# sensor_bloc
The project is a flutter app that simulates temperature measurement. Perhaps in the future the virtual temperature sensor will be replaced by interaction with a real sensor.

## Introduction
The project is a development of the concept of metro style tiles. Tiles are primitive building blocks that combine to create a GUI, which in this case is a thermometer. The application uses 5 tiles: title, errors, icon, value and extended value. The first three of them are for rendering, the other two allow you to control the device through of touch: start and stop measurement,

## State machines
The application uses several state machines:

- **Refreshing state machine**. It's built into two classes, *TextRefreshingBloc* and *IconRefreshingBloc*, which allow update tiles.
- **Toggle button state machine**. It is an integral part of the *ButtonBloc* class and allows you to control the states of the **PLAY/PAUSE** button.
- The **Task state machine** is implemented in the *TaskStateMachine* class and encapsulated in the *TemperatureSensor* class, which simulates the temperature measurement process.
- **Alert state machine**. Allows you to classify measurements into several categories depending on the measured value.

For some variety, I'll give examples of the description of state machines:
## Refreshing state machine
```
@override
void create() {
states_ [state_(RefreshingStates.refreshing)]   = State([ Trans(Refresh(),  state_(RefreshingStates.refreshing),  OnNothing())]);
}
```
## Toggle button state machine
```
  @override
  void create() {
    states_ [state_(ButtonStates.stop)] = State([ Trans(Reset(),  state_(ButtonStates.stop), OnNothing()),
                                                  Trans(Click(),  state_(ButtonStates.play), OnPlay())
                                                ]);
    states_ [state_(ButtonStates.play)] = State([ Trans(Reset(),  state_(ButtonStates.stop), OnNothing()),
                                                  Trans(Click(),  state_(ButtonStates.stop), OnStop())
                                                ]);
  }
```
## Task state machine
```
  @override
  void create() {
    states_ [state_(TaskStates.idle)]         = State([ Trans(Start(),  state_(TaskStates.measurement),  OnStart(this))]);
    states_ [state_(TaskStates.measurement)]  = State([ Trans(Delay(),  state_(TaskStates.idle),  OnDelay(this)),
                                                        Trans(Break(),  state_(TaskStates.idle),  OnBreak(this)),
                                              ]);
  }
```
## Alert state machine
```
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

```
All these classes can be easily found in the project. They are transparently enough to understand principles of they work.

## Brief app guide
There are two ways to execute a measurement:
- Touch one of the three fields for rendering the measured value. Touching the screen starts the measurement. Measurement process goes on for a second. You can interrupt the measurement by touching the screen during the measurement. These are one-time measurements.
- It's possible also to perform continuous measurements. There is a **PLAY/PAUSE** button for this.

## Video

https://github.com/mk590901/temperature_sensor_simulator/assets/125393245/57a0d61a-9b2a-4a5a-96f7-ac4cff5b1572

