import 'package:flutter_pos/model/Categories_model.dart';

import 'dart:convert';

class Product_model {
  int statusCode;
  String message;
  List<Product> data;

  Product_model({this.statusCode, this.message, this.data});

  Product_model.fromJson(Map<String, dynamic> json) {

    if (json['results'] != null) {
      data = new List<Product>();
      json['results'].forEach((v) { data.add(new Product.fromJson(v)); });
    }else
    if (json['data'] != null) {
      data = new List<Product>();
      json['data'].forEach((v) { data.add(new Product.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);


Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int id;
  String name;
  String effectiveMaterial;
  String image;
  String publicPrice;
  String salePrice;
  Company company;
  String usage;
  String percentage;
  String description;
  String warning;
  bool discount;
  List<dynamic> like;

  Product({
    this.id,
    this.name,
    this.effectiveMaterial,
    this.image,
    this.publicPrice,
    this.salePrice,
    this.company,
    this.usage,
    this.percentage,
    this.description,
    this.discount,
    this.warning,
    this.like,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    effectiveMaterial: json["effective_material"],
    image: json["image"],
    discount: json["discount"]??false,
    percentage: "${json["percentage"]}",
    publicPrice: "${json["public_price"]}",
    salePrice: "${json["instead_of"]}",
    company:json["company"]==null?Company(name: " "): Company.fromJson(json["company"]),
    usage: json["usage"],
    description: json["description"],
    warning: json["warning"],
    like: List<dynamic>.from(json["like"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "effective_material": effectiveMaterial,
    "image": image,
    "public_price": publicPrice,
    "company": company.toJson(),
    "usage": usage,
    "description": description,
    "warning": warning,
    "like": List<dynamic>.from(like.map((x) => x)),
  };
}

class Company {
  int id;
  String name;
  String image;

  Company({
    this.id,
    this.name,
    this.image,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}

class CarMadeName {
  int id;
  String carMade;
  String name_en;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  int categoryidId;
  String lang;

  CarMadeName({this.id, this.carMade, this.createdAt, this.updatedAt, this.deletedAt, this.categoryidId, this.lang});

  CarMadeName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carMade = json['car_made'];
    name_en = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    categoryidId = json['categoryid_id'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_made'] = this.carMade;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['categoryid_id'] = this.categoryidId;
    data['lang'] = this.lang;
    return data;
  }
}

class CarModelName {
  int id;
  String carmodel;
  String name_en;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  int carmadeId;
  String lang;
  Pivot pivot;

  CarModelName({this.id, this.carmodel, this.createdAt, this.updatedAt, this.deletedAt, this.carmadeId, this.lang, this.pivot});

  CarModelName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carmodel = json['carmodel'];
    name_en = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    carmadeId = json['carmade_id'];
    lang = json['lang'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['carmodel'] = this.carmodel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['carmade_id'] = this.carmadeId;
    data['lang'] = this.lang;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int productId;
  int carModelId;

  Pivot({this.productId, this.carModelId});

  Pivot.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    carModelId = json['car_model_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['car_model_id'] = this.carModelId;
    return data;
  }
}

class YearFrom {
  int id;
  String year;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  String lang;

  YearFrom({this.id, this.year, this.createdAt, this.updatedAt, this.deletedAt, this.lang});

  YearFrom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['year'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['year'] = this.year;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['lang'] = this.lang;
    return data;
  }
}


class PhotoProduct {
  int id;
  String modelType;
  int modelId;
  String uuid;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
  int size;
  List<Null> manipulations;
  CustomProperties customProperties;
  List<Null> responsiveImages;
  int orderColumn;
  String createdAt;
  String updatedAt;
  String image;
  String url;
  String fullurl;
  String thumbnail;
  String preview;

  PhotoProduct({this.id, this.modelType, this.modelId, this.uuid, this.collectionName, this.name, this.fileName, this.mimeType, this.disk, this.conversionsDisk, this.size, this.manipulations, this.customProperties, this.responsiveImages, this.orderColumn, this.createdAt, this.updatedAt, this.image, this.url, this.fullurl, this.thumbnail, this.preview});

  PhotoProduct.fromJson(Map<String, dynamic> json) {
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    customProperties = json['custom_properties'] != null ? new CustomProperties.fromJson(json['custom_properties']) : null;
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    url = json['url'];
    fullurl = json['fullurl'];
    thumbnail = json['thumbnail'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['uuid'] = this.uuid;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['conversions_disk'] = this.conversionsDisk;
    data['size'] = this.size;
  
    if (this.customProperties != null) {
      data['custom_properties'] = this.customProperties.toJson();
    }
  
    data['order_column'] = this.orderColumn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    data['url'] = this.url;
    data['fullurl'] = this.fullurl;
    data['thumbnail'] = this.thumbnail;
    data['preview'] = this.preview;
    return data;
  }
}

class CustomProperties {
  GeneratedConversions generatedConversions;

  CustomProperties({this.generatedConversions});

  CustomProperties.fromJson(Map<String, dynamic> json) {
    generatedConversions = json['generated_conversions'] != null ? new GeneratedConversions.fromJson(json['generated_conversions']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.generatedConversions != null) {
      data['generated_conversions'] = this.generatedConversions.toJson();
    }
    return data;
  }
}

class GeneratedConversions {
  bool thumb;
  bool small;
  bool medium;
  bool large;
  bool preview;

  GeneratedConversions({this.thumb, this.small, this.medium, this.large, this.preview});

  GeneratedConversions.fromJson(Map<String, dynamic> json) {
    thumb = json['thumb'];
    small = json['small'];
    medium = json['medium'];
    large = json['large'];
    preview = json['preview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumb'] = this.thumb;
    data['small'] = this.small;
    data['medium'] = this.medium;
    data['large'] = this.large;
    data['preview'] = this.preview;
    return data;
  }
}

class Media {
  int id;
  String modelType;
  int modelId;
  String uuid;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
  int size;
  List<Null> manipulations;
  CustomProperties customProperties;
  List<Null> responsiveImages;
  int orderColumn;
  String createdAt;
  String updatedAt;
  String image;
  String url;
  String fullurl;
  String thumbnail;
  String preview;

  Media({this.id, this.modelType, this.modelId, this.uuid, this.collectionName, this.name, this.fileName, this.mimeType, this.disk, this.conversionsDisk, this.size, this.manipulations, this.customProperties, this.responsiveImages, this.orderColumn, this.createdAt, this.updatedAt, this.image, this.url, this.fullurl, this.thumbnail, this.preview});

Media.fromJson(Map<String, dynamic> json) {
id = json['id'];
modelType = json['model_type'];
modelId = json['model_id'];
uuid = json['uuid'];
collectionName = json['collection_name'];
name = json['name'];
fileName = json['file_name'];
mimeType = json['mime_type'];
disk = json['disk'];
conversionsDisk = json['conversions_disk'];
size = json['size'];
customProperties = json['custom_properties'] != null ? new CustomProperties.fromJson(json['custom_properties']) : null;
orderColumn = json['order_column'];
createdAt = json['created_at'];
updatedAt = json['updated_at'];
image = json['image'];
url = json['url'];
fullurl = json['fullurl'];
thumbnail = json['thumbnail'];
preview = json['preview'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['model_type'] = this.modelType;
  data['model_id'] = this.modelId;
  data['uuid'] = this.uuid;
  data['collection_name'] = this.collectionName;
  data['name'] = this.name;
  data['file_name'] = this.fileName;
  data['mime_type'] = this.mimeType;
  data['disk'] = this.disk;
  data['conversions_disk'] = this.conversionsDisk;
  data['size'] = this.size;

  if (this.customProperties != null) {
    data['custom_properties'] = this.customProperties.toJson();
  }
  data['order_column'] = this.orderColumn;
  data['created_at'] = this.createdAt;
  data['updated_at'] = this.updatedAt;
  data['image'] = this.image;
  data['url'] = this.url;
  data['fullurl'] = this.fullurl;
  data['thumbnail'] = this.thumbnail;
  data['preview'] = this.preview;
  return data;
  }
}


class ProductTags {
  String name;
  String timeCreated;

  ProductTags({this.name, this.timeCreated});

  ProductTags.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    timeCreated = json['time_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['time_created'] = this.timeCreated;
    return data;
  }
}

class ProductReviews {
  int id;
  String bodyReview;
  int userId;
  int productId;
  String userName;
  String productName;
  double evaluationValue;
  String createdAt;
  String timeCreated;

  ProductReviews({this.id, this.bodyReview, this.userId, this.productId, this.userName, this.productName, this.evaluationValue, this.createdAt, this.timeCreated});

  ProductReviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bodyReview = json['body_review'];
    userId = json['user_id'];
    productId = json['product_id'];
    userName = json['user_name'];
    productName = json['product_name'];
    evaluationValue = double.parse(json['evaluation_value'].toString());
    createdAt = json['created_at'];
    timeCreated = json['time_created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body_review'] = this.bodyReview;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['user_name'] = this.userName;
    data['product_name'] = this.productName;
    data['evaluation_value'] = this.evaluationValue;
    data['created_at'] = this.createdAt;
    data['time_created'] = this.timeCreated;
    return data;
  }
}

class Data {
  int id;
  String name;
  String description;
  int discount;
  String price;
  int quantity;
  String serialNumber;
  int carMadeId;
  CarMadeName carMadeName;
  List<CarModelName> carModelName;
  int cartypeId;
  String cartypeName;
  YearFrom yearFrom;
  YearFrom yearTo;
  int partCategoryId;
  String partCategoryName;
  int categoryId;
  Category_Name categoryName;
  int vendorId;
  String vendorName;
  int storeId;
  String storeName;
  int manufacturerId;
  int prodcountryId;
  String manufacturerName;
  int transmissionId;
  String transmissionName;
  int producttypeId;
  String producttypeName;
  String origincountryName;
  Null noOfOrders;
  Null holesalePrice;
  int countViews;
  int avgValuations;
  int cartEnable;
  int wishlistEnable;
  List<Media> media;
  List<PhotoProduct> photo;
  String serialId;
  int approved;
  List<ProductTags> productTags;
  List<ProductReviews> productReviews;
  int countProductReviews;
  int countAvgValuations;
  String timeCreated;
  int inCart;
  int inWishlist;
  int inFavourites;

  Data({this.id, this.name, this.description, this.discount, this.price, this.quantity, this.serialNumber, this.carMadeId, this.carMadeName, this.carModelName, this.cartypeId, this.cartypeName, this.yearFrom, this.yearTo, this.partCategoryId, this.partCategoryName, this.categoryId, this.categoryName, this.vendorId, this.vendorName, this.storeId, this.storeName, this.manufacturerId, this.prodcountryId, this.manufacturerName, this.transmissionId, this.transmissionName, this.producttypeId, this.producttypeName, this.origincountryName, this.noOfOrders, this.holesalePrice, this.countViews, this.avgValuations, this.cartEnable, this.wishlistEnable, this.media, this.photo, this.serialId, this.approved, this.productTags, this.productReviews, this.countProductReviews, this.countAvgValuations, this.timeCreated, this.inCart, this.inWishlist, this.inFavourites});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    discount = json['discount'];
    price = json['price'];
    quantity = json['quantity'];
    serialNumber = json['serial_number'];
    carMadeId = json['car_made_id'];
    carMadeName = json['car_made_name'] != null ? new CarMadeName.fromJson(json['car_made_name']) : null;
    if (json['car_model_name'] != null) {
      carModelName = new List<CarModelName>();
      json['car_model_name'].forEach((v) { carModelName.add(new CarModelName.fromJson(v)); });
    }
    cartypeId = json['cartype_id'];
    cartypeName = json['cartype_name'];
    yearFrom = json['year_from'] != null ? new YearFrom.fromJson(json['year_from']) : null;
    yearTo = json['year_to'] != null ? new YearFrom.fromJson(json['year_to']) : null;
    partCategoryId = json['part_category_id'];
    partCategoryName = json['part_category_name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'] != null ? new Category_Name.fromJson(json['category_name']) : null;
    vendorId = json['vendor_id'];
    vendorName = json['vendor_name'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    manufacturerId = json['manufacturer_id'];
    prodcountryId = json['prodcountry_id'];
    manufacturerName = json['manufacturer_name'];
    transmissionId = json['transmission_id'];
    transmissionName = json['transmission_name'];
    producttypeId = json['producttype_id'];
    producttypeName = json['producttype_name'];
    origincountryName = json['origincountry_name'];
    noOfOrders = json['no_of_orders'];
    holesalePrice = json['holesale_price'];
    countViews = json['count_views'];
    avgValuations = json['avg_valuations'];
    cartEnable = json['cart_enable'];
    wishlistEnable = json['wishlist_enable'];
    if (json['media'] != null) {
      media = new List<Media>();
      json['media'].forEach((v) { media.add(new Media.fromJson(v)); });
    }
    if (json['photo'] != null) {
      photo = new List<PhotoProduct>();
      json['photo'].forEach((v) { photo.add(new PhotoProduct.fromJson(v)); });
    }
    serialId = json['serial_id'];
    approved = json['approved'];
    if (json['product_tags'] != null) {
      productTags = new List<ProductTags>();
      json['product_tags'].forEach((v) { productTags.add(new ProductTags.fromJson(v)); });
    }
    if (json['product_reviews'] != null) {
      productReviews = new List<ProductReviews>();
      json['product_reviews'].forEach((v) { productReviews.add(new ProductReviews.fromJson(v)); });
    }
    countProductReviews = json['count_product_reviews'];
    countAvgValuations = json['count_avg_valuations'];
    timeCreated = json['time_created'];
    inCart = json['in_cart'];
    inWishlist = json['in_wishlist'];
    inFavourites = json['in_favourites'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['serial_number'] = this.serialNumber;
    data['car_made_id'] = this.carMadeId;
    if (this.carMadeName != null) {
      data['car_made_name'] = this.carMadeName.toJson();
    }
    if (this.carModelName != null) {
      data['car_model_name'] = this.carModelName.map((v) => v.toJson()).toList();
    }
    data['cartype_id'] = this.cartypeId;
    data['cartype_name'] = this.cartypeName;
    if (this.yearFrom != null) {
      data['year_from'] = this.yearFrom.toJson();
    }
    if (this.yearTo != null) {
      data['year_to'] = this.yearTo.toJson();
    }
    data['part_category_id'] = this.partCategoryId;
    data['part_category_name'] = this.partCategoryName;
    data['category_id'] = this.categoryId;
    if (this.categoryName != null) {
      data['category_name'] = this.categoryName.toJson();
    }
    data['vendor_id'] = this.vendorId;
    data['vendor_name'] = this.vendorName;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['manufacturer_id'] = this.manufacturerId;
    data['prodcountry_id'] = this.prodcountryId;
    data['manufacturer_name'] = this.manufacturerName;
    data['transmission_id'] = this.transmissionId;
    data['transmission_name'] = this.transmissionName;
    data['producttype_id'] = this.producttypeId;
    data['producttype_name'] = this.producttypeName;
    data['origincountry_name'] = this.origincountryName;
    data['no_of_orders'] = this.noOfOrders;
    data['holesale_price'] = this.holesalePrice;
    data['count_views'] = this.countViews;
    data['avg_valuations'] = this.avgValuations;
    data['cart_enable'] = this.cartEnable;
    data['wishlist_enable'] = this.wishlistEnable;
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    if (this.photo != null) {
      data['photo'] = this.photo.map((v) => v.toJson()).toList();
    }
    data['serial_id'] = this.serialId;
    data['approved'] = this.approved;
    if (this.productTags != null) {
      data['product_tags'] = this.productTags.map((v) => v.toJson()).toList();
    }
    if (this.productReviews != null) {
      data['product_reviews'] = this.productReviews.map((v) => v.toJson()).toList();
    }
    data['count_product_reviews'] = this.countProductReviews;
    data['count_avg_valuations'] = this.countAvgValuations;
    data['time_created'] = this.timeCreated;
    data['in_cart'] = this.inCart;
    data['in_wishlist'] = this.inWishlist;
    data['in_favourites'] = this.inFavourites;
    return data;
  }
}

class Category_Name {
  int id;
  String name;
  String name_en;
  String description;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String lang;
  int maincategoryId;
  Media photo;
  List<Media> media;

  Category_Name({this.id, this.name, this.description, this.createdAt, this.updatedAt, this.deletedAt, this.lang, this.maincategoryId, this.photo, this.media});

  Category_Name.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    name_en = json['name_en'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    lang = json['lang'];
    maincategoryId = json['maincategory_id'];
    photo = json['photo'] != null ? new Media.fromJson(json['photo']) : null;
    if (json['media'] != null) {
      media = new List<Media>();
      json['media'].forEach((v) { media.add(new Media.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['lang'] = this.lang;
    data['maincategory_id'] = this.maincategoryId;
    if (this.photo != null) {
      data['photo'] = this.photo.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
