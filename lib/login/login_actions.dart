import '../state_management/StateAction.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginAction extends StateAction {}

class LoginUserAction extends LoginAction {
  final String username;
  final String password;

  LoginUserAction({@required this.username, @required this.password});
}


class RegisterUserAction extends LoginAction {}