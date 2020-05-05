import 'state_management/Navigational.dart';
import 'state_management/State.dart';


class LoginState extends State{
  bool isLoading = false;
  String username;
  String password;
  Map<LoginError, String> errors;

  LoginState(): super();

  LoginState.create({this.isLoading = false, this.username, this.password, this.errors, bool isNavigational, NavigationMethod navigationMethod, String navigationPath}):
        super(isNavigational: isNavigational, navigationMethod: navigationMethod, navigationPath: navigationPath);


  LoginState copyWith({bool isLoading, String username, String password, Map<LoginError, String> errors, bool isNavigational, NavigationMethod navigationMethod, String navigationPath}) {
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
    if (errors != null) {
      newState.errors = errors;
    }
    if (isNavigational != null) {
      newState.isNavigational = isNavigational;
    }

    if (navigationMethod != null) {
      newState.navigationMethod = navigationMethod;
    }

    if (navigationPath != null) {
      newState.navigationPath = navigationPath;
    }

    return newState;
  }

}

enum LoginError {
  username, password, other
}