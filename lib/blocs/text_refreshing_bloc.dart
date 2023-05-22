import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/refresh_events.dart';
import '../events/event.dart';
import '../state_machines/basic_state_machine.dart';
import '../state_machines/refreshing_state_machine.dart';
import '../states/text_refreshing_state.dart';

class TextRefreshingBloc extends Bloc<Event, TextRefreshingState> {
  BasicStateMachine? _stateMachine;

  TextRefreshingBloc(TextRefreshingState state) : super(state) {
    _stateMachine = RefreshingStateMachine(state_(TextRefreshingStates.refreshing));

    on<Refresh>((event, emit) {
      done(event, emit);
    });
  }

  void done(Event event, Emitter<TextRefreshingState> emit) {
    int newState = _stateMachine!.dispatch(event);
    if (newState >= 0) {
      TextRefreshingState nextState = TextRefreshingState(TextRefreshingStates.values[newState]);
      nextState.setData(event.getData());
      emit(nextState);
    }
  }
}
