import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/controller.dart';
import '../core/error_wrapper.dart';
import '../core/errors_helper.dart';
import '../errors/errors.dart';
import '../interfaces/i_sink.dart';

String extractValue(var data) {
  String result = 'XXX';
  if (data == null) {
    return Controller.controller()!.getLastValue();
  }
  if (data is ISink) {
    if (data.data() != null) {
      result = data.data();
    } else {
      return Controller.controller()!.getLastValue();
    }
  }
  return result;
}

bool extractProgress(var data) {
  bool result = false;
  if (data == null) {
    return result;
  }
  if (data is ISink) {
    if (data.data() != null) {
      result = data.progress() == null ? false : data.progress()!;
    } else {
      return result;
    }
  }
  return result;
}

Color extractButtonColor(var data) {
  Color result = Colors.white;
  if (data == null) {
    return result;
  }
  if (data is ISink) {
    if (data.data() != null) {
      result = data.progress() == null ? Colors.white : data.progress()! ? Colors.deepOrange : Colors.amber;
    } else {
      return result;
    }
  }
  return result;
}


Color extractValueColor(var data) {
  Color result = Colors.white12;
  if (data == null) {
    return Colors.white;
  }
  if (data is ISink) {
    if (data.error() != null) {
      ErrorType? errorType = data.error()?.errorType();
      ErrorWrapper? wrapper = ErrorsHelper.errorsHelper()?.wrapper(errorType!);
      if (wrapper != null) {
        result = wrapper.valueColor();
      }
    } else {
      return Colors.white;
    }
  }
  return result;
}

Color extractTextColor(var data) {
  Color result = Colors.white12;
  if (data == null) {
    return Colors.white;
  }
  if (data is ISink) {
    if (data.error() != null) {
      ErrorType? errorType = data.error()?.errorType();
      ErrorWrapper? wrapper = ErrorsHelper.errorsHelper()?.wrapper(errorType!);
      if (wrapper != null) {
        result = wrapper.textColor();
      }
    } else {
      return Colors.white;
    }
  }
  return result;
}

String extractDescription(var data) {
  String result = "";
  if (data == null) {
    return result;
  }
  if (data is ISink) {
    if (data.error() != null) {
      ErrorType? errorType = data.error()?.errorType();
      ErrorWrapper? wrapper = ErrorsHelper.errorsHelper()?.wrapper(errorType!);
      if (wrapper != null) {
        result = wrapper.description();
      }
    } else {
      return result;
    }
  }
  return result;
}

String extractDateTime(var data) {
  String result = "";
  if (data == null) {
    return result;
  }
  if (data is ISink) {
    if (data.data() != null) {
      result = composeDateTime(data.dateTime());
    } else {
      return result;
    }
  }
  return result;
}

String composeDateTime(DateTime? dateTime) {
  if (dateTime == null) {
    return "";
  }
  String result =
      "${string(dateTime.day,2)}.${string(dateTime.month,2)}.${dateTime.year}\n${string(dateTime.hour,2)}:${string(dateTime.minute,2)}:${string(dateTime.second,2)},${string(dateTime.millisecond,3)}";
  return result;
}

String string(int number, int digits) {
  return number.toString().padLeft(digits, '0');
}

ButtonStyle getButtonStyle() {
  return ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: const BorderSide(color: Colors.blueAccent)
          )
      )
  );
}

Future<dynamic> tryExit(BuildContext context) async {

  final buttonStyle = getButtonStyle();

  return (await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Are you sure?'),
      content: const Text('Do you want to exit an application'),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          style: buttonStyle,
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            //ApplicationHolder.holder()!.shutdown();
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            //exit(0);
          },
          style: buttonStyle,
          child: const Text('Yes'),
        ),
      ],
    ),
  )) ?? false;
}

bool onBack() {
  return true;
}
