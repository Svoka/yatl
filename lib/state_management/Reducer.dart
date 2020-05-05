import 'State.dart';
import 'StateAction.dart';

abstract class Reducer<S extends State, A extends StateAction> {
  Stream<S> call(S prevState, A action) async* {}
}
