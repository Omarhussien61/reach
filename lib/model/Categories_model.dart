

import 'package:flutter_pos/model/product_model.dart';

class Categories_model {
  int statusCode;
  String message;
  List<Categories_item> data;
  int total;

  Categories_model({this.statusCode, this.message, this.data, this.total});

  Categories_model.fromJson(Map<String, dynamic> json) {
   // statusCode = json['status_code'];
    //message = json['message'];
    if (json['results'] != null) {
      data = new List<Categories_item>();
      json['results'].forEach((v) {
        data.add(new Categories_item.fromJson(v));
      });
    }
    total = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Categories_item {
  int id;
  String name;
  String nameEn;
  int allcategoryId;
  int level;
  int count_cats;
  String catName;
  List<Categories_item> categories;
  String photo;
  bool Check=false;
  String createdAt;

  Categories_item(
      {this.id,
        this.name,
        this.nameEn,
        this.allcategoryId,
        this.level,
        this.catName,
        this.categories,
        this.photo,
        this.createdAt});

  Categories_item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameEn = json['name_en'];
    count_cats = json['count_cats'];
    allcategoryId = json['allcategory_id'];
    level = json['level'];
    catName = json['catName'];
    if (json['categories'] != null) {
      categories = new List<Categories_item>();
      json['categories'].forEach((v) {
        categories.add(new Categories_item.fromJson(v));
      });
    }
    photo = json['image'] ;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_en'] = this.nameEn;
    data['allcategory_id'] = this.allcategoryId;
    data['level'] = this.level;
    data['catName'] = this.catName;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }

    data['photo'] = this.photo;
    data['created_at'] = this.createdAt;
    return data;
  }
}


