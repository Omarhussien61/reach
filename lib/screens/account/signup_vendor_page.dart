import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/register/register_form_vendor.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpVendorPage extends StatefulWidget {
  @override
  _SignUpVendorPageState createState() => _SignUpVendorPageState();
}

class _SignUpVendorPageState extends State<SignUpVendorPage> {
  String email, facebook_id;
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
        ),
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                        getTransrlate(context, 'AreadyAccount'),
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
              RegisterFormVendor(),
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
      padding: EdgeInsets.only(right: 36, left: 48),
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
          SizedBox(
            height: 15,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: ScreenUtil.getWidth(context) / 4.5,
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
                    width: ScreenUtil.getWidth(context) / 4.5,
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
        {'facebook_id': facebook_id, 'email': email}).then((value) {
      if (!value.containsKey('errors')) {
        var user = value['data'];
        prefs.setString("user_email", user['email']);
        prefs.setString("user_name", user['name']);
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
