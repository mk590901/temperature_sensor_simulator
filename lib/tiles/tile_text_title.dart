import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/text_refreshing_bloc.dart';
import '../core/controller.dart';
import '../interfaces/i_update.dart';
import '../states/text_refreshing_state.dart';
import '../utils/utils.dart';

class TextTitleTile extends StatelessWidget {
  TextTitleTile({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  String? text;
  final String uuid = const Uuid().v4().toString();
  final int width;
  final int height;
  late IUpdate updater;

  TextTitleTile add(IUpdate updater) {
    this.updater = updater;
    this.updater.setSink(uuid);

    Controller.controller()?.register(uuid, updater, runtimeType);

    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Listener(
        onPointerDown: (e) {
//          print('Down  [$id]');
        },
        onPointerMove: (e) {
//          print('Move  [$id]');
        },
        onPointerUp: (e) {
//          print('Up    [$id]');
          //Controller.controller()?.start(uuid);
        },
        onPointerCancel: (e) {
//          print('Cancel [$id]');
        },
        child: BlocBuilder<TextRefreshingBloc, TextRefreshingState>(
            builder: (ctx, state) {
          //print('BlocBuilder>>>TextTile');
          updater.addContext(ctx);
          return Center(
            child: Stack(
              children: <Widget>[
                Center(
                  child: Text(
                    Controller.controller()!.sensor()!.ident(),
                    style: TextStyle(
                      fontSize: height.toDouble() / 4,
                      color: extractTextColor(state.data()), // set text color to blue
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
