class CatModel{
  bool ? status;
  CatDataModel ? data;
  CatModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    data=CatDataModel.fromJson(json['data']);
  }
}


class CatDataModel{
  int ? currentPage;
  List<DataModel>  data=[];
  CatDataModel.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    json['data'].forEach((e){
      data.add(DataModel.fromJson(e));
    });
  }
}
class DataModel{
  int ?id;
  String ?name;
  String ?image;
  DataModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}