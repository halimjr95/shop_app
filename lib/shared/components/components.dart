import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateAndRemove(context, newRoute) =>
    Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (contex) => newRoute
    ),
    (route) => false,
 );

void navigateTo(context, newRoute) =>
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (contex) => newRoute
      ),
    );



Widget defaultTextButton({
  required VoidCallback function,
  required String text
}) => TextButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
    ),
  );



Widget DefaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  required VoidCallback function,
  required String text,
}) => Container(
  width: width,
  color: color,
  child: MaterialButton(
    onPressed: function,
    child: Text(
      '${text}'.toUpperCase(),
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);



Widget DefaultFormFied({
  required TextInputType type,
  required TextEditingController controller,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isPassword = false,
  ValueChanged<String>? onSubmit,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChange
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  validator: validate,
  onFieldSubmitted: onSubmit,
  onTap: onTap,
  onChanged: onChange,
  decoration: InputDecoration(
    suffixIcon: IconButton(
      icon: Icon(suffix),
      onPressed: suffixPressed,
    ),
    // suffixIcon: Icon(suffix),
    prefixIcon: Icon(prefix),
    labelText: label,
    border: OutlineInputBorder(),
  ),
);



Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
      start: 25.0,
      end: 25.0
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color:  Colors.grey[300],
  ),
);


void showToast({
  required String message,
  required ToastSate state
})
{
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseColorToast(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}


enum ToastSate {SUCCESS, ERROR, WARNING}

Color chooseColorToast(ToastSate state)
{

  Color color;

  switch(state)
  {
    case ToastSate.SUCCESS:
      color = Colors.green;
      break;
    case ToastSate.ERROR:
      color = Colors.red;
      break;
    case ToastSate.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}