import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/LoginModel.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(InitialLoginState());


  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }


  void loginUser({required String email, required String password})
  {
    emit(LoginLoadingState());
    DioHelper.postData(
      data: {
        "email": email,
        "password": password,
      },
      url: LOGIN
    ).then((value){
      loginModel = LoginModel.fromJson(value.data);
      // print(loginModel.message);
      // print(loginModel.data!.token);
      emit(LoginSuccessState(loginModel));
    }).catchError((error) {
      emit(LoginErrorsState(error.toString()));
    });
  }



}