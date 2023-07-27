import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/shipping_address.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();
  Address address = new Address();
  List<City> contries;
  List<City> cities;
  bool loading = false;

  TextEditingController code= TextEditingController();
  @override
  void initState() {
    getCountry();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              "assets/icons/User Icon.svg",
              color: Colors.white,
              height: 25,
            ),
            SizedBox(
              width: 10,
            ),
            Text(getTransrlate(context, 'MyAddress')),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTransrlate(context, 'AddNewAddress'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(
                  height:20,
                ),

                Text(
                  getTransrlate(context, 'Countroy'),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                contries==null? Container(
                  child: DropdownSearch<String>(
                    showSearchBox: false,
                    showClearButton: false,
                    label: " ",
                    items: [''],
                    enabled: false,
                    //  onFind: (String filter) => getData(filter),
                  ),
                ):Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DropdownSearch<City>(
                    showSearchBox: true,
                    // label: getTransrlate(context, 'Countroy'),
                    validator: (City item) {
                      if (item == null) {
                        return "${getTransrlate(context, 'Required')}";
                      } else
                        return null;
                    },

                    items: contries,
                    //  onFind: (String filter) => getData(filter),
                    itemAsString: (City u) => "${u.name}",
                    onChanged: (City data) {
                      print(data.id);
                      address.country = data;
                       setState(() {
                         cities=null;
                       });
                      getCity(data.id);
                    },
                  ),
                ),
                Text(
                  getTransrlate(context, 'City'),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                cities==null? Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DropdownSearch<String>(
                      showSearchBox: false,
                      showClearButton: false,
                      label: " ",
                      items: [''],
                      enabled: false,
                      //  onFind: (String filter) => getData(filter),
                    ),
                  ),
                ):Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: DropdownSearch<City>(
                    showSearchBox: true,
                    validator: (City item) {
                      if (item == null) {
                        return "${getTransrlate(context, 'Required')}";
                      } else
                        return null;
                    },

                    items: cities,
                    //  onFind: (String filter) => getData(filter),
                    itemAsString: (City u) => "${u.name}",
                    onChanged: (City data) {
                      print(data.id);
                      address.city=data;
                    } ,
                  ),
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'Street'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    }else   if (value.length<1) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    address.street = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.number,
                  labelText: getTransrlate(context, 'HomeNo'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    }else   if (value.length<1) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    address.building = value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.number,
                  labelText: getTransrlate(context, 'FloorNo'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    }else   if (value.length<1) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    address.floor = value;

                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.number,
                  labelText: getTransrlate(context, 'apartment_no'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    }else   if (value.length<1) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    address.apartmentNo = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.text,
                  labelText: getTransrlate(context, 'nearest_milestone'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    }else   if (value.length<2) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    address.specialMark = value;

                  },
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child:  loading?TextButton(

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:Container(
                            height: 30,
                            child: Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>( Colors.white),
                                )),
                          ),
                        ),
                        onPressed: () async {
                        },
                      ):GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.orange)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'save'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            print( jsonEncode(address.toJson()));
                            setState(() => loading = true);
                            SharedPreferences.getInstance().then((value) {
                              if(value.getString('token')!=null){
                                API(context)
                                    .post('account/api/newaddress/?token=${value.getString('token')}', address.toJson())
                                    .then((value) {
                                  if (value != null) {
                                    setState(() => loading = false);

                                    if (value.containsKey('id')) {
                                      Navigator.pop(context);

                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) => ResultOverlay(
                                              '$value'));
                                    }
                                  }
                                });
                              }
                            });


                          }
                        },
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 2.5,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'close'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getCity(int id) {
    API(context).get('account/cities/$id').then((value) {
      setState(() {
        cities=[];
        value['data'].forEach((v){
          cities.add(City.fromJson(v));
        });
      });
    });

  }

  void getCountry() {
    API(context).get('account/country').then((value) {
      setState(() {
        contries=[];
        value['data'].forEach((v){
          contries.add(City.fromJson(v));
        });
      });
    });

  }
}
