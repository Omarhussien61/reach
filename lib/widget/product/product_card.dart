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

class ProductCard extends StatefulWidget {
  const ProductCard({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final Provider_control themeColor;
  final Product product;

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool loading=false;
  bool wloading=false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ServiceData = Provider.of<Provider_Data>(context);
    final themeColor = Provider.of<Provider_control>(context);

    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            Nav.route(
                context,
                ProductPage(
                  product: widget.product,
                  product_id: widget.product.id.toString()
                ));
          },
          child: Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 5.0,
                  spreadRadius: 1,
                  offset: Offset(0.0, 2)),
            ],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                CachedNetworkImage(
                  width: ScreenUtil.getWidth(context) / 2,
                  height: ScreenUtil.getHeight(context) / 5,
                  imageUrl: (widget.product.photo.isEmpty)
                      ? 'http://arabimagefoundation.com/images/defaultImage.png'
                      : widget.product.photo[0].image,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => Icon(
                    Icons.image,
                    color: Colors.black12,
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: ScreenUtil.getWidth(context) / 2.1,
                  padding: EdgeInsets.only(left: 3, top: 10, right: 3,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                     //   width: ScreenUtil.getWidth(context) / 4.2,
                        child: AutoSizeText(
                          themeColor.getlocal()=='ar'? widget.product.name??widget.product.nameEN :widget.product.nameEN??widget.product.name,
                          maxLines: 2,
                          style: TextStyle(
                            color: Color(0xFF5D6A78),
                            fontWeight: FontWeight.w500,
                          ),
                          minFontSize: 13,
                          maxFontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      widget.product.tyres_belong != 1?Container(
                        width: ScreenUtil.getWidth(context) / 5.5,
                        child: Text(
                          "",
                          maxLines: 1,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w300,
                              fontSize: 12
                          ),
                        ),
                      ):   Container(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          // Container(
                          //   width: 75,
                          //   child: RatingBar.builder(
                          //     ignoreGestures: true,
                          //     initialRating:
                          //         widget.product.avgValuations.toDouble(),
                          //     itemSize: ScreenUtil.getWidth(context) / 40,
                          //     minRating: 0.5,
                          //     direction: Axis.horizontal,
                          //     allowHalfRating: true,
                          //     itemCount: 5,
                          //     itemBuilder: (context, _) => Icon(
                          //       Icons.star,
                          //       color: Colors.orange,
                          //     ),
                          //     onRatingUpdate: (rating) {},
                          //   ),
                          // ),
                        Container(
                          width: ScreenUtil.getWidth(context) / 5,
                          child: Text(
                            "${widget.product.action_price??0} ${getTransrlate(context, 'Currency')} ",
                            maxLines: 1,

                            style: TextStyle(
                                color:Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                          SizedBox(width: 50,)
                        ],
                      ),
                      widget.product.producttypeId == 2
                          ?  Container(child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          " ",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),)
                          : Container(
                        //  width: ScreenUtil.getWidth(context) / 4,
                          child: widget.product.discount == "0"
                              ? Container(child:  Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              " ",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),)
                              : Container(

                                // width: ScreenUtil.getWidth(context) / 2,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                   children: [
                                    SizedBox(width: 10,),

                                     Padding(
                                       padding: const EdgeInsets.symmetric(horizontal: 5),
                                       child: Text(
                                         " ${widget.product.price} ",
                                         style: TextStyle(
                                           decoration: TextDecoration.lineThrough,
                                           fontSize: 12,
                                           fontWeight: FontWeight.w400,
                                           color: Colors.red,
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               )),
                      widget.product.inCart==1?   Icon(
                        CupertinoIcons.check_mark_circled,
                        size: 28,
                        color: Colors.black87,
                      ): loading?CircularProgressIndicator(  valueColor:
                      AlwaysStoppedAnimation<Color>( Colors.orange),): Center(
                        child: TextButton(
                          style:getStyleButton( Colors.orange),

                          onPressed: () {
                            setState(() => loading = true);

                            API(context).post('add/to/cart', {
                              "product_id": widget.product.id,
                              "quantity": widget.product.producttypeId==2?widget.product.noOfOrders: 1
                            }).then((value) {
                              setState(() => loading = false);

                              if (value != null) {
                                print(value);

                                if (value['status_code'] == 200) {
                                  setState(() {
                                    widget.product.inCart=1;
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ResultOverlay(value['message'],
                                              icon: Icon(
                                                Icons.check_circle_outline,
                                                color: Colors.green,
                                                size: 80,

                                              )));
                                  ServiceData.getCart(context);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (_) => ResultOverlay(
                                          '${value['message'] ?? ''}\n${value['errors'] ?? ""}',
                                          icon: Icon(
                                            Icons.info_outline,
                                            color: Colors.yellow,
                                            size: 80,
                                          )));
                                }
                              }
                            });
                          },
                          child: Text(getTransrlate(context, 'ADDtoCart'),style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        widget.product.producttypeId!=2?Container():Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            color: Color(0xffF2E964),
          ),
            child:Center(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child:Text(
              "${getTransrlate(context, 'wholesale')} : ${widget.product.noOfOrders ?? ' '} ${getTransrlate(context, 'piece')} ",
              style: TextStyle(color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,fontSize: 11),
            ),
          ),
        ) )
      ],
    );
  }
}
