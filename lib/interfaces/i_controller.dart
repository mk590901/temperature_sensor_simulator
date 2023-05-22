import '../interfaces/i_sensor.dart';

abstract class IController {
  void  onFailed   (var error);
  void  onSucceed  (var data);
  void  setSensor  (ISensor? sensor);
  void  start      (String key);
  void  stop       ();
  bool? busy       ();
  ISensor?  sensor ();
}