import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/LoginModel.dart';
import 'package:shop/modules/login/loginScreen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class SettingScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        LoginModel? model = HomeCubit.get(context).loginModel;
        // print(model!.data!.name);
        nameController.text = model!.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return HomeCubit.get(context).loginModel != null ? Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if(state is LoadingUpdateUserState)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 20.0,
                ),
                DefaultFormFied(
                    type: TextInputType.text,
                    controller: nameController,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return "Name can not be null";
                      }
                      return null;
                    },
                    label: 'Name',
                    prefix: Icons.person
                ),
                SizedBox(
                  height: 20.0,
                ),
                DefaultFormFied(
                    type: TextInputType.emailAddress,
                    controller: emailController,
                    validate: (String? value){
                      if(value!.isEmpty)
                      {
                        return "Email can not be null";
                      }
                      return null;
                    },
                    label: 'Email',
                    prefix: Icons.email
                ),
                SizedBox(
                  height: 20.0,
                ),
                DefaultFormFied(
                  type: TextInputType.number,
                  controller: phoneController,
                  validate: (String? value){
                    if(value!.isEmpty)
                    {
                      return "Phone can not be null";
                    }
                    return null;
                  },
                  label: 'Phone',
                  prefix: Icons.phone,
                ),
                SizedBox(
                  height: 20.0,
                ),
                DefaultButton(
                    function: (){
                      if(formKey.currentState!.validate())
                      {
                        HomeCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    text: 'UPDATE'
                ),
                SizedBox(
                  height: 20.0,
                ),
                DefaultButton(
                    function: (){
                      CacheHelper.removeDate(key: 'token').then((value) {
                        if(value){
                          navigateTo(context, LoginScreen());
                        }
                      });
                    },
                    text: 'Logout'
                ),
              ],
            ),
          ),
        ) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
