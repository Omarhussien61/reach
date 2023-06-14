import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

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
  bool loading =false;
  bool wloading =false;

  @override
  void initState() {
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
          widget.ctx==null?null: Navigator.pop(widget.ctx);
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
              widget.product.producttypeId!=2?Container():Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffF2E964),
                  ),
                  padding: EdgeInsets.only(left: 16, top: 2, right: 12, bottom: 2),
                  child:Center(
                    child: Text(
                      "${getTransrlate(context, 'wholesale')} : ${widget.product.noOfOrders ?? ' '} ${getTransrlate(context, 'piece')} ",
                      style: TextStyle(color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,fontSize: 11),
                    ),
                  ) ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(4),
                    height: 100,
                    width: ScreenUtil.getWidth(context) / 4.5,
                    child: CachedNetworkImage(
                      imageUrl: widget.product.partCategoryName??'',
                      errorWidget: (context, url, error) => Icon(
                        Icons.image,
                        color: Colors.black12,
                      ),
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
                            width: ScreenUtil.getWidth(context) /2,

                            child: AutoSizeText(
                              themeColor.getlocal()=='ar'? widget.product.name??widget.product.nameEN :widget.product.nameEN??widget.product.name,
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
                          widget.product.tyres_belong != 1?Container():   Container(
                            width: ScreenUtil.getWidth(context) / 5.5,
                            child: Text(
                              "${widget.product.width ?? ''}/ ${widget.product.height ?? ''}/ ${widget.product.size ?? ''}",
                              maxLines: 1,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 12
                              ),
                            ),
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
                              widget.product.producttypeId == 2
                                  ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${getTransrlate(context, 'wholesalePrice')}  : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,fontSize: 11),
                                      ),
                                      Text(
                                        '${widget.product.holesalePrice ?? ' '} ${getTransrlate(context, 'Currency')} ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 11,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       "${getTransrlate(context, 'minOfOrder')}  : ",
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.w400,fontSize: 11),
                                  //     ),
                                  //     Text(
                                  //       '${widget.product.noOfOrders ?? ' '} ',
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.bold,fontSize: 11,
                                  //           color: Colors.black),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              )
                                  : Container(
                                  width: ScreenUtil.getWidth(context) /2.5,
                                  child: widget.product.discount == "0"
                                      ? AutoSizeText(
                                          "${widget.product.action_price} ${getTransrlate(context, 'Currency')} ",
                                          maxLines: 1,
                                          minFontSize: 14,
                                          maxFontSize: 16,
                                          style: TextStyle(
                                              color:
                                                  widget.themeColor.getColor(),
                                              fontWeight: FontWeight.w400),
                                        )
                                      : Row(
                                        children: [
                                          Container(
                                            width: ScreenUtil.getWidth(context) /7,

                                            child: Text(
                                                "${double.parse(widget.product.price).floorToDouble()}  ",
                                              style: TextStyle(
                                                decoration:  TextDecoration.lineThrough,
                                                fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                ),
                                              ),
                                          ),  Container(
                                            width: ScreenUtil.getWidth(context) /5,

                                            child: Text(
                                                "${widget.product.action_price?.floor()} ${getTransrlate(context, 'Currency')} ",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                ),
                                              ),
                                          ),
                                        ],
                                      )),
                              Expanded(
                                child: SizedBox(
                                  height: 6,
                                ),
                              ),
                              widget.product.inCart==1?   Icon(
                                CupertinoIcons.check_mark_circled,
                                size: 28,
                                color: Colors.black87,
                              ):   loading?
                              SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: CircularProgressIndicator(  valueColor:
                                AlwaysStoppedAnimation<Color>( Colors.orange),),
                              ):InkWell(
                                onTap: () {
                                  setState(() => loading = true);

                                  API(context).post('add/to/cart', {
                                    "product_id": widget.product.id,
                                    "quantity": widget.product.producttypeId==2?widget.product.noOfOrders: 1
                                  }).then((value) {
                                    setState(() => loading = false);

                                    if (value != null) {
                                      if (value['status_code'] == 200) {
                                        setState(() {
                                          widget.product.inCart=1;
                                        });
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                value['message']));
                                        data.getCart(context);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                value['errors']??value['message']));
                                      }
                                    }
                                  });
                                },
                                child:    Icon(
                                  CupertinoIcons.cart,
                                  color: Colors.black,
                                ),
                              ),
                              wloading?SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: CircularProgressIndicator(  valueColor:
                                AlwaysStoppedAnimation<Color>( Colors.orange),),
                              ):
                              IconButton(
                                onPressed: () {
                                  setState(() => wloading = true);
                                  widget.product.inWishlist == 0
                                      ? API(context).post('user/add/wishlist', {
                                          "product_id": widget.product.id
                                        }).then((value) {
                                    setState(() => wloading = false);

                                    if (value != null) {
                                            if (value['status_code'] == 200) {
                                              setState(() => wloading = false);

                                              data.getWishlist(context);

                                              setState(() {
                                                widget.product.inWishlist = 1;
                                              });
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => ResultOverlay(
                                                      value['message']));
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => ResultOverlay(
                                                      value['errors']));
                                            }
                                          }
                                        })
                                      : API(context).post(
                                          'user/removeitem/wishlist', {
                                          "product_id": widget.product.id
                                        }).then((value) {
                                    setState(() => wloading = false);

                                    if (value != null) {
                                            if (value['status_code'] == 200) {
                                              data.getWishlist(context);
                                              setState(() => wloading = false);
                                              setState(() {
                                                widget.product.inWishlist = 0;
                                              });
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => ResultOverlay(
                                                      value['message']));
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => ResultOverlay(
                                                      value['errors']));
                                            }
                                          }
                                        });
                                },
                                icon: Icon(
                                  widget.product.inWishlist == 0
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: Colors.grey,
                                ),
                              ),
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
