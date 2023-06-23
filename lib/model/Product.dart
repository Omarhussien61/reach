import 'Company.dart';

class Product {
  Product({
      this.id, 
      this.name, 
      this.effectiveMaterial, 
      this.image, 
      this.publicPrice, 
      this.company, 
      this.usage, 
      this.description, 
      this.warning, 
      this.like,});

  Product.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    effectiveMaterial = json['effective_material'];
    image = json['image'];
    publicPrice = json['public_price'];
    company = json['company'] != null ? Company.fromJson(json['company']) : null;
    usage = json['usage'];
    description = json['description'];
    warning = json['warning'];
    // if (json['like'] != null) {
    //   like = [];
    //   json['like'].forEach((v) {
    //     like.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  int id;
  String name;
  String effectiveMaterial;
  String image;
  double publicPrice;
  Company company;
  String usage;
  String description;
  String warning;
  List<dynamic> like;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['effective_material'] = effectiveMaterial;
    map['image'] = image;
    map['public_price'] = publicPrice;
    if (company != null) {
      map['company'] = company.toJson();
    }
    map['usage'] = usage;
    map['description'] = description;
    map['warning'] = warning;
    if (like != null) {
      map['like'] = like.map((v) => v.toJson()).toList();
    }
    return map;
  }

}