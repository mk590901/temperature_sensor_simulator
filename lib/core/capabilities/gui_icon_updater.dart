import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/icon_refreshing_bloc.dart';
import '../../errors/errors.dart';
import '../../events/refresh_events.dart';
import '../../interfaces/i_update.dart';
import '../../helpers/sink.dart';
import '../controller.dart';

class IconUpdater implements IUpdate {
  late String? uuid;
  late BuildContext? _context;

  final Duration delay = const Duration(milliseconds: 250);
  late Timer? _timer;
  late int _counter;
  late String _uuid = "";
  final int _max = 8;

  IconUpdater();

  @override
  void update(
      data, bool progress, MeasurementError? error, DateTime? dateTime) {
    if (progress) {
      start(uuid!);
    } else {
      stop(uuid!);
    }
  }

  @override
  void addContext(BuildContext? context) {
    _context = context;
  }

  @override
  void setSink(String? uuid) {
    this.uuid = uuid;
  }

  void start(final String uuid) {
    if (_uuid.isNotEmpty) {
      return;
    }
    _uuid = uuid;

    _timer = Timer.periodic(delay, (t) {
      _callbackFunction(t, _context);
    });
    _counter = 1;
    _context
        ?.read<IconRefreshingBloc>()
        .add(Refresh().setData(Sink(uuid, _counter)));
  }

  void _callbackFunction(Timer t, final BuildContext? context) {
    _counter++;
    if (_counter == _max) {
      _counter = 1;
    }
    context
        ?.read<IconRefreshingBloc>()
        .add(Refresh().setData(Sink(uuid, _counter)));
  }

  void stop(final String uuid) {
    if (uuid != _uuid) {
      return;
    }

    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
    _timer = null;

    ErrorType? error = Controller.controller()?.lastError();
    //_context?.read<IconRefreshingBloc>().add(Refresh().setData(Sink(uuid, 0)));
    _context
        ?.read<IconRefreshingBloc>()
        .add(Refresh().setData(Sink.short(uuid, 0, MeasurementError(error!))));
    _uuid = "";
  }
}
