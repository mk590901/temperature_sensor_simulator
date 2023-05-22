enum AlertStates { unknown, idle, normal, warning_low, warning_high, critical_low, critical_high, out_of_range }

int state_(AlertStates state) {
  return state.index;
}

class AlertState {
  final AlertStates _state;
  String? _data;

  AlertState(this._state) {
    _data = null;
  }

  AlertStates state() {
    return _state;
  }
  
  void setData(String? data) {
    _data = data;
  }

  String? data() {
    return _data;
  }
}
