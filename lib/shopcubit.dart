import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/catmodel.dart';
import 'package:shop.png/dio.dart';
import 'package:shop.png/favoritedatamodel.dart';
import 'package:shop.png/homelayoutmodel.dart';
import 'package:shop.png/layoutcatagoir.dart';
import 'package:shop.png/layouthome.dart';
import 'package:shop.png/layoutsetting.dart';
import 'package:shop.png/reusable.dart';
import 'package:shop.png/shopstate.dart';

import 'favoritelayoutmodel.dart';
import 'layoutfavourite.dart';
import 'loginmodel.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutState>
{
  ShopLayoutCubit() : super(LayoutInitState());

  static ShopLayoutCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  void changeIndex(index)
  {
    currentIndex=index;
    emit(LayoutChangeState());
  }

  List<Widget > screens=[
    const HomeLayout(),
    const CatLayout(),
    const Favorite(),
     Setting(),
  ];
  HomeLayoutModel ? homeLayoutModel;
   Map<int,bool>   productFavorite={};
  void getHomeData()
  {
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeLayoutModel=HomeLayoutModel.fromJson(value.data);
      print(homeLayoutModel!.data.products[0].image);
      homeLayoutModel!.data.products.forEach((e) {
        productFavorite.addAll(
            {
              e.id!:e.inFavorite,
            }
        );
      });
      emit(LayoutSuccessState());
    });
  }
  CatModel ? model;
  void getCatData()
  {
    print('mina zakaria');
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
        model=CatModel.fromJson(value.data);
        print(model!.data!.data[0].name);
        print('==========================================lol');
      emit(LayoutCatSuccessState());
    }).catchError((e){
      print('${e.toString()} lolo');
    });
  }
  late FavoriteModel favoriteModel;
  void changeFavorite(int id)
  {
    bool?  x=productFavorite[id];
    productFavorite[id]=!x!;
    emit(LayoutSuccessState());
    DioHelper.postData(
      url: 'favorites',
      data: {
        'product_id':id,
      },
      token: token,
    ).then((value) {
      favoriteModel=FavoriteModel.fromJson(value.data);
      print(x);
      print(favoriteModel.message);
      if(favDataModel!.status==false)
        {
          print(favoriteModel.message);
          bool?  x=productFavorite[id];
          productFavorite[id]=!x!;
        }
      else{
        getFavData();
      }
      emit(LayoutFavState());

    }).catchError((e){
      print(e.toString());
    });

  }

  FavDataModel ? favDataModel;
  void getFavData()
  {
    emit(LayoutFavModel1State());
    DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value) {
      favDataModel=FavDataModel.fromJson(value.data);
    print('[[[[[[[[[[[[[[[[[[[[[[lol');
      emit(LayoutFavModelState());
    });
  }



   ShopLoginModel   settingModel=ShopLoginModel();
  void getSettingData()
  {
    emit(LayoutFavModel1State());
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      settingModel=ShopLoginModel.fill(value.data);
      print('[[[[[[[[[[[[[[[[[[[[[[lol');
      emit(LayoutFavModelState());
    });
  }


  void updateSettingData({
    String ?email,
    String ? name,
    String ? phone,
})
  {
    emit(UpdateLoadingState());
    DioHelper.putData(
      url: 'update-profile',
      token: token,
      data: {
        'email':email,
        'name':name,
        'phone':phone,
      }

    ).then((value) {
      settingModel=ShopLoginModel.fill(value.data);
      print(settingModel.message);
      print('[[[[[[[[[[[[[[[[[[[[[[lol');
      emit(UpdateSuccessState());
    });
  }


}
