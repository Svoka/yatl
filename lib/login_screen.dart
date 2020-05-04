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


  final _formKey = GlobalKey<FormState>();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

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

              LoginState data = snapshot.data;
              _usernameController.text = data?.username;


              if (data == null) {
                return Container();
              }

              if (data.isNavigational) {
                //do navigation stuff here
              }

              print(snapshot.data.username);

              return Stack(
                children: <Widget>[
                  SingleChildScrollView(

                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Icon(
                                Icons.all_inclusive,
                                color: Colors.amber,
                                size: 48.0,
                                semanticLabel: 'YATL Icon',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Логин:',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Это поле должно быть заполнено';
                                  } else {
                                    return null;
                                  }
                                },
                                focusNode: _usernameFocus,
                                onFieldSubmitted: (term) {
                                  _usernameFocus.unfocus();
                                  FocusScope.of(context).requestFocus(
                                      _passwordFocus);
                                },
                                controller: _usernameController,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Пароль:',
                                  errorText: 'Это тест поля с ошибкой',
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Это поле должно быть заполнено';
                                  } else {
                                    return null;
                                  }
                                },
                                focusNode: _passwordFocus,
                                onFieldSubmitted: (term) {
                                  _passwordFocus.unfocus();
                                },
                                controller: _passwordController,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Center(
                                child: SizedBox(
                                  height: 50,
                                  width: 150,
                                  child: RaisedButton(
                                    color: Colors.amber,
                                    shape:
                                    new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius
                                          .circular(30.0),
                                    ),
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(
                                          FocusNode());

//                                  if (_formKey.currentState.validate()) {

                                      _loginInteractor.dispatch(
                                          data, LoginUserAction(
                                        username: _usernameController.text,
                                        password: _passwordController.text,
                                      ));
//                                  }
                                    },
                                    child: Text(
                                      'ОТПРАВИТЬ',
                                      style: TextStyle(color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: data.isLoading,
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ],

              );
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
