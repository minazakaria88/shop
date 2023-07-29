class HomeLayoutModel
{
 late  bool status;
 late HomeData data;
 HomeLayoutModel.fromJson(Map<String,dynamic> json)
 {
   status=json['status'];
   data=HomeData.fromJson(json['data']);
 }
}
class HomeData
{
  List<Banners>banners=[];
  List<Products>products=[];
  HomeData.fromJson(Map<String,dynamic> json)
  {
         json['banners'].forEach((e){
           banners.add(Banners.fromJson(e));
         });

         json['products'].forEach((e){
           products.add(Products.fromJson(e));
         });
  }
}
class Banners{
     int ? id;
     String ? image;
     Banners.fromJson(Map<String,dynamic> json)
     {
       id=json['id'];
       image=json['image'];
     }
}
class Products{
    int  ?id;
   dynamic price;
   dynamic old_price;
   dynamic discount;
   String ? image;
   String ? name;
   late bool  inFavorite;
   bool ? inCart;
   Products.fromJson(Map<String,dynamic> json)
   {
     id=json['id'];
     price=json['price'];
     old_price=json['old_price'];
     discount=json['discount'];
     image=json['image'];
     name=json['name'];
     inFavorite=json['in_favorites'];
     inCart=json['in_cart'];

   }

}