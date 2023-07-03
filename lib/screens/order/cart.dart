import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/address/Address_Page.dart';
import 'package:flutter_pos/screens/order/checkoutPage.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/Cart/product_cart.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/not_login.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../MyCars/myCars.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int checkboxType = 0;

  @override
  void initState() {
    Provider.of<Provider_Data>(context, listen: false).getCart(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final _cart_model = Provider.of<Provider_Data>(context);

    return Scaffold(
      bottomNavigationBar: _cart_model.cart_model == null
                  ? Container(
        height: 1,
        width: 1,
      ):_cart_model.cart_model.items.isEmpty
                  ? Container(
        height: 1,
        width: 1,
      ):
      Container(
                      height: 90,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {

                                pushNewScreen(
                                  context,
                                  screen: CheckOutPage(
                                    carts: _cart_model.cart_model,
                                  ),
                                  withNavBar: false, // OPTIONAL VALUE. True by default.
                                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                );
                                // Nav.route(
                                //     context,
                                //     CheckOutPage(
                                //       carts: _cart_model,
                                //     ));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 5),
                                padding: const EdgeInsets.all(12.0),
                                color: Colors.lightGreen,
                                child: Center(
                                    child: Text(
                                  getTransrlate(context, 'CheckOut'),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                              ),
                            ),
                            SizedBox(height: 10,)
                          ],
                        ),
                      ),
                    ),

      body: Column(
        children: [
          AppBarCustom(isback: true,),
          Expanded(
            child: SingleChildScrollView(
              child:Column(
                      children: [

                        _cart_model == null
                            ? Center(
                                child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Custom_Loading(),
                              ))
                            : _cart_model.cart_model == null
                                ? Container()
                                :_cart_model.cart_model == null
                                ? NotFoundProduct()
                                : SingleChildScrollView(
                                    child: _cart_model.cart_model.items.isEmpty
                                        ? NotFoundProduct()
                                        : Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '${getTransrlate(context, 'ShoppingCart')} (${_cart_model.cart_model.items.length})',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 22),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                    onTap: () {
                                                      Nav.route(context,
                                                          Shipping_Address());
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          color: Colors.orange,
                                                        ),
                                                        Container(
                                                            width: ScreenUtil
                                                                    .getWidth(
                                                                        context) /
                                                                1.3,
                                                            child: Text(
                                                              _cart_model.address==null?'${getTransrlate(context, 'NoSelect')}': '${getTransrlate(context, 'ShippingTo')}:${_cart_model.address.area==null?'':_cart_model.address.area.areaName??''},${_cart_model.address.city==null?'':_cart_model.address.city.cityName??''}.${_cart_model.address.street??''}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8,
                                                      horizontal: 35),
                                                  child: Container(
                                                    height: 1,
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                                ListView.builder(
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.all(1),
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: _cart_model.cart_model
                                                      .items.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return InkWell(
                                                      onTap: (){
                                                        Nav.route(context, ProductPage(product_id:_cart_model.cart_model.items[index].id.toString() ,));
                                                      },
                                                      child: ProductCart(
                                                          themeColor: themeColor,
                                                          carts: _cart_model.cart_model.items[index]),
                                                    );
                                                  },
                                                ),
                                                Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child: AutoSizeText(
                                                            getTransrlate(
                                                                context,
                                                                'total'),
                                                            maxLines: 1,
                                                            minFontSize: 20,
                                                            maxFontSize: 25,
                                                            style: TextStyle(
                                                                color: themeColor
                                                                    .getColor(),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        Container(
                                                          child: AutoSizeText(
                                                            " ${_cart_model.cart_model.grandTotal} ${getTransrlate(context, 'Currency')}",
                                                            maxLines: 1,
                                                            minFontSize: 20,
                                                            maxFontSize: 25,
                                                            style: TextStyle(
                                                                color: themeColor
                                                                    .getColor(),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8,
                                                      horizontal: 35),
                                                  child: Container(
                                                    height: 1,
                                                    color: Colors.black12,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                )
                                              ],
                                            ),
                                          ),
                                  )
                      ],
                    )

            ),
          ),
        ],
      ),
    );
  }
}
