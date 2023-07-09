import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/product/companies.dart';
import 'package:flutter_pos/screens/product/roshata_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Roshata extends StatefulWidget {
  const Roshata({Key key}) : super(key: key);

  @override
  State<Roshata> createState() => _RoshataState();
}

class _RoshataState extends State<Roshata> {
  File attachment;

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
                                  {},
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
}
