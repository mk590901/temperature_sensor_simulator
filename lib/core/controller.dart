import 'dart:async';
import 'dart:math';
import 'package:collage_mb_multitypes/interfaces/i_gui_action.dart';

import 'listeners_container.dart';
import '../errors/errors.dart';
import '../alerts_wrapper.dart';
import '../interfaces/i_controller.dart';
import '../interfaces/i_sensor.dart';
import '../interfaces/i_update.dart';
import '../interfaces/i_alert_response.dart';

class Controller implements IController, IAlertResponse {

  static Controller? _instance;

  final int TIMER_PERIOD = 2; //2s
  final int TIMER_TIME = 30; //30s

  Timer? _timer;

  final random = Random();

  String _lastValue = "--.-";
  ErrorType _lastError = ErrorType.ok;
  late DateTime? _lastValueDateTime = null;
  late ISensor? _sensor;
  late IGUIAction? _action = null;

  final AlertsWrapper _alertWrapper = AlertsWrapper(1);
  final ListenersContiner _listeners = ListenersContiner();

  static void initInstance() {
    _instance ??= Controller();
  }

  static Controller? controller() {
    if (_instance == null) {
      throw Exception("--- Controller wasn't initialized ---");
    }
    return _instance;
  }

  void registerAction(IGUIAction? action) {
    _action = action;
  }

  void register(String key, IUpdate listener, Type type) {
    _listeners.register(key, listener);
    print("Controller.registerListener [$key] registered => $type:${_listeners.size()}");
  }

  void unregister(String key) {
    if (!_listeners.contains(key)) {
      print("GestureManager.registerListener [$key] failed");
      return;
    }
    _listeners.unregister(key);
    print("Controller.registerListener [$key] unregistered");
  }

  Future<void> delay(int duration) async {
    await Future.delayed(Duration(seconds: duration));
  }

  void startContinuosMeasurement() {
    _timer = Timer.periodic(Duration(seconds: TIMER_PERIOD), (timer) {
      // Code to be executed on each timer tick
      print('Timer tick ...');

      String uuid = firstUuid();
      start(uuid);

    });
  }

  void finalContinuosMeasurement() {
    if (_timer != null) {
      if (_timer!.isActive) {
        _timer!.cancel();
        _timer = null;
        print('Timer is canceled ...');
      }
    }
  }

  @override
  void start(String key) async {
    if (!_listeners.contains(key)) {
      print("GestureManager.start [$key] failed");
      return;
    }

    _listeners.listeners().forEach((key, updater) {
      updater?.update(getLastValue(), true, MeasurementError(ErrorType.ok), getLastTime());
    });

    if (_sensor != null) {
      bool? busy = _sensor?.busy();
      if (busy != null) {
        busy ? _sensor?.stop() :  _sensor?.start();
      }
    }
  }

  String getLastValue() {
    return _lastValue;
  }

  DateTime? getLastTime() {
    return _lastValueDateTime;
  }

  @override
  void setSensor(ISensor? sensor) {
    _sensor = sensor;
  }

  @override
  void onFailed(errorType) {
    print('Controller.onFailed->[$errorType]');
    _lastError = errorType;
    _lastValue = '??.?';
    _lastValueDateTime = DateTime.now();
    _listeners.listeners().forEach((key, updater) {
      updater?.update(_lastValue, false, MeasurementError(errorType), _lastValueDateTime);
     });

    // click on button ||>
    if (errorType == ErrorType.cancel) {
      _action?.done(''); //  Test, need action to stop timer
    }

  }

  @override
  void onSucceed(data) {
    print('Controller.onSucceded->[$data]');
    _lastError = ErrorType.ok;
    _lastValue = '$data';
    _lastValueDateTime = DateTime.now();
//  Alert
    _alertWrapper.process(string2double(_lastValue), this);
  }

  @override
  void response(final ErrorType errorType) {
    _lastError = errorType;
    print ('Alert response -> [$errorType]');
    _listeners.listeners().forEach((key, updater) {
      updater?.update(_lastValue, false, MeasurementError(errorType), _lastValueDateTime);
    });
  // Button
    //@_action?.done('');  //  Test, need action to stop timer
  }

  double string2double(final String doubleText) {
    double result = 0;
    try {
      result = double.parse(doubleText);
    } catch (e) {
      print("Error: $e");
    }
    return result;
  }

  @override
  ISensor? sensor() {
    return _sensor;
  }

  @override
  void stop() {
    _sensor?.stop();
  }

  @override
  bool? busy() {
    return _sensor?.busy();
  }

  String firstUuid() {
    return _listeners.firstKey();
  }

  ErrorType lastError() {
    return _lastError;
  }

}