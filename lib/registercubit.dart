
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/registerstate.dart';
import 'package:shop.png/states.dart';


import 'dio.dart';
import 'loginmodel.dart';

class AppRegisterCubit extends Cubit<AppRegisterState>
{
  AppRegisterCubit() : super(InitialRegisterState());

  static AppRegisterCubit get(context)=>BlocProvider.of(context);
  bool x=true;
  void changePassword()
  {
    x=!x;
    emit(ChangeRegisterPassword());
  }

  late ShopLoginModel   loginModel;
  void registerPostData({
    String ?email,
    String ? password,
    String ? name,
    String ? phone,
  })async
  {
    emit(LoadingRegister());
    DioHelper.postData(
        url: 'register',
        data: {
          'email':email,
          'password':password,
          'name':name,
          'phone':phone,
        }
    ).then((value){
      loginModel=ShopLoginModel.fill( value.data);
      emit(RegisterSuccess());
    });
  }

}