import 'package:error_proof_demo/login/LoginState.dart';
import 'package:error_proof_demo/login/login_screen.dart';
import 'package:error_proof_demo/todolist/TodoActions.dart';
import 'package:error_proof_demo/todolist/TodoListInteractor.dart';
import 'package:error_proof_demo/todolist/TodoListScreen.dart';
import 'package:error_proof_demo/todolist/TodoListState.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'login/login_actions.dart';

import 'login/login_interactor.dart';
import 'login/login_repository.dart';
import 'todolist/TodoListRepository.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation());
  getIt.registerLazySingleton<LoginInteractor>(() {
    return LoginInteractor(Map.fromEntries([
      MapEntry(LoginUserAction, LoginUserActionReducer()),
      MapEntry(RegisterUserAction, RegisterUserActionReducer()),
    ]),
        LoginState()
    );
  });

  getIt.registerLazySingleton<TodoListRepository>(() => TodoListRepositoryImplementation());
  getIt.registerLazySingleton<TodoListInteractor>(() => TodoListInteractor(Map.fromEntries([
    MapEntry(ToggleAddingStateTodoAction, ToggleAddingStateReducer()),
    MapEntry(AddTodoAction, AddTodoReducer(getIt<TodoListRepository>())),
    MapEntry(CheckTodoAction, CheckTodoReducer(getIt<TodoListRepository>())),
    MapEntry(RemoveTodoAction, RemoveTodoReducer(getIt<TodoListRepository>())),

  ]), TodoListState(), getIt<TodoListRepository>()));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    initialRoute: '/list',
    routes: {
      '/': (context) => LoginScreen(),
      '/list': (context) => TodoListScreen(),
    }
    );
  }
}

