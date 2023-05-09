
import 'package:flutter/material.dart';

class Provider_control with ChangeNotifier {
  Color _themeData = Color(0xffFE8A00);
  String local;
  String car_model='' ;
  String car_title ;
  int Complete ;
  int car_type =  1;
  int index =  0;
  Color color;
  bool isLogin = false;
  Provider_control(this.local){
    // if(car_model==null){
    //   if(this.local=='en'){
    //   car_model='Select Car';
    // }else {
    //   car_model='إختر المركبة';
    // }
    //   notifyListeners();
    //
    // }

  }
  getColor() => _themeData;
  getCar_made() => car_model;
  getcar_type() => car_type;
  getcar_index() => index;
  getlocal() => local;

  setComplete(int complete) async {
    Complete = complete;
    notifyListeners();
  }
  setCar_made(String CarMade) async {
    car_model = CarMade;
    notifyListeners();
  }
setCar_type(int CarType) async {
  car_type = CarType;
    notifyListeners();
  }
  setCar_index(int CarType) async {
  index = CarType;
    notifyListeners();
  }

  setColor(Color themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  setLogin(bool isLog) {
    isLogin = isLog;
    notifyListeners();
  }

  setLocal(String st) {
    local = st;
    notifyListeners();
  }
}
