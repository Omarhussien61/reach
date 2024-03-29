import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_pos/screens/account/Account.dart';
import 'package:flutter_pos/screens/account/user_information.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/screens/order/cart.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/screens/splash_screen.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AppBarCustom extends StatefulWidget {
    bool isback ;
    String title ;
     AppBarCustom({this.isback=false,this.title});

  @override
  _AppBarCustomState createState() => _AppBarCustomState();

}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final _cart_model = Provider.of<Provider_Data>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(

        height: ScreenUtil.getHeight(context) / 12,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey),borderRadius: BorderRadius.circular(9)),
        margin: const EdgeInsets.only(top: 50,left: 10,right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           !widget.isback? IconButton(
              onPressed: () {
                Nav.route(context, Account());
              },
              icon: Icon(
                Icons.menu,
                size: 30,
                color: Colors.black,
              ),
              color: Color(0xffE4E4E4),
            ):IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
              ),
             color: Colors.black,
            ),
            SizedBox(width: 20,),
            widget.title!=null?
            Container(
             width: ScreenUtil.getWidth(context) / 4,
             child: AutoSizeText(
               '${widget.title}',
               maxLines: 2,
               maxFontSize: 15,
               minFontSize: 10,
               overflow: TextOverflow.ellipsis,
               style: TextStyle(color: Colors.black),
             ),
           ) :Center(
              child: InkWell(
                onTap: (){
                  Phoenix.rebirth(context);
                  },
                child: Image.asset(
                  'assets/images/logo.png',
                  height: ScreenUtil.getHeight(context) / 10,
                  width: ScreenUtil.getWidth(context) / 4,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(child: SizedBox(height: 10,)),
            IconButton(
              onPressed: () {
                Nav.route(context, Products_Page(Url:'samples_discount',name:"${getTransrlate(
                    context, 'offers')}" ,));
              },
              icon: Icon(
                Icons.local_offer_outlined,
                size: 40,
              ),
              color: Colors.orange,
            ),
            IconButton(
              onPressed: () {
                Nav.route(context, CartScreen());
              },
              icon:  badges.Badge(
                badgeContent:_cart_model.cart_model==null?Container(): Center(child: Text('${_cart_model.cart_model?.items?.length}',style: TextStyle(color: Colors.white))),
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.lightGreen),
                badgeAnimation: badges.BadgeAnimation.rotation(),
                showBadge: _cart_model.cart_model!=null,
                child: Icon(
                  Icons.shopping_cart,
                  size: 40,
                ),
              ),
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
