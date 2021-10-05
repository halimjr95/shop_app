import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/home_layout.dart';
import 'package:shop/modules/login/loginScreen.dart';
import 'package:shop/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop/shared/bloc_observer.dart';
import 'package:shop/shared/constant/constant.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();

  Widget widget;
  
  bool? onboarding = CacheHelper.getData('onBoarding');
  // String? token = CacheHelper.getData('token');
  token = CacheHelper.getData('token');

  if(onboarding != null)
    {
      if(token != null) widget = HomeLayout();
      else widget = LoginScreen();
    }
  else {
      widget = OnBoardingScreen();
  }

  runApp(MyApp(startScreen: widget,));
}

class MyApp extends StatelessWidget {

  final Widget startScreen;

  MyApp({required this.startScreen});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCubit()..getFavoriteData()..getHomeData()..getCategoryData()..getUserData(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: startScreen,
        ));
  }
}


