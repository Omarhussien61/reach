import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/model/wishlist_model.dart';
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

class Wish_List extends StatefulWidget {
  Provider_control themeColor;
  Product product;
  Wish_List( this.themeColor, this.product);

  @override
  _Wish_ListState createState() => _Wish_ListState();
}

class _Wish_ListState extends State<Wish_List> {
 bool loading = false;
 bool dloading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Provider_Data>(context);
    final themeColor = Provider.of<Provider_control>(context);

    return InkWell(
      onTap: (){
        Nav.route(context, ProductPage(product: widget.product,product_id:widget.product.id.toString() ,));
      },
      child: Container(
        color: Colors.white,
        child: Row(

          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: ScreenUtil.getWidth(context) / 5,
              height: ScreenUtil.getHeight(context) / 6,
              child: CachedNetworkImage(
                imageUrl:widget.product.image,
                errorWidget: (context, url, error) => Icon(Icons.image,color: Colors.black12,),
              ),
            ),
            Expanded(
              child: Container(
                //width: ScreenUtil.getWidth(context) / 1.7,
                padding: EdgeInsets.only(left: 5, top: 10, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: ScreenUtil.getWidth(context) / 3,
                          height: 50,
                          child: AutoSizeText(
                            "${ widget.product.name}",
                            maxLines: 2,
                            style: TextStyle(
                              height: 1.5,
                              fontSize: 16,
                              color: Color(0xFF5D6A78),
                              fontWeight: FontWeight.w300,
                            ),
                            minFontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Container(
                                width: ScreenUtil.getWidth(context) / 5,
                                child: RatingBar.builder(
                                  ignoreGestures: true,
                                  initialRating: 5.0,
                                  itemSize: 14.0,
                                  minRating: 0.5,
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
                              ),
                            ),
                            Container(
                              width: ScreenUtil.getWidth(context) / 5,
                              child: AutoSizeText(
                                "${widget.product.publicPrice} ${getTransrlate(context, 'Currency')} ",
                                maxLines: 1,
                                minFontSize: 14,
                                maxFontSize: 16,
                                style: TextStyle(
                                    color: widget.themeColor.getColor(),
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                dloading?CircularProgressIndicator(  valueColor:
                AlwaysStoppedAnimation<Color>( Colors.orange),):IconButton(
                    onPressed: () {
                      setState(() => dloading = true);

                      API(context).post('user/removeitem/wishlist',
                          {"product_id": widget.product.id.toString()}).then((value) {
                        if (value != null) {
                          setState(() => dloading = false);

                          if (value['status_code'] == 200) {
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay(value['message']));
                           data.getWishlist(context);
                            data.getData(context);

                          } else {
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay('${value['message']??''}\n${value['errors']}'));
                          }
                        }
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    )),
                SizedBox(height: 25,),
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
                              builder: (_) =>
                                  ResultOverlay(value['message']));
                          Provider.of<Provider_Data>(context,listen: false).getCart(context);
                          API(context).post('user/removeitem/wishlist',
                              {"product_id": widget.product.id}).then((value) {
                            if (value != null) {
                              if (value['status_code'] == 200) {
                                data.getWishlist(context);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay('${value['message']??''}\n${value['errors']}'));
                              }
                            }
                          });
                        } else {
                          showDialog(
                              context: context,
                              builder: (_) =>
                                  ResultOverlay('${value['message']??value['errors']}'));
                        }
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(CupertinoIcons.cart, color: Colors.orange),
                        Container(
                          width: ScreenUtil.getWidth(context) / 5,
                          child: AutoSizeText(
                            '${getTransrlate(context, 'ADDtoCart')}',
                            minFontSize: 13,
                            maxFontSize: 13,
                            maxLines: 1,
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
            SizedBox(width: 2,),

          ],
        ),
      ),
    );
  }


}
