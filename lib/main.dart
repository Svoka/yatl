import 'package:yatl/login/LoginState.dart';
import 'package:yatl/login/LoginScreen.dart';
import 'package:yatl/todolist/TodoActions.dart';
import 'package:yatl/todolist/TodoListInteractor.dart';
import 'package:yatl/todolist/TodoListScreen.dart';
import 'package:yatl/todolist/TodoListState.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'login/LoginActions.dart';

import 'login/LoginInteractor.dart';
import 'login/LoginRepository.dart';
import 'todolist/TodoListRepository.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerLazySingleton<LoginRepository>(() => LoginRepositoryImplementation());
  getIt.registerLazySingleton<LoginInteractor>(() {
    return LoginInteractor(Map.fromEntries([MapEntry(LoginUserAction, LoginUserActionReducer(getIt<LoginRepository>()))]),
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
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/list': (context) => TodoListScreen(),
        }
    );
  }
}

