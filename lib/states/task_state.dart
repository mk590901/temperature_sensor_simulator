enum TaskStates { idle, measurement }

int state_(TaskStates state) {
  return state.index;
}

class TaskState {
  final TaskStates _state;
  String? _data;

  TaskState(this._state) {
    _data = null;
  }

  TaskStates state() {
    return _state;
  }
  
  void setData(String? data) {
    _data = data;
  }

  String? data() {
    return _data;
  }
}
