import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/reusable.dart';
import 'package:shop.png/shopcubit.dart';
import 'package:shop.png/shoplayout.dart';
import 'cachehelper.dart';
import 'dio.dart';
import 'home.dart';
import 'login.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
 if(CacheHelper.getData(key: 'onbording')!=null)
   {
      if(CacheHelper.getData(key: 'token')!=null)
        {
          widget=const ShopLayout();
          token=CacheHelper.getData(key: 'token');
          print(token);

        }
      else
        {
          widget=Login();
        }
   }
 else
   {
     widget=const Home();
   }
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget,
    ),
  );
}

