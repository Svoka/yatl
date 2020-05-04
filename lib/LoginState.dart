import 'package:meta/meta.dart';
import 'state_management/State.dart';


//@immutable
class LoginState extends State {
  bool isLoading = false;
  String username;
  String password;
  String error;


}


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