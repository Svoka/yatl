import 'dart:async';

import 'Reducer.dart';
import 'State.dart';
import 'StateAction.dart';

abstract class Interactor<S extends State, A extends StateAction, R extends Reducer> {

  StreamController<S> _stateController = StreamController();
  Stream get state => _stateController.stream;
  Sink get _stateSink => _stateController.sink;

  final Map<Type, R> reducers;

  StreamListener _stateListener;

  Interactor(this.reducers, S initialState) {
    if (initialState != null) {
      _stateSink.add(initialState);
    }
    _stateListener = (state) {_stateSink.add(state);};
  }

  void dispatch(S prevState, A action) {
    reducers[action.runtimeType]?.call(prevState, action)?.listen(_stateListener);
  }

  void dispose() {
    _stateController.close();
  }
}
typedef void StreamListener(State _);