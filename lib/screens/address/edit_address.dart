import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/area_model.dart';
import 'package:flutter_pos/model/city_model.dart';
import 'package:flutter_pos/model/country_model.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../model/shipping_address.dart';

class EditAddress extends StatefulWidget {
  EditAddress(this.address);

  Address address;

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  final _formKey = GlobalKey<FormState>();
  List<Country> contries;
  List<City> cities;
  List<Area> area;
bool loading=false;
  @override
  void initState() {
    widget.address.Country_id=widget.address.state==null?null:widget.address.state.id;
    widget.address.area_id=widget.address.area==null?null:widget.address.area.id;
    widget.address.city_id=widget.address.city==null?null:widget.address.city.id;

    getCountry();
  }

  @override
  Widget build(BuildContext context) {
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
                  getTransrlate(context, 'edit'),
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextFormField(
                  intialLabel: widget.address.recipientName,
                  keyboard_type: TextInputType.name,
                  labelText: getTransrlate(context, 'Firstname'),
                  hintText: getTransrlate(context, 'Firstname'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    }else   if (value.length<=2) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    widget.address.recipientName = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: widget.address.lastName,
                  keyboard_type: TextInputType.text,
                  labelText: getTransrlate(context, 'Lastname'),
                  hintText: getTransrlate(context, 'Lastname'),
                  isPhone: true,
                  validator: (String value) {
                    // if (value.isEmpty) {
                    //   return getTransrlate(context, 'requiredempty');
                    // }else   if (value.length<=2) {
                    //   return "${getTransrlate(context, 'requiredlength')}";
                    // }else if (RegExp(
                    //     r"^[+-]?([0-9]*[.])?[0-9]+").hasMatch(value)) {
                    //   return getTransrlate(context, 'invalidname');
                    // }
                    // return null;
                  },
                  onSaved: (String value) {
                    widget.address.lastName = value;
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  getTransrlate(context, 'Countroy'),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                contries == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: DropdownSearch<Country>(
                           label: getTransrlate(context, 'Countroy'),
                          selectedItem: widget.address.state ,
                          items: contries,
                          //  onFind: (String filter) => getData(filter),
                          itemAsString: (Country u) => u.countryName,
                          onChanged: (Country data) {
                            widget.address.Country_id = data.id ;
                            setState(() {
                              widget.address.state=data;
                              area=null;
                              widget.address.area=Area();
                              widget.address.city=null;
                            });
                            getArea(data.id);
                          },
                        ),
                      ),
                area == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: DropdownSearch<Area>(
                           label: getTransrlate(context, 'area'),

                          selectedItem: widget.address.area,

                          items: area,
                          //  onFind: (String filter) => getData(filter),
                          itemAsString: (Area u) => u.areaName??'',
                          onChanged: (Area data) {
                            widget.address.area_id = data.id;
                            setState(() {
                              widget.address.area=data;

                              cities=null;
                              widget.address.city=City();
                            });
                            getCity(data.id);
                          },
                        ),
                      ),
                cities == null
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: DropdownSearch<City>(
                           label: getTransrlate(context, 'City'),

                          selectedItem: widget.address.city,

                          items: cities,
                          //  onFind: (String filter) => getData(filter),
                          itemAsString: (City u) => u.cityName??'',
                          onChanged: (City data) {
                             setState(() {
                               widget.address.city=data;

                             });
                            widget.address.city_id = data.id;
                          },
                        ),
                      ),
                MyTextFormField(
                  intialLabel: widget.address.district,
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'district'),
                  hintText: getTransrlate(context, 'district'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'district');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    widget.address.district = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: widget.address.street,
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'Street'),
                  hintText: getTransrlate(context, 'Street'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'Street');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    widget.address.street = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: widget.address.homeNo,
                  keyboard_type: TextInputType.number,
                  labelText: getTransrlate(context, 'HomeNo'),
                  hintText: getTransrlate(context, 'HomeNo'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'HomeNo');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    widget.address.homeNo = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: widget.address.floorNo,
                  keyboard_type: TextInputType.number,
                  labelText: getTransrlate(context, 'FloorNo'),
                  hintText: getTransrlate(context, 'FloorNo'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'FloorNo');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    widget.address.floorNo = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: widget.address.apartmentNo,
                  keyboard_type: TextInputType.number,
                  labelText: getTransrlate(context, 'apartment_no'),
                  hintText: getTransrlate(context, 'apartment_no'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'apartment_no');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    widget.address.apartmentNo = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: widget.address.recipientPhone,
                  keyboard_type: TextInputType.phone,
                  labelText: getTransrlate(context, 'phone'),
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(13),
                  ],
                  hintText: getTransrlate(context, 'phone'),
                  textDirection: TextDirection.ltr,
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'phone');
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    widget.address.recipientPhone = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: widget.address.telephoneNo,
                  keyboard_type: TextInputType.phone,
                  textDirection: TextDirection.ltr,
                  validator: (String value) {
                    if (value.length>1&&value.length<8) {
                      return getTransrlate(context, 'requiredlength');
                    } else  if (value.length>1&&!value.startsWith('0')) {
                      return getTransrlate(context, 'telphone0');
                    } 
                    _formKey.currentState.save();
                    return null;
                  },
                  inputFormatters: [
                    new LengthLimitingTextInputFormatter(17),
                  ],
                  labelText: getTransrlate(context, 'telphone'),
                  hintText: getTransrlate(context, 'telphone'),
                  isPhone: true,
                  onSaved: (String value) {
                    widget.address.telephoneNo = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: widget.address.nearestMilestone,
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'nearest_milestone'),
                  hintText: getTransrlate(context, 'nearest_milestone'),
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'nearest_milestone');
                    } else if (value.length > 250) {
                      return "Over length";
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    widget.address.nearestMilestone = value;
                  },
                ),
                MyTextFormField(
                  intialLabel: widget.address.notices,
                  keyboard_type: TextInputType.emailAddress,
                  labelText: getTransrlate(context, 'OrderNote'),
                  hintText: getTransrlate(context, 'OrderNote'),
                  isPhone: true,
                  onSaved: (String value) {
                    widget.address.notices = value;
                  },
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child:  loading?TextButton(
                        style:getStyleButton( Colors.orange),

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
                            setState(() => loading = true);
                            print(widget.address.toJson());
                            API(context)
                                .post(
                                    'user/update/shipping/${widget.address.id}',
                                    widget.address.toJson())
                                .then((value) {
                              if (value != null) {
                                setState(() => loading = false);
                                if (value['status_code'] == 202) {
                                  Navigator.pop(context);
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay(value['message']));
                                  Provider.of<Provider_Data>(context,listen: false).getShipping(context);

                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => ResultOverlay(
                                          '${value['message'] ?? ''}\n${value['errors']??''}'));
                                }
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
    API(context).get('cities/list/all/$id').then((value) {
      setState(() {
        cities = City_model.fromJson(value).data;
      });
    });
  }

  void getArea(int id) {
    API(context).get('areas/list/all/$id').then((value) {
      setState(() {
        area = Area_model.fromJson(value).data;
      });
      getCity(widget.address.city_id);
    });

  }

  void getCountry() {
    API(context).get('countries/list/all').then((value) {
      setState(() {
        contries = Country_model.fromJson(value).data;
      });
      getArea(widget.address.Country_id);
    });
  }
}
