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

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int checkboxType = 0;
  int checkboxPart = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    final data = Provider.of<Provider_Data>(context);
    return Scaffold(
      body: Column(
        children: [
          AppBarCustom(),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: ScreenUtil.getHeight(context) / 1.25,
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                              vertical: BorderSide(color: Colors.grey)),
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            width: ScreenUtil.getWidth(context) / 2.5,
                            // height: ScreenUtil.getHeight(context) / 1.25,
                            child: Container(
                              child: ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                padding:
                                EdgeInsets.symmetric(horizontal: 2),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: data.categories
                                    .firstWhere((element) =>
                                element.id == themeColor.car_type)
                                    .categories
                                    .length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  bool selected = checkboxType == index;
                                  return item(data.categories
                                      .firstWhere((element) =>
                                  element.id == themeColor.car_type)
                                      .categories[index], index, selected);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: getList(data.categories
                              .firstWhere((element) =>
                          element.id == themeColor.car_type)
                              .categories),
                        ),
                      ),
                    ],
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
        : Categories[checkboxType].categories == null
        ? Container()
        : Categories[checkboxType].categories.isEmpty
        ? Container(
        child: NotFoundProduct(
          title: getTransrlate(context, 'EmptyCate'),
        ))
        : Column(
      children: [
        ResponsiveGridList(
            desiredItemWidth: ScreenUtil.getWidth(context) / 2,
            minSpacing: 10,
            //rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
            scroll: false,
            children: Categories[checkboxType].categories.map((e) =>
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: InkWell(
                    onTap: () {
                      e.categories.isNotEmpty
                          ? Nav.route(
                          context,
                          SubCategoryScreen(
                            Categories: e.categories,
                          ))
                          : Nav.route(
                          context,
                          Products_Page(
                            id: e.id,
                            name:
                            "${themeColor.getlocal() == 'ar' ? e.name ??
                                e.nameEn : e.nameEn ?? e.name}",
                            Url:
                            "ahmed/allcategories/products/${e.id}?cartype_id=${themeColor.car_type}",
                            Istryers: e.id == 1711 || e.id == 682,
                            Category: true,
                            Category_id: e.id,
                          ));
                      //setState(() => categories[checkboxType].categories=e.categories);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              height: 40,
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            width: ScreenUtil.getWidth(context) / 4,
                            child: Text(
                              "${themeColor.getlocal() == 'ar' ? e.name ??
                                  e.nameEn : e.nameEn ?? e.name}",
                              maxLines: 5,
                             // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 11),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Nav.route(
                                    context,
                                    Products_Page(
                                      id: e.id,
                                      name:
                                      "${themeColor.getlocal() == 'ar' ? e
                                          .name ?? e.nameEn : e.nameEn ??
                                          e.name}",
                                      Url:
                                      "ahmed/allcategories/products/${e.id}?cartype_id=${themeColor.car_type}",
                                      Istryers: e.id == 84,
                                      Category: true,
                                      Category_id: e.id,

                                    ));
                              },
                              icon: Icon(Icons.search, color: Color(0xffc8c8c8),))
                        ],
                      ),
                    ),
                  ),
                )).toList()),
        // ListView.builder(
        //     primary: false,
        //     shrinkWrap: true,
        //     padding: EdgeInsets.all(1),
        //     physics: NeverScrollableScrollPhysics(),
        //     itemCount: Categories.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       bool selected = checkboxPart == index;
        //       return Column(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(10),
        //             child:InkWell(
        //                 onTap: Categories[index].last_level == 0
        //                     ? null
        //                     : () {
        //                         Nav.route(
        //                             context,
        //                             Products_Page(
        //                               id: Categories[index].id,
        //                               name: Categories[index].name,
        //                               Url: "site/part/categories/${Categories[index].id}?cartype_id=${themeColor.getcar_type()}",
        //                               Istryers: Provider.of<Provider_Data>(context,listen: false).categories[checkboxType].id==7,
        //
        //                             ));
        //                       },
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.start,
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     Container(
        //                       width: ScreenUtil.getWidth(context)/3,
        //                       child: Text(
        //                         "${themeColor.getlocal()=='ar'? Categories[index].name??Categories[index].name_en :Categories[index].name_en??Categories[index].name}",
        //                         maxLines: 2,
        //                         textAlign: TextAlign.start,
        //                         style: TextStyle(fontWeight: FontWeight.w600,
        //                             fontSize: 12),
        //                       ),
        //                     ),
        //                     IconButton(onPressed: (){
        //                       Nav.route(
        //                           context,
        //                           Products_Page(
        //                             id:Categories[index].id,
        //                             name: "${ themeColor.getlocal()=='ar'?Categories[index].name??Categories[index].name_en :Categories[index].name_en??Categories[index].name}",
        //                             Url: 'site/categories/${Categories[index].id}?cartype_id=${themeColor.car_type}',
        //                             Istryers: Categories[index].id==84,
        //                             Category: true,
        //                           ));
        //                     }, icon: Icon(Icons.search))
        //                   ],
        //                 ),
        //               ),
        //           ),
        //           Container(
        //             height: 1,
        //             color: Colors.black12,
        //           )
        //         ],
        //       );
        //     },
        //   ),
        // SizedBox(height: 25,)
      ],
    );
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
