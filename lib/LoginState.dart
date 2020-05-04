import 'package:meta/meta.dart';
import 'state_management/State.dart';


@immutable
abstract class LoginState extends State {}


class InitialState extends LoginState {
  @override
  String toString() => 'InitialState';
}

class LoadingState extends LoginState {
  @override
  String toString() => 'LoadingState';
}

class ErrorState extends LoginState {
  final String error;

  ErrorState({@required this.error});

  @override
  String toString() => 'ErrorState';
}