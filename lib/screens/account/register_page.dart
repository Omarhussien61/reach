import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/account/signUP_page.dart';
import 'package:flutter_pos/screens/account/signup_vendor_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email, name, facebook_id;
  Provider_control themeColor;

  @override
  Widget build(BuildContext context) {
    themeColor = Provider.of<Provider_control>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: themeColor.getColor(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo.png',
            height: ScreenUtil.getHeight(context) / 10,
            width: ScreenUtil.getWidth(context) / 4,
            fit: BoxFit.contain,
            //color: themeColor.getColor(),
          ),
          leading: Container(),
        ),
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Text(
                    getTransrlate(context, 'AreadyAccount'),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Nav.route(context, SignUpPage());
                },
                child: Container(
                  width: ScreenUtil.getWidth(context)/1.3,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 1)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${getTransrlate(context, 'want_to_buy_products')}',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: (){
                  Nav.route(context, SignUpVendorPage());
                },
                child: Container(
                  width: ScreenUtil.getWidth(context)/1.3,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange, width: 1)),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${getTransrlate(context, 'register_as_seller')}',
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              routeLoginWidget(themeColor, context),
              SizedBox(
                height: 50,
              )

              //SocialRegisterButtons(themeColor: themeColor)
            ],
          ),
        ),
      ),
    );
  }

  Widget routeLoginWidget(Provider_control themeColor, BuildContext context) {
    return Container(
      width: ScreenUtil.getWidth(context)/1.3,

      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  ),
                  Text(
                    getTransrlate(context, 'or'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 8,
                    color: Colors.black12,
                  ),
                  Text(
                    getTransrlate(context, 'haveanaccount'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 8,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ),
          TextButton(
            style:getStyleButton( Colors.orange),

            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                getTransrlate(context, 'login'),
                style: TextStyle(
                  fontSize: 14,
                  color: themeColor.getColor(),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            onPressed: () {
              Nav.routeReplacement(context, LoginPage());
            },
          )
        ],
      ),
    );
  }



  register(Provider_control themeColor) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context).post('login/facebook',
        {'facebook_id': facebook_id, 'email': email, 'name': name}).then((value) {
      if (!value.containsKey('errors')) {
        var user = value['data'];
        prefs.setString("user_email", user['email']);
        prefs.setString("user_name", user['name']??' ');
        prefs.setString("token", user['token']);
        prefs.setInt("user_id", user['id']);
        themeColor.setLogin(true);
        Phoenix.rebirth(context);
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                ResultOverlay('${value['message']}\n${value['errors']}'));
      }
    });
  }
}
