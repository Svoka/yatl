import 'package:yatl/login/LoginActions.dart';
import 'package:yatl/login/LoginInteractor.dart';
import 'package:yatl/login/LoginRepository.dart';
import 'package:yatl/login/LoginState.dart';
import 'package:yatl/model/LoginResponse.dart';
import 'package:test/test.dart';
import 'package:async/async.dart';

void main() {
  test('Test login reducer', () async {
    LoginUserActionReducer reducer = LoginUserActionReducer(LoginRepositoryTest());
    var loginStream = StreamQueue(reducer.call(LoginState.create(), LoginUserAction(username: "123", password: "1")));

    LoginState state = await loginStream.next;
    expect(state.isLoading, equals(true));

    state = await loginStream.next;
    expect(state.isLoading, equals(false));

    state = await loginStream.next;
    expect(state.isNavigational, equals(true));

  });
}

class LoginRepositoryTest extends LoginRepository {
  @override
  Future<LoginResponse> login({String username, String password}) async{
    return LoginResponse(isError: false);
  }
}