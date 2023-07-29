import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper
{
  static SharedPreferences ? x;

  static Future<SharedPreferences?> init()async{
    x=await SharedPreferences.getInstance();
    return x;
  }

  static Future<bool> saveData({
  String ? key,
    dynamic  value,
})async
  {
   if(value is String)
     {
      return  await x!.setString(key!, value);
     }
   else if(value is int)
     {
       return  await x!.setInt(key!, value);
     }
   else if(value is bool)
   {
     return  await x!.setBool(key!, value);
   }
     return await x!.setDouble(key!, value);
  }

  static dynamic getData({
  String ? key,
})
  {
     return x!.get(key!);
  }
  static Future<bool> removeData({
  String ? key,
})
  {
    return x!.remove(key!);
  }
}