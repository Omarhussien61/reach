import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/screens/product/ProductPage.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:provider/provider.dart';

class Banner_item extends StatelessWidget {
  const Banner_item({Key key, this.item}) : super(key: key);
  final String item;
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return InkWell(
      onTap: (){
      //  Nav.route(context, Products_Page(name: 'عروض ',Url: 'best/seller/products?cartype_id=${themeColor.getcar_type()}'));
      },
      child: Container(
        width: ScreenUtil.getWidth(context)/1,

        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: CachedNetworkImage(
            imageUrl: item,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
