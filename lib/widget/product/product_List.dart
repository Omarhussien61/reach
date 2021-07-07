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
  const ProductList({
    Key key,
    @required this.themeColor,
    this.product,
  }) : super(key: key);

  final Provider_control themeColor;
  final Product product;

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Provider_Data>(context);

    return Stack(
      children: <Widget>[
        Container(
          //width: ScreenUtil.getWidth(context) / 2,
          margin: EdgeInsets.only(left: 16, top: 8, right: 12, bottom: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () {
              Nav.route(
                  context,
                  ProductPage(
                    product: widget.product,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    height: 100,
                    width: ScreenUtil.getWidth(context) / 4.5,
                    child: CachedNetworkImage(
                      imageUrl: (widget.product.photo.isEmpty)
                          ? 'http://arabimagefoundation.com/images/defaultImage.png'
                          : widget.product.photo[0].image,
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
                          AutoSizeText(
                            widget.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF5D6A78),
                              fontWeight: FontWeight.w300,
                            ),
                            minFontSize: 14,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating:
                                widget.product.avgValuations.toDouble(),
                            itemSize: 14.0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.orange,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
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
                                        "سعر الجملة  : ",
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
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "الحد الادنى للطلب  : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,fontSize: 11),
                                      ),
                                      Text(
                                        '${widget.product.noOfOrders ?? ' '} ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,fontSize: 11,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                                  : Container(
                                  width: ScreenUtil.getWidth(context) /3,
                                  child: widget.product.discount == 0
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
                                          Text(
                                              "${widget.product.price}  ",
                                            style: TextStyle(
                                              decoration:  TextDecoration.lineThrough,
                                              fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                              ),
                                            ),  Text(
                                              "${widget.product.action_price} ${getTransrlate(context, 'Currency')} ",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                        ],
                                      )),
                              Expanded(
                                child: SizedBox(
                                  height: 6,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  API(context).post('add/to/cart', {
                                    "product_id": widget.product.id,
                                    "quantity": 1
                                  }).then((value) {
                                    if (value != null) {
                                      if (value['status_code'] == 200) {
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                value['message']));
                                        data.getCart(context);
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (_) => ResultOverlay(
                                                value['message']));
                                      }
                                    }
                                  });
                                },
                                child: Icon(
                                  CupertinoIcons.cart,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  print(
                                      "  FFFFFFFFFFFFFFFFFFFFFF   ${widget.product.inWishlist}");
                                  widget.product.inWishlist == 0
                                      ? API(context).post('user/add/wishlist', {
                                          "product_id": widget.product.id
                                        }).then((value) {
                                          if (value != null) {
                                            if (value['status_code'] == 200) {
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
                                                      value['message']));
                                            }
                                          }
                                        })
                                      : API(context).post(
                                          'user/removeitem/wishlist', {
                                          "product_id": widget.product.id
                                        }).then((value) {
                                          if (value != null) {
                                            if (value['status_code'] == 200) {
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
                                                      value['message']));
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
            ),
          ),
        ),
      ],
    );
  }

  bool onLikeTapped() {
    // API(context)
    //     .post('wishlist', {"product_id": widget.product.id}).then((value) => {
    //           if (value['status'] != 'error')
    //             {
    //               setState(() {
    //                 widget.product.w = false;
    //               }),
    //               Scaffold.of(context).showSnackBar(SnackBar(
    //                   backgroundColor: mainColor,
    //                   content: Text(value['message'])))
    //             }
    //           else
    //             {
    //               setState(() {
    //                 widget.product.is_wishlisted = true;
    //               }),
    //               Scaffold.of(context).showSnackBar(SnackBar(
    //                   backgroundColor: mainColor,
    //                   content: Text(value['message'])))
    //             }
    //         });
  }
}
