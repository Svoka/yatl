import 'dart:async';

import 'package:error_proof_demo/LoginState.dart';
import 'package:error_proof_demo/model/login_response.dart';
import 'package:error_proof_demo/repositories/login_repository.dart';
import 'package:error_proof_demo/state_management/Reducer.dart';
import 'package:error_proof_demo/login_actions.dart';
import 'package:get_it/get_it.dart';



class LoginInteractor {
  StreamController<LoginState> _stateController = StreamController();
  Stream get state => _stateController.stream;
  Sink get _stateSink => _stateController.sink;

  Map<Type, Reducer> map = Map.fromEntries([
    MapEntry(LoginUserAction, LoginUserActionReducer()),
    MapEntry(RegisterUserAction, RegisterUserActionReducer()),
  ]);

  StreamListener _stateListener;

  LoginInteractor() {
    _stateController.sink.add(InitialState());
    _stateListener = (state) {_stateSink.add(state);};
  }

  void dispatch(LoginAction action) {
    map[action.runtimeType]?.call(action)?.listen(_stateListener);
  }

  void dispose() {
    _stateController.close();
  }
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