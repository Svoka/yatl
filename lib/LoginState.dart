import 'package:meta/meta.dart';
import 'state_management/State.dart';


//@immutable
class LoginState extends State with NavigationState {
  bool isLoading = false;
  String username;
  String password;
  String error;

  LoginState(): super();

  LoginState.create({this.isLoading = false, this.username, this.password, this.error, bool isNavigational}): super(isNavigational: isNavigational);


  LoginState copyWith({bool isLoading, String username, String password, String error, bool isNavigational}) {
    LoginState newState =  LoginState();

    if (isLoading != null) {
      newState.isLoading = isLoading;
    }
    if (username != null) {
      newState.username = username;
    }
    if (password != null) {
      newState.password = password;
    }
    if (error != null) {
      newState.error = error;
    }
    if (isNavigational != null) {
      newState.isNavigational = isNavigational;
    }
    return newState;
  }


}


//class LoginStateWithNavigation extends LoginState with NavigationState {}

//class InitialState extends LoginState {
//  @override
//  String toString() => 'InitialState';
//}
//
//class LoadingState extends LoginState {
//  @override
//  String toString() => 'LoadingState';
//}
//
//class ErrorState extends LoginState {
//  final String error;
//
//  ErrorState({@required this.error});
//
//  @override
//  String toString() => 'ErrorState';
//}

class NavigationState {}