import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/text_refreshing_bloc.dart';
import '../../errors/errors.dart';
import '../../events/refresh_events.dart';
import '../../interfaces/i_update.dart';
import '../../helpers/sink.dart';

class TextUpdater implements IUpdate {

  late String? uuid;
  late BuildContext? _context;

  TextUpdater();

  @override
  void update(data, bool progress, MeasurementError? error, DateTime? dateTime) {
    _context?.read<TextRefreshingBloc>().add(Refresh().setData(Sink.value(uuid, data, progress, error, dateTime)));
  }

  @override
  void addContext(BuildContext? context) {
    _context = context;
    //@print ("TextUpdater.addContext->[$_context]");
  }

  @override
  void setSink(String? uuid) {
    this.uuid = uuid;
  }

}