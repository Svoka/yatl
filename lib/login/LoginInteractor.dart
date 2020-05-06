import 'dart:async';

import 'package:error_proof_demo/login/LoginState.dart';
import 'package:error_proof_demo/model/login_response.dart';
import 'package:error_proof_demo/login/LoginRepository.dart';
import 'package:error_proof_demo/state_management/Interactor.dart';
import 'package:error_proof_demo/state_management/Navigational.dart';
import 'package:error_proof_demo/state_management/Reducer.dart';
import 'package:error_proof_demo/login/LoginActions.dart';
import 'package:get_it/get_it.dart';




class LoginInteractor extends Interactor<LoginState, LoginAction, LoginReducer> {
  LoginInteractor(Map<Type, LoginReducer> reducers, LoginState initialState): super(reducers, initialState) {
    // here, you can modify default state, for example if you need to check DB or network First
  }
}


abstract class LoginReducer<T extends LoginAction> extends Reducer<LoginState, T> {}

class LoginUserActionReducer extends LoginReducer<LoginUserAction> {

  LoginRepository _repository;

  LoginUserActionReducer(LoginRepository repository) {
    this._repository = repository;
  }

  @override
  Stream<LoginState> call(LoginState prevState, LoginUserAction action) async* {

    LoginState nextState = prevState;

    Map<LoginError, String> errors = Map();

    if (action.username.isEmpty) {
      errors.addEntries([MapEntry(LoginError.username, "Поле должно быть заполнено")]);
    }
    if (action.password.isEmpty) {
      errors.addEntries([MapEntry(LoginError.password, "Поле должно быть заполнено")]);
    }

    if (errors.isEmpty) {
      nextState = nextState.copyWith(isLoading: true, username: action.username, password: action.password);
      yield nextState;

      LoginResponse response =  await _repository.login(username: action.username, password: action.password);

      nextState = nextState.copyWith(isLoading: false);
      yield nextState;

      if (!response.isError) {
        nextState = nextState.copyWith(isNavigational: true, navigationPath: "/list", navigationMethod: NavigationMethod.pushReplacementNamed);
        yield nextState;

      } else {
        nextState = nextState.copyWith(errors: Map.fromEntries([MapEntry(LoginError.other, "Ошибочка вышла :(")]));
        yield nextState;
      }
    } else {
      nextState = nextState.copyWith(errors: errors, username: action.username, password: action.password);
      yield nextState;
    }
  }
}


class RegisterUserActionReducer extends LoginReducer<RegisterUserAction> {
  @override
  Stream<LoginState> call(LoginState prevState, RegisterUserAction action) async* {}
}