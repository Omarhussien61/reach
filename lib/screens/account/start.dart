import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/main.dart';
import 'package:flutter_pos/screens/account/Conditions.dart';
import 'package:flutter_pos/screens/account/return.dart';
import 'package:flutter_pos/screens/account/signUP_page.dart';
import 'package:flutter_pos/screens/account/support.dart';
import 'package:flutter_pos/screens/account/OrderHistory.dart';
import 'package:flutter_pos/screens/account/infoPage.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/account/user_information.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/item_hidden_menu.dart';
import 'package:flutter_pos/screens/account/wishlist_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final _cart_model = Provider.of<Provider_Data>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 1,
              offset: Offset(0.0, 1)),
        ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              child: Image.asset(
                'assets/images/logo.jpg',
                height: 300,
              ),
            ),

            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: ScreenUtil.getWidth(context),
                height: ScreenUtil.getHeight(context) / 2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60)),
                    color: Colors.orange),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      Text("مرحبا بك في صيدليات ريتش"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "نعمل علي توفير رعاية صحية ممتازة للجميع علي مدار الساعة طوال ايام الاسبوع مثل المعدات  الطبية و الادوية و مستحضرات التجميل و المكياج و العطور ",
                        style: TextStyle(
                            height: 2, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Nav.route(context, LoginPage());
                            },
                            child: Container(
                              width: ScreenUtil.getWidth(context) / 2.5,
                              height: 50,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green),
                              child: Center(
                                child: AutoSizeText(
                                  getTransrlate(context, 'login'),
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              Nav.route(context, SignUpPage());
                            },
                            child: Container(
                              width: ScreenUtil.getWidth(context) / 2.5,
                              height: 50,
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.green),
                              child: Center(
                                child: AutoSizeText(
                                  getTransrlate(context, 'AreadyAccount'),
                                  overflow: TextOverflow.ellipsis,
                                  maxFontSize: 14,
                                  maxLines: 1,
                                  minFontSize: 10,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextButton(onPressed: (){
                          Nav.routeReplacement(context, Home());

                        }, child: Text("تابع بدون تسجيل ؟",
                          style: TextStyle(
                              height: 2, color: Colors.grey,decoration: TextDecoration.underline),)),
                      ),
                      Expanded(
                        child: SizedBox(
                          width: 40,
                        ),
                      ),
                      Center(child: Text('code - Xfactory'))

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
