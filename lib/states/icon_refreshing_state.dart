import '../interfaces/i_sink.dart';

enum IconRefreshingStates { refreshing }

int state_(IconRefreshingStates state) {
  return state.index;
}

class IconRefreshingState {
  final IconRefreshingStates _state;
  ISink? _data;
  //late int _data;

  IconRefreshingState(this._state) {
    _data = null;
  }

  IconRefreshingStates state() {
    return _state;
  }
  
  void setData(ISink? data) {
    _data = data;
  }

  ISink? data() {
    return _data;
  }
}
