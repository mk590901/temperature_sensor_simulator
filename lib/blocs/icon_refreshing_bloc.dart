import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/refresh_events.dart';
import '../events/event.dart';
import '../state_machines/basic_state_machine.dart';
import '../state_machines/refreshing_state_machine.dart';
import '../states/icon_refreshing_state.dart';

class IconRefreshingBloc extends Bloc<Event, IconRefreshingState> {
  BasicStateMachine? _stateMachine;

  IconRefreshingBloc(IconRefreshingState state) : super(state) {
    _stateMachine = RefreshingStateMachine(state_(IconRefreshingStates.refreshing));
    on<Refresh>((event, emit) {
      done(event, emit);
    });
  }

  void done(Event event, Emitter<IconRefreshingState> emit) {
    int newState = _stateMachine!.dispatch(event);
    if (newState >= 0) {
      IconRefreshingState nextState = IconRefreshingState(IconRefreshingStates.values[newState]);
      nextState.setData(event.getData());
      emit(nextState);
    }
  }
}
