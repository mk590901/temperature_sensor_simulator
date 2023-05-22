import '../interfaces/i_sink.dart';

enum TextRefreshingStates { refreshing }

int state_(TextRefreshingStates state) {
  return state.index;
}

class TextRefreshingState {
  final TextRefreshingStates _state;
  ISink? _data;

  TextRefreshingState(this._state) {
    _data = null;
  }

  TextRefreshingStates state() {
    return _state;
  }
  
  void setData(ISink? data) {
    _data = data;
  }

  ISink? data() {
    return _data;
  }
}
