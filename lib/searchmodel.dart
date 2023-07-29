class SearchModel{
  bool ? status;
  Fav1Data ? data;
  SearchModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    data=Fav1Data.fromJson(json['data']);
  }
}
class Fav1Data{
  int ? current;
  List<Products1> data=[];
  Fav1Data.fromJson(Map<String,dynamic> json){
    json['data'].forEach((e){
      data.add(Products1.fromJson(e));
    });
  }

}

class Products1{
  int ?id;
  String ?name;
  String ? image;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  Products1.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    price=json['price'];
    image=json['image'];
    oldPrice=json['old_price'];
    discount=json['discount'];
  }
}