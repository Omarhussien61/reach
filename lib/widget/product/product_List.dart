import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/account/start.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductList extends StatefulWidget {
  ProductList({
    Key key,
    @required this.themeColor,
    this.product,
    this.ctx,
  }) : super(key: key);

  final Provider_control themeColor;
  final Product product;
  final BuildContext ctx;
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool loading = false;
  bool wloading = false;
  String token;
  int userId;
  @override
  void initState() {
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
    final data = Provider.of<Provider_Data>(context);
    final themeColor = Provider.of<Provider_control>(context);

    return Container(
      //width: ScreenUtil.getWidth(context) / 2,
      margin: EdgeInsets.only(left: 16, top: 8, right: 12, bottom: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          widget.ctx == null ? null : Navigator.pop(widget.ctx);
          Nav.route(
              context,
              ProductPage(
                product: widget.product,
                product_id: widget.product.id.toString(),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 5.0,
                    spreadRadius: 1,
                    offset: Offset(0.0, 2)),
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4),
                    height: 100,
                    width: ScreenUtil.getWidth(context) / 4.5,
                    child: Image.network(
                      "${widget.product.image}",
                      errorBuilder: (context, url, error) => CachedNetworkImage(
                          imageUrl:
                              GlobalConfiguration().getString('base_url') +
                                  '${widget.product.image ?? ' '}'),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      //width: ScreenUtil.getWidth(context) / 1.7,
                      padding: EdgeInsets.only(left: 2, top: 5, right: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: ScreenUtil.getWidth(context) / 2,
                            child: AutoSizeText(
                              widget.product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF5D6A78),
                                fontWeight: FontWeight.w300,
                              ),
                              minFontSize: 14,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          SizedBox(
                            height: 5,
                          ),
                          // RatingBar.builder(
                          //   ignoreGestures: true,
                          //   initialRating:
                          //       widget.product.avgValuations.toDouble(),
                          //   itemSize: 14.0,
                          //   minRating: 0.5,
                          //   direction: Axis.horizontal,
                          //   allowHalfRating: true,
                          //   itemCount: 5,
                          //   itemBuilder: (context, _) => Icon(
                          //     Icons.star,
                          //     color: Colors.orange,
                          //   ),
                          //   onRatingUpdate: (rating) {
                          //     print(rating);
                          //   },
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              widget.product.salePrice == 'null'
                                  ? Container(
                                      width: ScreenUtil.getWidth(context) / 5,
                                      child: Text(
                                        "${widget.product.publicPrice ?? 0} ${getTransrlate(context, 'Currency')} ",
                                        maxLines: 1,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  : Container(
                                      width: ScreenUtil.getWidth(context) / 3.5,
                                      child: Row(
                                        children: [
                                          Text(
                                            "${widget.product.publicPrice ?? 0} ${getTransrlate(context, 'Currency')} ",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${widget.product.salePrice ?? 0} ",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.orange,
                                                fontSize: 10,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                              Expanded(
                                child: SizedBox(
                                  height: 6,
                                ),
                              ),
                              loading
                                  ? SizedBox(
                                      height: 20.0,
                                      width: 20.0,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.orange),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() => loading = true);

                                        API(context).post(
                                            'store/cart/${data.cart_model.id}/items/',
                                            {
                                              "product_id": widget.product.id,
                                              "quantity": 1
                                            }).then((value) {
                                          setState(() => loading = false);
                                          print(value);

                                          if (value != null) {
                                            if (!value.containsKey('detail')) {
                                              setState(() {});

                                              const snackBar = SnackBar(
                                                content: Text(
                                                  'تم اضافه المنتج الى عربة التسوق',
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Cairo'),
                                                ),
                                                backgroundColor: Colors.green,
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              data.getCart(context);
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
                                      },
                                      child: Icon(
                                        CupertinoIcons.cart,
                                        color: Colors.black,
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
                                        const snackBar = SnackBar(
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
                                        const snackBar = SnackBar(
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
                                        const snackBar = SnackBar(
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
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
