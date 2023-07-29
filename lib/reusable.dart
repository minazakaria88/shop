import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
String token='';
Widget newFormField({
  IconData ? iconData,
  IconData ? iconData2,
   Function   ? Function()? buttonFunction,
  TextEditingController ?controller,
   Function  ? function(String )?,
  bool  ob=false,
  String ? label,
})=>Padding(
  padding: const EdgeInsets.all(8.0),
  child:   TextFormField(
    onFieldSubmitted: function,
    validator: (value)
    {
      if(value!.isEmpty)
        {
          return 'required';
        }
    },
    controller: controller,
    cursorColor: Colors.deepOrange,
    obscureText: ob,
    decoration:   InputDecoration(
      label: Text(label!,
      style: const TextStyle(
        color: Colors.black,
      ),
      ),
        prefixIcon: Icon(
          iconData!,
          color: Colors.black,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            iconData2,
            color: ob? Colors.deepOrange:Colors.black,
          ),
          onPressed: buttonFunction,
        ),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepOrange,
              width: 2,
            )
        )
    ),

  ),
);


void goTo({context,widget})=>Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(
  builder: (context) =>  widget,), (route) => false);

enum ToastState{
  error,
  success,
  waring,
}
Future<bool?>? toast({
  String ? message,
  ToastState ? state,
})
{
  return Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: setColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
Color setColor(ToastState ? state)
{
  Color ? color;
  switch(state){
    case ToastState.error:
      color=Colors.red;
      break;
    case ToastState.waring:
      color=Colors.amber;
      break;
    case ToastState.success:
      color=Colors.green;
      break;
    case null:
      break;
  }
  return color!;
}