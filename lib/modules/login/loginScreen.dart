import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/home_layout.dart';
import 'package:shop/modules/login/cubit/cubit.dart';
import 'package:shop/modules/login/cubit/states.dart';
import 'package:shop/modules/register/register_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/constant/constant.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {


  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates> (
        listener: (context, state) {
          if(state is LoginSuccessState)
            {
              if (state.loginModel.status)
                {
                  CacheHelper.saveData(key: 'token', value: state.loginModel.data!.token).then((value){
                    token = state.loginModel.data!.token;
                    HomeCubit.get(context).getUserData();
                    navigateAndRemove(context, HomeLayout());
                  });
                  // showToast(message: state.loginModel.message, state: ToastSate.SUCCESS);
                }else {
                  showToast(message: state.loginModel.message!, state: ToastSate.WARNING);
              }


            }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          sizedBoxHeight,
                          Text(
                            'login now to get our offers',
                            style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.grey,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          DefaultFormFied(
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            controller: emailController,
                            prefix: Icons.email_outlined,
                            validate: (value) {
                              if(value!.isEmpty)
                              {
                                return 'Please enter your email';
                              }
                            },
                          ),
                          sizedBoxHeight,
                          DefaultFormFied(
                            type: TextInputType.visiblePassword,
                            label: 'Password',
                            controller: passwordController,
                            prefix: Icons.lock_open_outlined,
                            validate: (value) {
                              if(value!.isEmpty)
                              {
                                return 'Please enter your password';
                              }
                            },
                            isPassword: LoginCubit.get(context).isPassword,
                            suffix: Icons.remove_red_eye_outlined,
                            suffixPressed: (){
                              LoginCubit.get(context).changePasswordVisibility();
                            },
                          ),
                          sizedBoxHeight,
                          state is !LoginLoadingState ? DefaultButton(
                            text: 'login',
                            function: () {
                              if(formKey.currentState!.validate())
                                {
                                  LoginCubit.get(context).loginUser(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                            },
                          ) : Center(child: CircularProgressIndicator()),
                          sizedBoxHeight,
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                ),
                                defaultTextButton(
                                    text: 'register',
                                    function: () {
                                      navigateTo(
                                        context,
                                        RegisterScreen(),
                                      );
                                    }
                                ),
                              ]
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}
