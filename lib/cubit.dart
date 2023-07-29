
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/states.dart';


import 'dio.dart';
import 'loginmodel.dart';

class AppLoginCubit extends Cubit<AppLoginState>
{
  AppLoginCubit() : super(InitialState());

  static AppLoginCubit get(context)=>BlocProvider.of(context);
   TextEditingController controllerEmail=TextEditingController();
   TextEditingController controllerPassword=TextEditingController();
  bool x=true;
  void changePassword()
  {
    x=!x;
    emit(ChangePassword());
  }

   ShopLoginModel  ? loginModel;
  void loginPostData({
  String ?email,
    String ? password,
})async
  {
    emit(LoadingLogin());
    DioHelper.postData(
      url: 'login',
      data: {
        'email':email,
        'password':password,
      }
    ).then((value){
      loginModel=ShopLoginModel.fill( value.data);
      emit(LoginSuccess());
    });
  }

}