import 'package:flutter/material.dart';

class ErrorWrapper {
  final Color   _valueColor;
  final Color   _textColor;
  final String  _description;

  ErrorWrapper (this._valueColor, this._textColor, this._description);

  Color   valueColor() {
    return _valueColor;
  }

  Color   textColor() {
    return _textColor;
  }

  String  description() {
    return _description;
  }


}