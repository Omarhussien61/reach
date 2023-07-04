import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/model/category_model.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/screens/product/sub_category.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({Key key}) : super(key: key);

  @override
  _CompaniesScreenState createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  int checkboxType = 0;
  int checkboxPart = 0;
  List<Categories_item> categories;

  @override
  void initState() {
    API(context).get('companies').then((value) {
      if (value != null) {
        print(value);
setState(() {
  categories = Categories_model.fromJson(value).data;

});      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final data = Provider.of<Provider_Data>(context);
    return Scaffold(
      body: Column(
        children: [
          AppBarCustom(isback: true,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border:
                Border.symmetric(vertical: BorderSide(color: Colors.grey)),
              ),
              child: Container(
                color: Colors.white70,
                child: data.categories == null
                    ? Center(child: Custom_Loading())
                    : Container(
                  child: SingleChildScrollView(
                    child: getList(categories),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getList(List<Categories_item> Categories) {
    final themeColor = Provider.of<Provider_control>(context);
    final data = Provider.of<Provider_Data>(context);
    return Categories == null
        ? Container()
        : ResponsiveGridList(
            desiredItemWidth: ScreenUtil.getWidth(context) / 2.2,
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
                            'companies/${e.id}',
                            Istryers: e.id == 1711 || e.id == 682,
                            Category: true,
                            Category_id: e.id,
                          ));
                      //setState(() => categories[checkboxType].categories=e.categories);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: ScreenUtil.getWidth(context) / 2.5,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: CachedNetworkImage(
                              imageUrl:
                              '${e.photo != null ? e.photo : ''}',
                              errorWidget: (context, url, error) =>
                                  Image.asset(
                                    'assets/images/alt_img_category.png',
                                  ),
                              height: ScreenUtil.getWidth(context) / 2.5,
                              width: ScreenUtil.getWidth(context) / 2.5,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            width: ScreenUtil.getWidth(context) / 2.5,
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
                          // IconButton(
                          //     onPressed: () {
                          //       Nav.route(
                          //           context,
                          //           Products_Page(
                          //             id: e.id,
                          //             name:
                          //             "${themeColor.getlocal() == 'ar' ? e
                          //                 .name ?? e.nameEn : e.nameEn ??
                          //                 e.name}",
                          //             Url:
                          //             "ahmed/allcategories/products/${e.id}?cartype_id=${themeColor.car_type}",
                          //             Istryers: e.id == 84,
                          //             Category: true,
                          //             Category_id: e.id,
                          //
                          //           ));
                          //     },
                          //     icon: Icon(Icons.search, color: Color(0xffc8c8c8),))
                        ],
                      ),
                    ),
                  ),
                )).toList());
  }

  item(Categories_item categories_item, int index, bool selected) {
    final themeColor = Provider.of<Provider_control>(context);
    return InkWell(
      onTap: () {
        categories_item.categories.isEmpty ? Nav.route(
            context,
            Products_Page(
              id: categories_item.id,
              name:
              "${themeColor.getlocal() == 'ar' ? categories_item.name ??
                  categories_item.nameEn : categories_item.nameEn ??
                  categories_item.name}",
              Url:
              "ahmed/allcategories/products/${categories_item.id}?cartype_id=${themeColor.car_type}",
              Istryers: categories_item.id == 1711 || categories_item.id == 682,
              Category: true,
              Category_id: categories_item.id,
            )) : setState(() {
          checkboxType = index;
          checkboxPart = 0;
          // categories= data.categories;
        });
      },
      child: Container(
        height:
        ScreenUtil.getHeight(context) /
            10,

        decoration: BoxDecoration(
            color: !selected
                ? Colors.white
                : Color(0xffF6F6F6),
            border: Border.symmetric(
                horizontal: BorderSide(
                    color: selected
                        ? Colors.black12
                        : Colors.black26))),
        child: Row(
          children: [
            Container(
                height:
                ScreenUtil.getHeight(
                    context) / 10,
                width: 8,
                color: !selected
                    ? Colors.white
                    : Colors.orange),
            SizedBox(
              width: 2,
            ),
            Container(
              width: ScreenUtil.getWidth(context) / 4.3,

              child: Text(
                "${themeColor.getlocal() == 'ar' ? categories_item.name ??
                    categories_item.nameEn : categories_item.nameEn ??
                    categories_item.name}",
                maxLines: 2,
                overflow:
                TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            IconButton(
                onPressed: () {
                  Nav.route(
                      context,
                      Products_Page(
                        id: categories_item.id,
                        name:
                        "${themeColor.getlocal() == 'ar' ? categories_item
                            .name ?? categories_item.nameEn : categories_item
                            .nameEn ?? categories_item.name}",
                        Url:
                        "ahmed/allcategories/products/${categories_item.id}?cartype_id=${themeColor.car_type}",
                        Istryers: categories_item.id == 1711 ||
                            categories_item.id == 682,
                        Category: true,
                        Category_id: categories_item.id,
                      ));
                },
                icon: Icon(Icons.search,color: Color(0xffc8c8c8),))
          ],
        ),
      ),
    );
  }
}
