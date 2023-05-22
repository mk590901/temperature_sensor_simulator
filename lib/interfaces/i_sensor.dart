import 'i_controller.dart';

abstract class ISensor {
  void    setController (IController? controller);
  void    start         ();
  void    stop          ();
  void    measure       ();
  void    cancel        ();
  bool    busy          ();
  String  ident         ();
}