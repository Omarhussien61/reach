import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/question_model.dart';
import 'package:flutter_pos/model/review.dart';
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
import 'package:intl/intl.dart' as intl;
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:share/share.dart';
import 'package:flutter_pos/widget/slider/slider_dot.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../MyCars/myCars.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key, this.product, this.product_id}) : super(key: key);
  Product product;
  final String product_id;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _carouselCurrentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
      children: [
          AppBarCustom(isback: true),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: ScreenUtil.getHeight(context) / 2.5,
              child: CachedNetworkImage(imageUrl: widget.product.photo[0].image),
            ),
          ),
          Container(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("الشركة   : بيزلين"),
              Text("المادة الفعالة     : بيزلين"),
            ],
          ),),
          SizedBox(height: 20,),
          Text("بيزلين | رول أون مزيل العرق للرجال سوبر دراي | 50 مل",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          SizedBox(height: 20,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("السعر :",style: TextStyle(color: Colors.blue),),
              Text(" 149 جنية"),
            ],
          ),
          SizedBox(height: 20,),
      ],
    ),
        ));
  }
}
