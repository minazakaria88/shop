import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop.png/dio.dart';
import 'package:shop.png/reusable.dart';
import 'package:shop.png/searchmodel.dart';
import 'package:shop.png/searchstate.dart';

class SearchCubit extends Cubit<SearchState>
{
  SearchCubit() : super(SearchFirstState());

  static  SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel ? searchModel;
  void search({
  String ? text,
})
  {
    emit(SearchLoadState());
    DioHelper.postData(
      url: 'products/search',
      token: token,
      data: {
        'text':text,
      }
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      print(searchModel!.data!.data[0].name);
      emit(SearchSuccessState());

    }).catchError((e){
      print(e.toString());
    });
  }

}