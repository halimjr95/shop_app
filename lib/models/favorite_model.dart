class FavoriteModel {
  bool? status;
  String? message;
  late Data data;

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

}

class Data {
  List<FavoriteData> favoriteData = [];
  Data.fromJson(Map<String, dynamic> json) {

    json['data'].forEach((element){
      favoriteData.add(FavoriteData.fromJson(element));
    });
  }
}

class FavoriteData {
  int? id;
  Product? product;

  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}