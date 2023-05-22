# sensor_bloc
The project is a flutter app that simulates temperature measurement. Perhaps in the future the virtual temperature sensor will be replaced by interaction with a real sensor.

## Introduction
The project is a development of the concept of metro style tiles. Tiles are primitive building blocks that combine to create a GUI, which in this case is a thermometer. The application uses 5 tiles: title, errors, icon, value and extended value. The first three of them are for rendering, the other two allow you to control the device through of touch: start and stop measurement,

## State machines
The application uses several state machines:

- Refreshing state machine. It's built into two classes, TextRefreshingBloc and IconRefreshingBloc, which allow update tiles.
- Toggle button state machine. It is an integral part of the ButtonBloc class and allows you to control the states of the PLAY/PAUSE button.
- Alert state machine. Allows you to classify measurements into several categories depending on the measured value.

All these classes can be easily found in the project. They are transparently enough to understand principles of they work.

## Brief app guide
There are two ways to execute a measurement:
- Touch one of the three fields for rendering the measured value. Touching the screen starts the measurement. Measurement process goes on for a second. You can interrupt the measurement by touching the screen during the measurement. These are one-time measurements.
- It's possible also to perform continuous measurements. There is a PLAY/PAUSE button for this.

## Video

