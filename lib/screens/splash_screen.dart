import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/account/start.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen();
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Provider_control themeColor;
  Provider_Data _provider_data;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () => _auth());
  }

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<Provider_control>(context);
    _provider_data = Provider.of<Provider_Data>(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: themeColor.getColor(),
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/logo.jpg',
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/hotline.png',
                    ),
                  ),

                ],
              ),
              Text('code - Xfactory')
            ],
          ),
        ),
      ),
    );
  }

  void _auth() async {
    //themeColor.setCar_made(getTransrlate(context, 'selectCar'));
    final SharedPreferences prefs =
    await SharedPreferences.getInstance();
        if(prefs.getString('token')==null){
          Nav.routeReplacement(context, StartScreen());

        }else{
          Nav.routeReplacement(context, Home());

        }
         //  Nav.routeReplacement(context, Home());

    // API(context,Check: false).post('check/valid/session', {}).then((value) async {
    //
    //   if (value != null) {
    //
    //     if (value['status_code'] == 200) {
    //       themeColor.setLogin(true);
    //       var user = value['data'];
    //       if (user.containsKey('vendor_details')) {
    //         prefs.setInt(
    //             "complete", user['vendor_details']['complete']);
    //         prefs.setString("vendor", 'vendor');
    //
    //       }
    //
    //       prefs.setString("user_email", "${user['email']}");
    //       prefs.setString("user_name", "${user['name']}");
    //    //   prefs.setString("token", "${user['token']}");
    //       prefs.setInt("user_id", user['id']);
    //
    //
    //       Nav.routeReplacement(context, Home());
    //
    //     } else {
    //       themeColor.setLogin(false);
    //       themeColor.setComplete(1);
    //       SharedPreferences.getInstance().then((prefs) {
    //         prefs.clear();
    //       });
    //       Nav.routeReplacement(context, Home());
    //
    //     }
    //   }
    // });
  }
}
