import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/button_bloc.dart';
import 'core/controller.dart';
import 'core/errors_helper.dart';
import 'core/temperature_sensor.dart';
import 'pages/sensor_metro_page.dart';
import 'states/button_state.dart';
import 'states/text_refreshing_state.dart';
import 'blocs/text_refreshing_bloc.dart';
import 'states/icon_refreshing_state.dart';
import 'blocs/icon_refreshing_bloc.dart';

void main() {
  ErrorsHelper.initInstance();
  TemperatureSensor.initInstance();
  Controller.initInstance();
  TemperatureSensor.sensor()?.setController(Controller.controller());
  runApp(const TemperatureSensorApp());
}

class TemperatureSensorApp extends StatelessWidget {
  const TemperatureSensorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staggered Grid View Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
          canvasColor: Colors.grey,
      ),

      home: MultiBlocProvider(
        providers: [
          BlocProvider<ButtonBloc>(
            create: (_) => ButtonBloc(ButtonState(ButtonStates.stop)),
          ),
          BlocProvider<TextRefreshingBloc>(
            create: (_) => TextRefreshingBloc(TextRefreshingState(TextRefreshingStates.refreshing)),
          ),
          BlocProvider<IconRefreshingBloc>(
            create: (_) => IconRefreshingBloc(IconRefreshingState(IconRefreshingStates.refreshing)),
          ),

        ],
        child: const SensorMetroPage(),
      ),
    );
  }
}
