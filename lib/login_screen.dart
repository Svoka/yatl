import 'package:error_proof_demo/LoginState.dart';
import 'package:error_proof_demo/login_actions.dart';
import 'package:error_proof_demo/login_interactor.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final LoginInteractor _loginInteractor = GetIt.I<LoginInteractor>();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          title: Text("Demo app"),
        ),
        body:
        StreamBuilder<LoginState>(
            stream: _loginInteractor.state,
            builder: (context, snapshot) {

              switch (snapshot.data.runtimeType) {
                case InitialState:
                  return InitialStateWidget(
                    loginPressed: () {

                      _loginInteractor.dispatch(LoginUserAction(username: "1", password: ""));


                    },
                    networkErrorPressed: () {
//                      _loginBlock.action.add(
//                          LoginUserAction(username: "2", password: ""));
                    },
                  );
                case ErrorState:
                  ErrorState state = snapshot.data;
                  return ErrorStateWidget(errorText: state.error,);

                case LoadingState:
                  return Container();
              }

              return Container(); // default
            }),
      );
  }

  @override
  void dispose() {
    super.dispose();
    _loginInteractor.dispose();
  }
}

class InitialStateWidget extends StatelessWidget {

  final Function loginPressed;
  final Function networkErrorPressed;

  InitialStateWidget({@required this.loginPressed, @required this.networkErrorPressed});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Column(
        children: <Widget>[
          MaterialButton(
            onPressed: loginPressed,
            child: Text("Login"),
          ),
          MaterialButton(
            onPressed: networkErrorPressed,
            child: Text("Network error"),
          ),
        ],
      ),

    );
  }
}



class ErrorStateWidget extends StatelessWidget {
  final String errorText;

  ErrorStateWidget({@required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(errorText),
    );
  }
}
