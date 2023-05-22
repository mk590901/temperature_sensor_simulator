import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/controller.dart';
import '../interfaces/i_sink.dart';
import '../blocs/icon_refreshing_bloc.dart';
import '../interfaces/i_update.dart';
import '../states/icon_refreshing_state.dart';
import '../errors/errors.dart';
import '../utils/utils.dart';

class IconTile extends StatelessWidget {
  IconTile({
    Key? key,
    required this.icon,
    required this.width,
    required this.height,
  }) : super(key: key);

  IconTile add(IUpdate updater) {
    this.updater = updater;
    this.updater.setSink(uuid);

    Controller.controller()?.register(uuid, updater, runtimeType);

    return this;
  }

  final String uuid = const Uuid().v4().toString();
  final IconData icon;
  final int width;
  final int height;

  late IUpdate updater;
  final int _max = 16;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Listener(
        onPointerDown: (e) {
          updater.update(null, true, MeasurementError(ErrorType.ok), DateTime.now());

        },
        onPointerMove: (e) {
          //print('Move  [$id]');
        },
        onPointerUp: (e) {
          updater.update(null, false, MeasurementError(ErrorType.ok), DateTime.now());
        },
        onPointerCancel: (e) {
          //print('Cancel [$id]');
        },
        child: BlocBuilder<IconRefreshingBloc, IconRefreshingState>(
            builder: (context, state) {
            updater.addContext(context);

          return Center(

            child: Icon(
              icon,
              size: min<double>(width.toDouble(), height.toDouble()) * 4 / 5,
              color: getColor(state.data()),
            ),
          );
        }),
      ),
    );
  }

  Color? getColor(ISink? data) {
    if (data == null /*|| data.data() == 0*/) {
      print('getColor 1');
      return Colors.white;
    }
    else
    if (data.data() == 0)   {
      print('getColor 2');
      return extractValueColor(data);
      //return Colors.white;
    }
    else {
      print('getColor 3');
      return Colors.deepPurple[200]?.withOpacity((_max - data.data())/_max);
    }
  }
}
