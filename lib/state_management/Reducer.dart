import 'State.dart';
import 'StateAction.dart';

abstract class Reducer<T extends Stream<State>, T1 extends StateAction> {
  T call(T1 action);
}

typedef void StreamListener(State _);