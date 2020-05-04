import 'package:error_proof_demo/model/login_response.dart';

abstract class LoginRepository {
  Future<LoginResponse> login({String username, String password});
}

class LoginRepositoryImplementation extends LoginRepository {
  @override
  Future<LoginResponse> login({String username, String password}) {
    return Future.delayed(Duration(milliseconds: 500), (){
      return LoginResponse(isError: true);
    });
  }
}
