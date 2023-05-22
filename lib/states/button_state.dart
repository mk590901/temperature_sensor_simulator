enum ButtonStates { stop, play }

int state_(ButtonStates state) {
  return state.index;
}

class ButtonState {
  final ButtonStates _state;
  var _data;

  ButtonState(this._state) {
    _data = null;
  }

  ButtonStates state() {
    return _state;
  }

  void setData(var data) {
    _data = data;
  }

  data() {
    return _data;
  }
}
