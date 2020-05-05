import 'package:error_proof_demo/LoginState.dart';
import 'package:error_proof_demo/login_screen.dart';
import 'package:error_proof_demo/todo_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'login_actions.dart';
import 'login_interactor.dart';
import 'repositories/login_repository.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerLazySingleton<LoginRepository>(() =>LoginRepositoryImplementation());
  getIt.registerLazySingleton<LoginInteractor>(() {
    return LoginInteractor(Map.fromEntries([
      MapEntry(LoginUserAction, LoginUserActionReducer()),
      MapEntry(RegisterUserAction, RegisterUserActionReducer()),
    ]),
        LoginState()
    );
  });

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
      '/list': (context) => TodoList(),
    }
    );
  }
}

