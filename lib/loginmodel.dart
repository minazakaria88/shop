class ShopLoginModel{
 late  bool  status;
  String ? message;
  UserModel ?data;
  ShopLoginModel.fill( Map<String ,dynamic>  json)
  {
    status=json['status'];
    message=json['message'];
    data=json['data']!=null ? UserModel.fill(json: json['data']) :null;
  }
  ShopLoginModel()
  {

  }
}
class UserModel{
  int ? id;
  String ?name;
  String ?email;
  String ? phone;
  String ? image;
  int ?points;
  int ?credit;
  String ? token;
  UserModel.fill({required Map<String ,dynamic>  json})
  {
    id=json['id'];
    name=json['name'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
    email=json['email'];
  }
}