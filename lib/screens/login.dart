import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/register_page.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/login/login_form.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: Text(getTransrlate(context, 'login')),
        ),
        body: WillPopScope(
          // ignore: missing_return
          onWillPop: () {
          //  Nav.routeReplacement(context, LoginPage());
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: ScreenUtil.getHeight(context) / 5,
                      width: ScreenUtil.getWidth(context) / 2,
                      fit: BoxFit.contain,
                      color: themeColor.getColor(),
                    ),
                  ),
                ),
                LoginForm(),
                routeLoginWidget(themeColor, context),

              ],
            ),
          ),
        ));
  }
  Widget routeLoginWidget(Provider_control themeColor, BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 36, left: 48, bottom: 12),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              getTransrlate(context, 'AreadyAccount'),
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          FlatButton(
            child: Text(
              getTransrlate(context, 'Register'),
              style: TextStyle(
                fontSize: 14,
                color: themeColor.getColor(),
                fontWeight: FontWeight.w300,
              ),
            ),
            onPressed: () {
              Nav.routeReplacement(context, RegisterPage());
            },
          )
        ],
      ),
    );
  }

}
