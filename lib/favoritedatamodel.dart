class FavDataModel{
  bool ? status;
  FavData ? data;
  FavDataModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=FavData.fromJson(json['data']);
  }
}
class FavData{
  int ? current;
  List<DataModel> data=[];
  FavData.fromJson(Map<String,dynamic> json){
    json['data'].forEach((e){
      data.add(DataModel.fromJson(e));
    });
  }
  
}
class DataModel{
  int ? id;
  Products ? products;
  DataModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    products=Products.fromJson(json['product']);
  }
}
class Products{
  int ?id;
  String ?name;
  String ? image;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  Products.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    price=json['price'];
    image=json['image'];
    oldPrice=json['old_price'];
    discount=json['discount'];
  }
}