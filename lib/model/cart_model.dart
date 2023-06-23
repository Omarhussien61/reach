// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_pos/model/Product.dart';

Cart_model cartModelFromJson(String str) => Cart_model.fromJson(json.decode(str));

String cartModelToJson(Cart_model data) => json.encode(data.toJson());

class Cart_model {
  int id;
  List<Item> items;
  double grandTotal;

  Cart_model({
    this.id,
    this.items,
    this.grandTotal,
  });

  factory Cart_model.fromJson(Map<String, dynamic> json) => Cart_model(
    id: json["id"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    grandTotal: json["grand_total"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "grand_total": grandTotal,
  };
}

class Item {
  int id;
  int cart;
  Product product;
  int quantity;
  double subTotal;

  Item({
    this.id,
    this.cart,
    this.product,
    this.quantity,
    this.subTotal,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    cart: json["cart"],
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
    subTotal: json["sub_total"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart": cart,
    "product": product.toJson(),
    "quantity": quantity,
    "sub_total": subTotal,
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
