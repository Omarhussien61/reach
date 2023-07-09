import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:flutter_pos/widget/slider/slider_dotAds.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
class SubCategoryScreen extends StatefulWidget {
   SubCategoryScreen({Key key,this.Categories}) : super(key: key);
  Categories_item Categories;
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {

  List<Categories_item> Categories;
  int _carouselCurrentPage = 0;

  @override
  void initState() {
    API(context).get('store/subcategory/${widget.Categories.id}').then((value) {
      if (value != null) {
        setState(() {
          Categories = Categories_model.fromJson(value).data;

        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider_data = Provider.of<Provider_Data>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBarCustom(isback: true,title: widget.Categories.name,),
            provider_data.ads == null
                ? Container()
                : Padding(
              padding: EdgeInsets.only(top: 10),
              child: CarouselSlider(
                items: provider_data.ads.carousel
                    .map((item) => Banner_item(
                  item: item.photo,
                ))
                    .toList(),
                options: CarouselOptions(
                    height: ScreenUtil.getHeight(context) / 5,
                    aspectRatio: 16/9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _carouselCurrentPage = index;
                      });
                    }),
              ),
            ),
            provider_data.ads == null
                ? Container()
                : SliderDotAds(_carouselCurrentPage, provider_data.ads.carousel),
            Container(
              decoration: BoxDecoration(
                border: Border.symmetric(
                    vertical:
                    BorderSide(color: Colors.grey)),
              ),
              child: Container(
                color: Colors.white70,
                child: Categories == null
                    ? Center(child: Custom_Loading())
                    : Container(
                        child: SingleChildScrollView(
                          child: getList(Categories),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getList(List<Categories_item> Categories) {
    final themeColor = Provider.of<Provider_control>(context);
    final data = Provider.of<Provider_Data>(context);
    return Categories == null
        ? Container()
        : ResponsiveGridList(
        desiredItemWidth: ScreenUtil.getWidth(context) / 3.5,
        minSpacing: 10,
        //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
        scroll: false,
        children: Categories.map((e) =>
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: InkWell(
                onTap: () {
                  Nav.route(
                      context,
                      Products_Page(
                        id: e.id,
                        name:
                        "${themeColor.getlocal() == 'ar' ? e.name ??
                            e.nameEn : e.nameEn ?? e.name}",
                        Url:
                        'categories/${e.id}',
                        Istryers: e.id == 1711 || e.id == 682,
                        Category: true,
                        Category_id: e.id,
                      ));
                  //setState(() => categories[checkboxType].categories=e.categories);
                },
                child: Column(
                  children: [
                    Container(
                      width: ScreenUtil.getWidth(context) / 3.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5.0,
                                spreadRadius: 1,
                                offset: Offset(0.0, 2)),
                          ]

                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                        '${GlobalConfiguration().getString('base_url')}${e.photo != null ? e.photo : ''}',
                        errorWidget: (context, url, error) =>
                            Image.asset(
                              'assets/images/alt_img_category.png',
                            ),
                        height: ScreenUtil.getWidth(context) / 3.5,
                        width: ScreenUtil.getWidth(context) / 3.5,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: ScreenUtil.getWidth(context) / 3.5,
                      child: Text(
                        "${themeColor.getlocal() == 'ar' ? e.name ??
                            e.nameEn : e.nameEn ?? e.name}",
                        maxLines: 5,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18),
                      ),
                    ),

                  ],
                ),
              ),
            )).toList());
  }

}
