import 'package:flutter/material.dart';

import '../errors/errors.dart';

abstract class IUpdate<T> {
  void update(final T? data, final bool process, final MeasurementError error, final DateTime? dateTime);
  void setSink(final String? uuid);
  void addContext(BuildContext? context);
}
