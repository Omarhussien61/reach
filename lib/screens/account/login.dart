import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/signUP_page.dart';
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: ScreenUtil.getHeight(context)/2.5,
                  child: Image.asset(
                    'assets/images/remedy.png',
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical : 2,horizontal: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,),
                        Text(getTransrlate(context, 'login'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),),
                        Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,)
                      ],
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
      padding: EdgeInsets.only(right: 20, left: 20, bottom: 2),
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical : 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,),
                  Container(child: Text(getTransrlate(context, 'or'),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,),)),
                  Container(height: 1,width: ScreenUtil.getWidth(context)/4,color: Colors.black12,)
                ],
              ),
            ),
          ),
          Container(
            height: 42,
            width: ScreenUtil.getWidth(context),
            child: OutlinedButton(
            style:getStyleButton( Colors.black),
              child: Text(
                getTransrlate(context, 'AreadyAccount'),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Nav.routeReplacement(context, SignUpPage());
              },
            ),
          )
        ],
      ),
    );
  }

}
