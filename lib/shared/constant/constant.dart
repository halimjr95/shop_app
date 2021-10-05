import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


String? token = '';

SizedBox sizedBoxHeight = SizedBox(
  height: 20.0,
);

SizedBox sizedBoxWidth = SizedBox(
  width: 20.0,
);

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0.0,
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
  ),
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,

      fontSize: 35.0,
      fontWeight: FontWeight.bold,
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
);



// CacheHelper.removeDate(key: 'token').then((value){
// if(value)
// {
// navigateAndRemove(context, LoginScreen());
// }
// });