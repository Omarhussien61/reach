import 'dart:convert';

import 'package:flutter_pos/model/area_model.dart';
import 'package:flutter_pos/model/city_model.dart';
import 'package:flutter_pos/model/country_model.dart';

class ShippingAddress {
  int statusCode;
  String message;
  List<Address> data;
  int total;

  ShippingAddress({this.statusCode, this.message, this.data, this.total});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    message = json['message'];
    if (json['results'] != null) {
      data = new List<Address>();
      json['results'].forEach((v) {
        data.add(new Address.fromJson(v));
      });
    }
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


Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  int id;
  City city;
  City country;
  String street;
  String building;
  String floor;
  String apartmentNo;
  String specialMark;

  Address({
    this.id,
    this.city,
    this.country,
    this.street,
    this.building,
    this.floor,
    this.apartmentNo,
    this.specialMark,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    city: City.fromJson(json["city"]),
    country: City.fromJson(json["country"]),
    street: json["street"],
    building: json["building"],
    floor: json["floor"],
    apartmentNo: json["apartment_no"],
    specialMark: json["special_mark"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city.toJson(),
    "country": country.toJson(),
    "street": street,
    "building": building,
    "floor": floor,
    "apartment_no": apartmentNo,
    "special_mark": specialMark,
  };
}

class City {
  int id;
  String name;

  City({
    this.id,
    this.name,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

