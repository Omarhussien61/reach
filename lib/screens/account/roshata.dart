import 'dart:async';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/shipping_address.dart';
import 'package:flutter_pos/screens/account/add_address.dart';
import 'package:flutter_pos/screens/product/companies.dart';
import 'package:flutter_pos/screens/product/roshata_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/Provider/ServiceData.dart';

class Roshata extends StatefulWidget {
  const Roshata({Key key}) : super(key: key);

  @override
  State<Roshata> createState() => _RoshataState();
}

class _RoshataState extends State<Roshata> {
  File attachment;
  List<Address> address;
  int checkboxValue;
  Address DefaultAddress;
  @override
  void initState() {
    getAddress();
    //getpaymentways();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(
              isback: true,
              title: 'اضافة روشتة',
            ),
            InkWell(
              onTap: () {
                Nav.route(
                    context,
                    RoshatasScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'الروشتات الخاصة بي',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                    )),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.do_disturb_alt_rounded),
                SizedBox(
                  width: 10,
                ),
                Text(" لا تقم بقطع اجزاء من الروشتة"),
              ],
            ),
            InkWell(
              onTap: () {
                getAttachment();
              },
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orange),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'اضافة صورة روشتة',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )),
                    )),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTransrlate(context, 'Address'),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            address == null
                ? Padding(
              padding: const EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            )
                : address.isEmpty
                ? Text('${getTransrlate(context, 'selectAddressMsg')}')
                : ListView.builder(
              padding: EdgeInsets.all(1),
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: address.length,
              itemBuilder:
                  (BuildContext context, int index) {
                return Center(
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Radio<int>(
                          value:address[index].id,
                          groupValue: checkboxValue,
                          activeColor: themeColor.getColor(),
                          focusColor: themeColor.getColor(),
                          hoverColor: themeColor.getColor(),
                          onChanged: (int value) {
                            setState(() {
                              checkboxValue = value;
                              DefaultAddress=address[index];
                            });
                          },
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              checkboxValue = index;
                            });
                          },
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            children: [
                              Text(
                                address[index].street,
                                style: TextStyle(
                                    fontWeight:
                                    checkboxValue == index
                                        ? FontWeight.bold
                                        : FontWeight.w400,
                                    fontSize: 20),
                              ),
                              Container(
                                width: ScreenUtil.getWidth(context) / 1.8,
                                child: Text(
                                  "${address[index].apartmentNo ?? ' '} ,${address[index].building ?? ' '} , ${address[index].city !=null?address[index].city.name: ' '} , "
                                      "${address[index].country==null?'':address[index].country.name ?? ' '}",
                                  maxLines: 2,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontWeight:
                                      checkboxValue ==
                                          index
                                          ? FontWeight
                                          .bold
                                          : FontWeight
                                          .w400,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: SizedBox(
                              height: 1,
                            )),
                      ],
                    ));
              },
            ),
            Center(
              child: GestureDetector(
                child: Container(
                  width: ScreenUtil.getWidth(context) / 2.5,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange)),
                  child: Center(
                    child: AutoSizeText(
                      getTransrlate(context, 'AddNewAddress'),
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
                  _navigate_add_Address(context);
                },
              ),
            ),
            attachment == null
                ? Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('assets/images/pana.png'),
                  )
                : Container(
                    child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: ScreenUtil.getWidth(context) / 2.5,
                            child: Text(
                              "${attachment.path}",
                              maxLines: 1,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              CupertinoIcons.clear_circled,
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                attachment = null;
                              });
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Image.file(attachment),
                      ),
                      InkWell(
                        onTap: () async {
                          print("full_url");

                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          print(prefs.getString('token'));
                          API(context)
                              .postFile(
                                  'store/roshtaa/?token=${prefs.getString('token')}',
                                  {"address":DefaultAddress.toJson().toString()},
                                  attachment: attachment)
                              .then((value) {
                            if (value != null) {
                              if (value.containsKey('id')) {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay('تم ارسال الروشتة'));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => ResultOverlay(
                                        "${value['message']}\n${value['errors']}"));
                              }
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.green),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    'ارسال صورة روشتة',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                              )),
                        ),
                      )
                    ],
                  )),
            Container(),
          ],
        ),
      ),
    );
  }

  getAttachment() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        attachment = File(result.files.single.path);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<void> getAddress() async {
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();
    API(context).get('account/api/address/?token=${prefs.getString('token')}').then((value) {
      if (value != null) {
        setState(() {
          address = ShippingAddress.fromJson(value).data;
        });
      }
    });
  }

  _navigate_add_Address(BuildContext context) async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddAddress()));
    Timer(Duration(seconds: 3), () => getAddress());
  }
}
