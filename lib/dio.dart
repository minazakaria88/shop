import 'package:dio/dio.dart';

class DioHelper
{
  static Dio ? dio;



  static void init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }


  static Future<Response> getData({
  String ?url,
    String ? token,
    Map<String,dynamic> ?query,
})async
  {
    dio!.options.headers={
      'lang':'en',
      'Content-Type':'application/json',
       'Authorization':token,
    };
   return dio!.get(
      url!,
      queryParameters: query,
    );
  }


  static Future<Response> postData({
    String ?url,
    Map<String,dynamic>  ? query,
    Map<String,dynamic>  ? data,
    String ? token,
}){
    dio!.options.headers={
      'lang':'en',
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return dio!.post(
      url!,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> putData({
    String ?url,
    Map<String,dynamic>  ? query,
    Map<String,dynamic>  ? data,
    String ? token,
  }){
    dio!.options.headers={
      'lang':'en',
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return dio!.put(
      url!,
      queryParameters: query,
      data: data,
    );
  }

}