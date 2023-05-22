import 'package:collage_mb_multitypes/core/controller.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../interfaces/i_gui_action.dart';
import '../blocs/button_bloc.dart';
import '../events/button_events.dart';
import '../states/button_state.dart';
import '../common.dart';
import '../custom_grid_tile.dart';
import '../core/capabilities/gui_icon_updater.dart';
import '../tiles/tile_icon.dart';
import '../tiles/tile_text_error.dart';
import '../tiles/tile_text_title.dart';
import '../tiles/tile_text_value_ext.dart';
import '../core/capabilities/gui_text_updater.dart';
import '../tiles/tile_text_value.dart';
import '../src/widgets/staggered_grid.dart';
import '../src/widgets/staggered_grid_tile.dart';
import '../utils/utils.dart';

class Action implements IGUIAction {
  final BuildContext context;

  Action(this.context);

  @override
  void done(String? text) {
    context.read<ButtonBloc>().add(Click());
  }
}

class SensorMetroPage extends StatelessWidget {
  const SensorMetroPage({
    Key? key,
  }) : super(key: key);

  static final tiles = [
    CustomGridTile(4, 1, TextTitleTile(width: 4 * 100, height: 1*100).add(TextUpdater())),
    CustomGridTile(2, 2, IconTile(icon: Icons.thermostat_sharp, width: 2 * 100, height: 2 * 100).add(IconUpdater())),
    CustomGridTile(2, 1, TextValueTile(width: 2 * 100, height: 1 * 100).add(TextUpdater())),
    CustomGridTile(2, 2, TextValueExtTile(width: 2 * 100, height: 2 * 100).add(TextUpdater())),
    CustomGridTile(2, 1, TextValueExtTile(width: 2 * 100, height: 1 * 100,).add(TextUpdater())),
    CustomGridTile(4, 1, TextErrorTile(width: 4 * 100,height: 1 * 100,).add(TextUpdater())),
  ];

  void refresh(BuildContext context) {
    Action action = Action(context);
    Controller.controller()?.registerAction(action);
    action.done('');
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> _onBackPressed() async {
      print('======= MainHomePage._onBackPressed =======');
      bool rc = onBack();
      if (!rc) {
        return rc;
      } else {
        return await tryExit(context);
      }
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: AppScaffold(
        title: 'SENSOR BLoC',
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            refresh(context);
          },
          tooltip: 'SENSOR BLoC page',
          child: BlocBuilder<ButtonBloc, ButtonState>(builder: (context, state) {
            return Icon(
                state.state().name == 'stop'
                    ? Icons.play_arrow_sharp
                    : Icons.pause_sharp,
                size: 40,
                color: Colors.white);
          }),
        ),
        child: SingleChildScrollView(
          child: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            children: [
              ...tiles.mapIndexed((index, tile) {
                return StaggeredGridTile.count(
                  crossAxisCellCount: tile.crossAxisCount,
                  mainAxisCellCount: tile.mainAxisCount,
                  child: tile.widget(),
                );
              }),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
