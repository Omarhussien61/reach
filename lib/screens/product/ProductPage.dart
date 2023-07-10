import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/question_model.dart';
import 'package:flutter_pos/model/review.dart';
import 'package:flutter_pos/screens/account/start.dart';
import 'package:flutter_pos/screens/order/cart.dart';
import 'package:flutter_pos/screens/product/photo.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/screens/product/Quastions.dart';
import 'package:flutter_pos/screens/product/ratepage.dart';
import 'package:flutter_pos/screens/product/writeQuastions.dart';
import 'package:flutter_pos/screens/product/writerate.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart' as intl;
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:share/share.dart';
import 'package:flutter_pos/widget/slider/slider_dot.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductPage extends StatefulWidget {
  ProductPage({Key key, this.product, this.product_id}) : super(key: key);
  Product product;
  final String product_id;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _carouselCurrentPage = 0;
  bool loading = false;
  String token;
  int userId;
  @override
  void initState() {
    print("like${ widget.product.like}");
    SharedPreferences.getInstance().then((prefs){
      setState(() {
        token=prefs.getString('token');
        userId=prefs.getInt('userID');
      });

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ServiceData = Provider.of<Provider_Data>(context);

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(isback: true),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: ScreenUtil.getHeight(context) / 2.5,
                    child: CachedNetworkImage(
                        imageUrl: widget.product.image??' ',errorWidget:(context, url, error) =>CachedNetworkImage(
                      imageUrl: GlobalConfiguration().getString('base_url')+'${widget.product.image??' '}') ,),
                  ),
                ),
                widget.product.like.isEmpty?
                IconButton(icon: Icon(Icons.favorite_border,size: 30,color: Colors.orange,),onPressed: (){
                  if(userId==null){
                    Nav.route(context, StartScreen());
                  }else
                  {
                    API(context).post(
                        'store/list_fav/${widget.product.id}/?token=${token}', {
                    }).then((value) {
                      print(value);

                      if (value != null) {
                        if (value.containsKey('data')) {
                          setState(() {
                            widget.product.like=value['data']['like'];
                          });
                          final snackBar = SnackBar(
                            content:  Text('تم اضافه المنتج الى المفضلة ',style: TextStyle(color: Colors.white,fontFamily: 'Cairo'),),

                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {

                        }
                      }
                    });
                  }

                },):
                widget.product.like.where((element) => element==userId).isNotEmpty?
                IconButton(icon: Icon(Icons.favorite,size: 30,color: Colors.orange,),onPressed: (){
                  if(userId==null){
                    Nav.route(context, StartScreen());
                  }else
                  {
                    API(context).post(
                        'store/list_fav/${widget.product.id}/?token=${token}', {
                    }).then((value) {
                      print(value);

                      if (value != null) {
                        if (value.containsKey('data')) {
                          setState(() {
                            widget.product.like=value['data']['like'];
                          });
                          final snackBar = SnackBar(
                            content:  Text('تم ازالة المنتج من المفضلة ',style: TextStyle(color: Colors.white,fontFamily: 'Cairo'),),

                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) => ResultOverlay(
                                  '${value['message'] ?? ''}\n${value['detail'] ?? ""}',
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.yellow,
                                    size: 80,
                                  )));
                        }
                      }
                    });
                  }

                },):
                IconButton(icon: Icon(Icons.favorite_border,size: 30,color: Colors.orange,),onPressed: (){
                  if(userId==null){
                    Nav.route(context, StartScreen());
                  }else
                  {
                    API(context).post(
                        'store/list_fav/${widget.product.id}/?token=${token}', {
                    }).then((value) {
                      print(value);

                      if (value != null) {
                        if (value.containsKey('data')) {
                          setState(() {
                            widget.product.like=value['data']['like'];
                          });
                          final snackBar = SnackBar(
                            content:  Text('تم اضافه المنتج الى المفضلة ',style: TextStyle(color: Colors.white,fontFamily: 'Cairo'),),

                            backgroundColor: Colors.green,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) => ResultOverlay(
                                  '${value['message'] ?? ''}\n${value['detail'] ?? ""}',
                                  icon: Icon(
                                    Icons.info_outline,
                                    color: Colors.yellow,
                                    size: 80,
                                  )));
                        }
                      }
                    });
                  }

                },)
              ],
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("الشركة   : ${widget.product.company.name}"),
                  Text("المادة الفعالة     : ${widget.product.effectiveMaterial}"),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${widget.product.name}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "السعر :",
                  style: TextStyle(color: Colors.blue),
                ),
                widget.product.salePrice=='null' ? Container(
                  width: ScreenUtil.getWidth(context) / 5,
                  child: Text(
                    "${widget.product.publicPrice??0} ${getTransrlate(context, 'Currency')} ",
                    maxLines: 1,

                    style: TextStyle(
                        color:Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ) :Container(
                  width: ScreenUtil.getWidth(context) / 3,
                  child: Row(
                    children: [
                      Text(
                        "${widget.product.publicPrice??0} ${getTransrlate(context, 'Currency')} ",
                        maxLines: 1,

                        style: TextStyle(
                            color:Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${widget.product.salePrice??0} ",
                        maxLines: 1,
                        style: TextStyle(
                            color:Colors.orange,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            loading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  )
                : Center(
                    child: TextButton(
                      style: getStyleButton(Colors.orange),
                      onPressed: () {
                        
                        if(ServiceData.cart_model==null){
                          Nav.route(context, StartScreen());
                        }else{
                          setState(() => loading = true);
                          API(context).post(
                              'store/cart/${ServiceData.cart_model.id}/items/', {
                            "product_id": widget.product.id,
                            "quantity": 1
                          }).then((value) {
                            setState(() => loading = false);
                            print(value);

                            if (value != null) {
                              if (!value.containsKey('detail')) {
                                setState(() {
                                });

                                final snackBar = SnackBar(
                                  content:  Text('تم اضافه المنتج الى عربة التسوق',style: TextStyle(color: Colors.white,fontFamily: 'Cairo'),),

                                  backgroundColor: Colors.green,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                ServiceData.getCart(context);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) => ResultOverlay(
                                        '${value['message'] ?? ''}\n${value['detail'] ?? ""}',
                                        icon: Icon(
                                          Icons.info_outline,
                                          color: Colors.yellow,
                                          size: 80,
                                        )));
                              }
                            }
                          });
                        }
                       
                      },
                      child: Container(
                          width: ScreenUtil.getWidth(context) / 1.2,
                          height: 30,
                          child: Center(
                              child: Text(
                            getTransrlate(context, 'ADDtoCart'),
                            style: TextStyle(color: Colors.white),
                          ))),
                    ),
                  ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 150,
              width: ScreenUtil.getWidth(context),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "المواصفات :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "${widget.product.description}"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 150,
              width: ScreenUtil.getWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black12),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الاستخدام :",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        "${widget.product.usage}"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    ));
  }
}
