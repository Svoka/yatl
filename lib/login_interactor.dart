import 'dart:async';

import 'package:error_proof_demo/LoginState.dart';
import 'package:error_proof_demo/model/login_response.dart';
import 'package:error_proof_demo/repositories/login_repository.dart';
import 'package:error_proof_demo/state_management/Reducer.dart';
import 'package:error_proof_demo/state_management/StateAction.dart';
import 'package:error_proof_demo/login_actions.dart';
import 'package:get_it/get_it.dart';

class LoginInteractor {



  StreamController<LoginState> _stateController = StreamController();
  StreamController<LoginAction> _actionController = StreamController();

  Stream get state => _stateController.stream;
  Sink get _action => _actionController.sink;

  Sink get _stateSink => _stateController.sink;

  LoginInteractor() {
    _stateController.sink.add(InitialState());

    _actionController.stream.listen((action) async {
      switch (action.runtimeType) {
        case LoginUserAction:

          LoginReducer reducer = LoginUserActionReducer();
          reducer.call(action).listen((newAction) {
            _stateSink.add(newAction);
          });



          break;
        case RetryAction:
          _stateSink.add(LoadingState());
          break;
      }
    });
  }

  void dispatch(LoginAction action) {
    _action.add(action);
  }

  void dispose() {
    _stateController.close();
    _actionController.close();
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