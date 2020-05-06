import 'package:yatl/model/LoginResponse.dart';

abstract class LoginRepository {
  Future<LoginResponse> login({String username, String password});
}

class LoginRepositoryImplementation extends LoginRepository {
  @override
  Future<LoginResponse> login({String username, String password}) {
    return Future.delayed(Duration(milliseconds: 500), (){
      if (username == "123") {
        return LoginResponse(isError: true);
      } else {
        return LoginResponse(isError: false, token: "JWT Token_value");
      }

    });
  }
}
