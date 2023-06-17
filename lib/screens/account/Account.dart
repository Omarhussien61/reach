import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/main.dart';
import 'package:flutter_pos/screens/account/Conditions.dart';
import 'package:flutter_pos/screens/account/return.dart';
import 'package:flutter_pos/screens/account/signUP_page.dart';
import 'package:flutter_pos/screens/account/support.dart';
import 'package:flutter_pos/screens/address/Address_Page.dart';
import 'package:flutter_pos/screens/account/OrderHistory.dart';
import 'package:flutter_pos/screens/account/infoPage.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/account/user_information.dart';
import 'package:flutter_pos/screens/account/vendor_information.dart';
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

import '../MyCars/myCars.dart';

class Account extends StatefulWidget {
  const Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String name;
  String token;
  String vendor;

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        name = prefs.getString('user_name');
        token = prefs.getString('token');
        vendor = prefs.getString('vendor');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final _cart_model = Provider.of<Provider_Data>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarCustom(),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 1)),
            ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        name == null
                            ? getTransrlate(context, 'gust')
                            : "${getTransrlate(context, 'gust')} : ${name}",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(onPressed: (){
                        Navigator.of(context).pop();
                      }, icon: Icon(Icons.close))
                    ],
                  ),
                ),
                token != null
                    ? Container()
                    : Container(
                  width: ScreenUtil.getWidth(context) ,
                  child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Nav.route(context, LoginPage());
                              },
                              child: Container(
                                width: ScreenUtil.getWidth(context) / 1.2,

                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.orange)),
                                child: Center(
                                  child: AutoSizeText(
                                    getTransrlate(context, 'login'),
                                    maxFontSize: 14,
                                    minFontSize: 10,
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30,),
                            InkWell(
                              onTap: () {
                                Nav.route(context, SignUpPage());
                              },
                              child: Container(
                                width: ScreenUtil.getWidth(context) / 1.2,

                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.orange)),
                                child: Center(
                                  child: AutoSizeText(
                                    getTransrlate(context, 'AreadyAccount'),
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
                            ),
                          ],
                        ),
                    ),
                SizedBox(
                  height: ScreenUtil.getWidth(context) / 15,
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  token == null
                      ? Container()
                      :  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 16, left: 16),
                            child: NotificationListener<
                                OverscrollIndicatorNotification>(
                              onNotification: (scroll) {
                                scroll.disallowGlow();
                                return false;
                              },
                              child: Column(
                                children: <Widget>[
                                  vendor == null
                                      ? Container()
                                      : ItemHiddenMenu(
                                          onTap: () {
                                            Nav.route(context, VendorInfo());
                                          },
                                          icon: SvgPicture.asset(
                                            'assets/icons/store.svg',
                                            height: 25,
                                            color: Colors.orange,
                                          ),
                                          name: getTransrlate(
                                              context, 'vendorSettings'),
                                          baseStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 19.0,
                                              fontWeight: FontWeight.w800),
                                          colorLineSelected: Colors.orange,
                                        ),
                                  ItemHiddenMenu(
                                    onTap: () {
                                      Nav.route(context, UserInfo());
                                    },
                                    icon: SvgPicture.asset(
                                      'assets/icons/account.svg',
                                      color: Colors.orange,
                                    ),
                                    name: getTransrlate(
                                        context, 'ProfileSettings'),
                                    baseStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w800),
                                    colorLineSelected: Colors.orange,
                                  ),
                                  ItemHiddenMenu(
                                    lable:  token == null
                                        ? '': _cart_model.address == null
                                        ? ''
                                        : '${_cart_model.address.area == null ? '' : _cart_model.address.area.areaName ?? ''},${ _cart_model.address.city == null ? '' :  _cart_model.address.city.cityName ?? ''} , ${ _cart_model.address.street ?? ''}',
                                    onTap: () {
                                      Nav.route(context, Shipping_Address());
                                    },
                                    icon: Icon(
                                      Icons.location_on_outlined,
                                      size: 25,
                                      color: Colors.orange,
                                    ),
                                    name: getTransrlate(context, 'MyAddress') ,
                                    baseStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w800),
                                    colorLineSelected: Colors.orange,
                                  ),
                                  ItemHiddenMenu(
                                    onTap: () {
                                      Nav.route(context, OrderHistory());
                                    },
                                    icon: Icon(
                                      Icons.local_shipping_outlined,
                                      size: 25,
                                      color: Colors.orange,
                                    ),
                                    name: getTransrlate(context, 'Myorders'),
                                    baseStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w800),
                                    colorLineSelected: Colors.orange,
                                  ),
                                  ItemHiddenMenu(
                                    onTap: () {
                                      Nav.route(context, WishList());
                                    },
                                    icon: Icon(
                                      Icons.favorite_border,
                                      size: 25,
                                      color: Colors.orange,
                                    ),
                                    name: getTransrlate(context, 'MyFav'),
                                    baseStyle: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19.0,
                                        fontWeight: FontWeight.w800),
                                    colorLineSelected: Colors.orange,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    color: Color(0xffF6F6F6),
                    padding: const EdgeInsets.only(right: 16, left: 16),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            await themeColor.local == 'ar'
                                ? themeColor.setLocal('en')
                                : themeColor.setLocal('ar');
                            MyApp.setlocal(
                                context, Locale(themeColor.getlocal(), ''));
                            SharedPreferences.getInstance().then((prefs) {
                              prefs.setString('local', themeColor.local);
                            });
                            Phoenix.rebirth(context);
                          },
                          child: ItemHiddenMenu(
                            icon: Icon(
                              Icons.language,
                              size: 25,
                              color: Colors.orange,
                            ),
                            name:
                                Provider.of<Provider_control>(context).local ==
                                        'ar'
                                    ? 'English'
                                    : 'عربى',
                            baseStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w800),
                            colorLineSelected: Colors.orange,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Nav.route(context, Support_Screen());
                          },
                          child: ItemHiddenMenu(
                            icon: Icon(
                              Icons.help_outline_rounded,
                              size: 25,
                              color: Colors.orange,
                            ),
                            name: getTransrlate(context, 'Support'),
                            baseStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w800),
                            colorLineSelected: Colors.orange,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Nav.route(context, Return());
                          },
                          child: ItemHiddenMenu(
                            icon: Icon(
                              Icons.info_outline,
                              size: 25,
                              color: Colors.orange,
                            ),
                            name: getTransrlate(context, 'return'),
                            baseStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w800),
                            colorLineSelected: Colors.orange,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Nav.route(context, Conditions());
                          },
                          child: ItemHiddenMenu(
                            icon: Icon(
                              Icons.contact_page_outlined,
                              size: 25,
                              color: Colors.orange,
                            ),
                            name: getTransrlate(context, 'Conditions'),
                            baseStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w800),
                            colorLineSelected: Colors.orange,
                          ),
                        ),
                        token == null
                            ? Container()
                            : InkWell(
                                onTap: () async {
                                  themeColor.setLogin(false);
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.clear();
                                  Phoenix.rebirth(context);
                                  _cart_model.setShipping(null);
                                  // Navigator.pushAndRemoveUntil(
                                  //     context, MaterialPageRoute(builder: (_) => LoginPage()), (r) => false);
                                },
                                child: ItemHiddenMenu(
                                  icon: Icon(
                                    Icons.exit_to_app,
                                    size: 19,
                                    color: Colors.orange,
                                  ),
                                  name: getTransrlate(context, 'Logout'),
                                  baseStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w800),
                                  colorLineSelected: Colors.orange,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xffF6F6F6),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(height: 1, color: Colors.grey),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            width: ScreenUtil.getWidth(context) / 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _launchURL('https://www.instagram.com/');
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/instagram.svg",
                                      color: Colors.blueGrey,
                                      width: 20,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURL('https://www.facebook.com/');
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/facebook.svg",
                                      color: Colors.blueGrey,
                                      width: 20,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _launchURL('https://twitter.com/');
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/twitter.svg",
                                      color: Colors.blueGrey,
                                      width: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      _launchURL(
                                          'https://frontend.lacasacode.dev/info/about');
                                    },
                                    child: AutoSizeText(
                                      getTransrlate(context, 'About'),
                                      maxLines: 1,
                                      minFontSize: 10,
                                      style: TextStyle(color: Colors.black),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      _launchURL(
                                          'https://frontend.lacasacode.dev/info/contact-us');
                                    },
                                    child: AutoSizeText(
                                      getTransrlate(context, 'contact'),
                                      maxLines: 1,
                                      minFontSize: 10,
                                      style: TextStyle(color: Colors.black),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      _launchURL(
                                          'https://frontend.lacasacode.dev/info/FAQs');
                                    },
                                    child: AutoSizeText(
                                      getTransrlate(context, 'FAQ'),
                                      maxLines: 1,
                                      minFontSize: 10,
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getTransrlate(context, 'version') + ' 1.0.0',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getTransrlate(context, "Copyright"),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
