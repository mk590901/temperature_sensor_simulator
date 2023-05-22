import 'package:collage_mb_multitypes/errors/errors.dart';

abstract class ISink<T> {
  String?           uuid();
  bool?             progress();
  DateTime?         dateTime();
  MeasurementError? error();
  T?                data();
}