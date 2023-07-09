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
import 'package:global_configuration/global_configuration.dart';
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
                  imageUrl: widget.product.image??'',
                  fit: BoxFit.contain,
                    errorWidget:(context, url, error) =>CachedNetworkImage(
                        imageUrl: GlobalConfiguration().getString('base_url')+"${widget.product.image??' '}")
                ),
                Container(
                  color: Colors.white,
                  width: ScreenUtil.getWidth(context) / 2.1,
                  padding: EdgeInsets.only(left: 3, top: 10, right: 3,bottom: 10),
                  margin: EdgeInsets.only(left: 3, top: 10, right: 3,bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                     //   width: ScreenUtil.getWidth(context) / 4.2,
                        child: AutoSizeText(
                         widget.product.name,
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

                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
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


                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        widget.product.discount ? Container(
          color: themeColor.getColor(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("% ${widget.product.percentage}",style: TextStyle(color: Colors.white),),
          ),):Container(),

      ],
    );
  }
}
