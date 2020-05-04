import 'dart:async';

import 'package:error_proof_demo/LoginState.dart';
import 'package:error_proof_demo/model/login_response.dart';
import 'package:error_proof_demo/repositories/login_repository.dart';
import 'package:error_proof_demo/state_management/Reducer.dart';
import 'package:error_proof_demo/login_actions.dart';
import 'package:get_it/get_it.dart';

import 'state_management/Interactor.dart';


class LoginInteractor extends Interactor<LoginState, LoginAction, LoginReducer> {
  LoginInteractor(Map<Type, LoginReducer> reducers, {LoginState initialState}): super(reducers);
}


abstract class LoginReducer<T extends LoginAction> extends Reducer<Stream<LoginState>, T> {}

class LoginUserActionReducer extends LoginReducer<LoginUserAction> {

  LoginRepository _repository;

  LoginUserActionReducer() {
    _repository = GetIt.I<LoginRepository>();
  }

  @override
  Stream<LoginState> call(LoginUserAction action) async* {
    yield LoadingState();

    LoginResponse response =  await _repository.login(username: action.username, password: action.password);
    print(response.isError);

    yield ErrorState(error: "Some shit happen");
  }

}


class RegisterUserActionReducer extends LoginReducer<RegisterUserAction> {

  @override
  Stream<LoginState> call(RegisterUserAction action) async* {

  }
}