import 'package:shop/models/LoginModel.dart';

abstract class LoginStates {}

class InitialLoginState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}

class LoginErrorsState extends LoginStates {
  final String error;
  LoginErrorsState(this.error);
}

class ChangePasswordVisibilityState extends LoginStates {}