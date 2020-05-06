import 'package:error_proof_demo/login/LoginState.dart';
import 'package:error_proof_demo/login/LoginActions.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../state_management/ReduxStreamBuilder.dart';
import 'LoginInteractor.dart';


class LoginScreen extends StatelessWidget {

  final LoginInteractor _loginInteractor = GetIt.I<LoginInteractor>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo app"),
      ),
      body:
      ReduxStreamBuilder<LoginState>(
          stream: _loginInteractor.state,

          builder: (context, snapshot) {
            LoginState data = snapshot.data;

            if (data.errors!=null && data.errors[LoginError.other] != null && !data.handled) {
              data.handled = true;
              showError(context, data.errors[LoginError.other]);
            }

            return LoginPage(state: data, onLoginPressed: (username, password) {
              _loginInteractor.dispatch(data,
                  LoginUserAction(
                    username: username,
                    password: password,
                  ));
            });

          }),
    );
  }

  void showError(BuildContext bc, String title) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
          context: bc,
          builder: (BuildContext bc) {
            return Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.error,
                        color: Colors.amber,
                      ),
                      title: new Text(title),
                      onTap: () => {}),
                ],
              ),
            );
          });
    });
  }
}

typedef LoginCallback = void Function(String username, String password);
class LoginPage extends StatelessWidget {

  final LoginState state;
  final LoginCallback onLoginPressed;

  final _formKey = GlobalKey<FormState>();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({@required this.state, @required this.onLoginPressed});

  @override
  Widget build(BuildContext context) {

    _usernameController.text = state?.username;
    _passwordController.text = state?.password;

    return  Stack(
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
                          hintText: 'Имя пользователя:',
                          errorText: state.errors != null ? state.errors[LoginError.username] : null
                      ),
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
                        errorText: state.errors != null ? state.errors[LoginError.password] : null,
                      ),
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
                            FocusScope.of(context).requestFocus(FocusNode());
                            onLoginPressed(_usernameController.text, _passwordController.text);
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
          visible: state.isLoading,
          child: Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],

    );
  }
}




