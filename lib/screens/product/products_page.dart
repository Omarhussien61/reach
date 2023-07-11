import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/model/manufacturers.dart';
import 'package:flutter_pos/model/origins.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/product/Filter.dart';
import 'package:flutter_pos/screens/product/Sort.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/widget/List/gridview.dart';
import 'package:flutter_pos/widget/List/listview.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/no_found_product.dart';
import 'package:provider/provider.dart';

class Products_Page extends StatefulWidget {
  int id;
  String name;
  String Url;
  bool Istryers = false;
  bool Category = false;
  int Category_id;

  Products_Page(
      {this.id,
      this.name,
      this.Url,
      this.Istryers = false,
      this.Category_id,
      this.Category = false});

  @override
  _Products_PageState createState() => _Products_PageState();
}

class _Products_PageState extends State<Products_Page> {
  List<Product> product;
  bool list = false;
  final _formKey = GlobalKey<FormState>();
  String url;
  String Filtration;
  String sort = 'ASC&ordered_by=price';
  RangeValues _currentRangeValues;
  double min = 1, max = 10000;
  double filterPrice;
  double minPrice;
  List<Origin> origin;
  List<Manufacturer> manufacturer;
  List<int> partSelect = [];
  List<int> originSelect = [];
  List<int> manufacturerSelect = [];
  List<String> width = [];
  List<String> height = [];
  List<String> size = [];
  List<Categories_item> categories;
  String widthID;
  String heightID;
  String sizeID;
  ExpandableController tayrsController =
      ExpandableController(initialExpanded: true);

  @override
  void initState() {
    url = widget.Url;
    _currentRangeValues = RangeValues(min, max);
    widget.Category ? getDataCategory() : getData();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Provider_Data>(context);
    final themeColor = Provider.of<Provider_control>(context);
    return Scaffold(
      body: Column(
        children: [
          AppBarCustom(
            isback: true,
            title: widget.name,
          ),
          SizedBox(height: 10,),
          product == null
              ? Container()
              : Container(
                  color: Colors.black26,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            list ? list = false : list = true;
                          });
                        },
                        icon: Icon(
                          list
                              ? Icons.table_rows_outlined
                              : Icons.apps_outlined,
                          color: Colors.black45,
                          size: 25,
                        ),
                        // color: Color(0xffE4E4E4),
                      ),
                      Text(
                          '${product.length} ${getTransrlate(context, 'product')} '),
                      // InkWell(
                      //   onTap: () {
                      //     // partSelect = [];
                      //     // originSelect = [];
                      //     // manufacturerSelect = [];
                      //     if (manufacturer.isNotEmpty) {
                      //       manufacturerSelect.forEach((element) {
                      //         manufacturer
                      //             .firstWhere((e) => e.id == element,
                      //                 orElse: () => Manufacturer())
                      //             .check = true;
                      //       });
                      //     }
                      //     if (origin.isNotEmpty) {
                      //       originSelect.forEach((element) {
                      //         origin
                      //             .firstWhere((e) => e.id == element,
                      //                 orElse: () => Origin())
                      //             .check = true;
                      //       });
                      //     }
                      //
                      //     if (categories.isNotEmpty) {
                      //       partSelect.forEach((element) {
                      //         categories
                      //             .firstWhere((e) => e.id == element,
                      //                 orElse: () => Categories_item())
                      //             .Check = true;
                      //       });
                      //     }
                      //     showDialog(
                      //         context: context,
                      //         builder:
                      //             (_) => StatefulBuilder(builder:
                      //                     (context, StateSetter setState) {
                      //                   return Material(
                      //                     child: Form(
                      //                       key: _formKey,
                      //                       child: Column(
                      //                         children: [
                      //                           Container(
                      //                             padding: EdgeInsets.only(
                      //                                 bottom: 4),
                      //                             height: 72,
                      //                             decoration: BoxDecoration(
                      //                               border: Border.all(
                      //                                   color: Colors.grey),
                      //                               color: Color(0xffCCCCCC),
                      //                             ),
                      //                             child: Padding(
                      //                               padding:
                      //                                   const EdgeInsets.only(
                      //                                 bottom: 8,
                      //                                 top: 8,
                      //                                 left: 24,
                      //                                 right: 24,
                      //                               ),
                      //                               child: Row(
                      //                                 mainAxisAlignment:
                      //                                     MainAxisAlignment
                      //                                         .spaceBetween,
                      //                                 children: [
                      //                                   Text(
                      //                                     '${getTransrlate(context, 'filter')}',
                      //                                     style: TextStyle(
                      //                                         fontSize: 20,
                      //                                         fontWeight:
                      //                                             FontWeight
                      //                                                 .w500,
                      //                                         color: Color(
                      //                                             0xff7B7B7B)),
                      //                                   ),
                      //                                   IconButton(
                      //                                       icon: Icon(
                      //                                           Icons.close,
                      //                                           size: 30,
                      //                                           color: Color(
                      //                                               0xff7B7B7B)),
                      //                                       onPressed: () {
                      //                                         Navigator.pop(
                      //                                             context, "1"
                      //                                             // "part_categories:[],manufacturers:[],origins: [],"
                      //                                             //"start_price": [],
                      //                                             //  "end_price": [],
                      //                                             );
                      //                                       })
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                           SizedBox(
                      //                             height: ScreenUtil.getHeight(
                      //                                     context) /
                      //                                 1.4,
                      //                             child: SingleChildScrollView(
                      //                               child: Column(
                      //                                 children: [
                      //                                   widget.Istryers
                      //                                       ? Container(
                      //                                           decoration:
                      //                                               BoxDecoration(
                      //                                             border: Border.all(
                      //                                                 color: Colors
                      //                                                     .black12),
                      //                                           ),
                      //                                           child: Padding(
                      //                                             padding:
                      //                                                 const EdgeInsets
                      //                                                     .only(
                      //                                               bottom: 8, top: 8,
                      //                                               left: 24, right: 24,
                      //                                             ),
                      //                                             child:
                      //                                                 ExpandablePanel(
                      //                                               controller:
                      //                                                   tayrsController,
                      //                                               header:
                      //                                                   Text(
                      //                                                 '${getTransrlate(context, 'frameDimensions')}',
                      //                                                 style: TextStyle(
                      //                                                     fontWeight:
                      //                                                         FontWeight.bold),
                      //                                               ),
                      //                                               expanded:
                      //                                                   Padding(
                      //                                                 padding: const EdgeInsets.all(8.0),
                      //                                                     child: Container(
                      //                                                   height:
                      //                                                       ScreenUtil.getHeight(context) /
                      //                                                           3,
                      //                                                   width: ScreenUtil.getWidth(
                      //                                                       context),
                      //                                                   child:
                      //                                                       Stack(
                      //                                                     children: [
                      //                                                       Positioned(
                      //                                                         right: 1,
                      //                                                         child: Container(
                      //                                                           width: ScreenUtil.getWidth(context) / 2.5,
                      //                                                           child: Column(
                      //                                                             children: [
                      //                                                               Padding(
                      //                                                                 padding: const EdgeInsets.all(8.0),
                      //                                                                 child: DropdownSearch<String>(
                      //                                                                   label: " ${getTransrlate(context, 'width')} ",
                      //                                                                   showSearchBox: true,
                      //                                                                   selectedItem: widthID,
                      //                                                                   showClearButton: false,
                      //                                                                   mode: Mode.MENU,
                      //                                                                   items: width,
                      //                                                                   validator: (String item) {
                      //                                                                     if (item == null) {
                      //                                                                       return "${getTransrlate(context, 'width')}";
                      //                                                                     } else
                      //                                                                       return null;
                      //                                                                   },
                      //
                      //                                                                   onChanged: (String item) {
                      //                                                                     widthID = item;
                      //                                                                   },
                      //                                                                   //  onFind: (String filter) => getData(filter),
                      //                                                                 ),
                      //                                                               ),
                      //                                                               SizedBox(
                      //                                                                 height: 10,
                      //                                                               ),
                      //                                                               Padding(
                      //                                                                 padding: const EdgeInsets.all(8.0),
                      //                                                                 child: DropdownSearch<String>(
                      //                                                                   label: " ${getTransrlate(context, 'height')} ",
                      //                                                                   showSearchBox: true,
                      //                                                                   showClearButton: false,
                      //                                                                   selectedItem: heightID,
                      //                                                                   mode: Mode.MENU,
                      //
                      //                                                                   items: height,
                      //                                                                   validator: (String item) {
                      //                                                                     if (item == null) {
                      //                                                                       return "${getTransrlate(context, 'height')}";
                      //                                                                     } else
                      //                                                                       return null;
                      //                                                                   },
                      //                                                                   onChanged: (String item) {
                      //                                                                     heightID = item;
                      //                                                                   },
                      //                                                                   //  onFind: (String filter) => getData(filter),
                      //                                                                 ),
                      //                                                               ),
                      //                                                               SizedBox(
                      //                                                                 height: 10,
                      //                                                               ),
                      //                                                               Padding(
                      //                                                                 padding: const EdgeInsets.all(8.0),
                      //                                                                 child: DropdownSearch<String>(
                      //                                                                   label: " ${getTransrlate(context, 'size')} ",
                      //                                                                   showSearchBox: true,
                      //                                                                   showClearButton: false,
                      //                                                                   selectedItem: sizeID,
                      //                                                                   mode: Mode.MENU,
                      //                                                                   items: size,
                      //                                                                   validator: (String item) {
                      //                                                                     if (item == null) {
                      //                                                                       return "${getTransrlate(context, 'size')}";
                      //                                                                     } else
                      //                                                                       return null;
                      //                                                                   },
                      //                                                                   onChanged: (String item) {
                      //                                                                     sizeID = item;
                      //                                                                   },
                      //                                                                   //  onFind: (String filter) => getData(filter),
                      //                                                                 ),
                      //                                                               ),
                      //                                                             ],
                      //                                                           ),
                      //                                                         ),
                      //                                                       ),
                      //                                                       Positioned(
                      //                                                         left: 1,
                      //                                                         child: Image.asset(
                      //                                                           'assets/images/tire.png',
                      //                                                           width: ScreenUtil.getWidth(context) / 2.5,
                      //                                                         ),
                      //                                                       )
                      //                                                     ],
                      //                                                   ),
                      //                                                 ),
                      //                                               ),
                      //                                             ),
                      //                                           ),
                      //                                         )
                      //                                       : widget.Category
                      //                                           ? Container(
                      //                                               decoration:
                      //                                                   BoxDecoration(
                      //                                                 border: Border.all(
                      //                                                     color:
                      //                                                         Colors.black12),
                      //                                               ),
                      //                                               child:
                      //                                                   Padding(
                      //                                                 padding:
                      //                                                     const EdgeInsets
                      //                                                         .only(
                      //                                                   bottom:
                      //                                                       8,
                      //                                                   top: 8,
                      //                                                   left:
                      //                                                       24,
                      //                                                   right:
                      //                                                       24,
                      //                                                 ),
                      //                                                 child:
                      //                                                     ExpandablePanel(
                      //                                                   header:
                      //                                                       Text(
                      //                                                     '${getTransrlate(context, 'category')}',
                      //                                                     style:
                      //                                                         TextStyle(fontWeight: FontWeight.bold),
                      //                                                   ),
                      //                                                   expanded:
                      //                                                       Padding(
                      //                                                     padding:
                      //                                                         const EdgeInsets.all(16.0),
                      //                                                     child: categories == null
                      //                                                         ? Custom_Loading()
                      //                                                         : categories.isEmpty
                      //                                                             ? Container()
                      //                                                             : ListView.builder(
                      //                                                                 primary: false,
                      //                                                                 shrinkWrap: true,
                      //                                                                 physics: NeverScrollableScrollPhysics(),
                      //                                                                 itemCount: categories.length,
                      //                                                                 itemBuilder: (BuildContext context, int index) {
                      //                                                                   return Row(
                      //                                                                     children: [
                      //                                                                       Checkbox(
                      //                                                                           value: categories[index].Check,
                      //                                                                           activeColor: Colors.orange,
                      //                                                                           onChanged: (value) {
                      //                                                                             setState(() {
                      //                                                                               categories[index].Check = value;
                      //                                                                             });
                      //                                                                             value ? partSelect.add(categories[index].id) : partSelect.remove(categories[index].id);
                      //                                                                           }),
                      //                                                                       Text(
                      //                                                                         "${themeColor.getlocal() == 'ar' ? categories[index].name ?? categories[index].name : categories[index].nameEn ?? categories[index].name} (${categories[index].count_cats})",
                      //                                                                         softWrap: true,
                      //                                                                       ),
                      //                                                                     ],
                      //                                                                   );
                      //                                                                 }),
                      //                                                   ),
                      //                                                 ),
                      //                                               ),
                      //                                             )
                      //                                           : Container(
                      //                                               decoration:
                      //                                                   BoxDecoration(
                      //                                                 border: Border.all(
                      //                                                     color:
                      //                                                         Colors.black12),
                      //                                               ),
                      //                                               child:
                      //                                                   Padding(
                      //                                                 padding:
                      //                                                     const EdgeInsets
                      //                                                         .only(
                      //                                                   bottom:
                      //                                                       8,
                      //                                                   top: 8,
                      //                                                   left:
                      //                                                       24,
                      //                                                   right:
                      //                                                       24,
                      //                                                 ),
                      //                                                 child:
                      //                                                     ExpandablePanel(
                      //                                                   header:
                      //                                                       Text(
                      //                                                     '${getTransrlate(context, 'category')}',
                      //                                                     style:
                      //                                                         TextStyle(fontWeight: FontWeight.bold),
                      //                                                   ),
                      //                                                   expanded:
                      //                                                       Padding(
                      //                                                     padding:
                      //                                                         const EdgeInsets.all(16.0),
                      //                                                     child: categories == null
                      //                                                         ? Custom_Loading()
                      //                                                         : categories.isEmpty
                      //                                                             ? Container()
                      //                                                             : ListView.builder(
                      //                                                                 primary: false,
                      //                                                                 shrinkWrap: true,
                      //                                                                 physics: NeverScrollableScrollPhysics(),
                      //                                                                 itemCount: categories.length,
                      //                                                                 itemBuilder: (BuildContext context, int index) {
                      //                                                                   return Row(
                      //                                                                     children: [
                      //                                                                       Checkbox(
                      //                                                                           value: categories[index].Check,
                      //                                                                           activeColor: Colors.orange,
                      //                                                                           onChanged: (value) {
                      //                                                                             setState(() {
                      //                                                                               categories[index].Check = value;
                      //                                                                             });
                      //                                                                             value ? partSelect.add(categories[index].id) : partSelect.remove(categories[index].id);
                      //                                                                           }),
                      //                                                                       Container(
                      //                                                                         width: ScreenUtil.getWidth(context) / 1.5,
                      //                                                                         child: Text(
                      //                                                                           "${themeColor.getlocal() == 'ar' ? categories[index].name ?? categories[index].name : categories[index].nameEn ?? categories[index].name} (${categories[index].count_cats})",
                      //                                                                           softWrap: true,
                      //                                                                           maxLines: 2,
                      //                                                                         ),
                      //                                                                       ),
                      //                                                                     ],
                      //                                                                   );
                      //                                                                 }),
                      //                                                   ),
                      //                                                 ),
                      //                                               ),
                      //                                             ),
                      //                                   Container(
                      //                                     decoration:
                      //                                         BoxDecoration(
                      //                                       border: Border.all(
                      //                                           color: Colors
                      //                                               .black12),
                      //                                     ),
                      //                                     child: Padding(
                      //                                       padding:
                      //                                           const EdgeInsets
                      //                                               .only(
                      //                                         bottom: 8,
                      //                                         top: 8,
                      //                                         left: 24,
                      //                                         right: 24,
                      //                                       ),
                      //                                       child:
                      //                                           ExpandablePanel(
                      //                                         header: Text(
                      //                                           '${getTransrlate(context, 'manufacturers')}',
                      //                                           style: TextStyle(
                      //                                               fontWeight:
                      //                                                   FontWeight
                      //                                                       .bold),
                      //                                         ),
                      //                                         expanded: Padding(
                      //                                           padding:
                      //                                               const EdgeInsets
                      //                                                       .all(
                      //                                                   16.0),
                      //                                           child: manufacturer ==
                      //                                                   null
                      //                                               ? Custom_Loading()
                      //                                               : ListView.builder(
                      //                                                   primary: false,
                      //                                                   shrinkWrap: true,
                      //                                                   physics: NeverScrollableScrollPhysics(),
                      //                                                   itemCount: manufacturer.length,
                      //                                                   itemBuilder: (BuildContext context, int index) {
                      //                                                     return Row(
                      //                                                       children: [
                      //                                                         Checkbox(
                      //                                                             activeColor: Colors.orange,
                      //                                                             value: manufacturer[index].check,
                      //                                                             onChanged: (value) {
                      //                                                               setState(() {
                      //                                                                 manufacturer[index].check = value;
                      //                                                               });
                      //                                                               value ? manufacturerSelect.add(manufacturer[index].id) : manufacturerSelect.remove(manufacturer[index].id);
                      //                                                             }),
                      //                                                         Text(
                      //                                                           "${manufacturer[index].manufacturerName} (${manufacturer[index].count_manufacturers ?? ''})",
                      //                                                           softWrap: true,
                      //                                                         ),
                      //                                                       ],
                      //                                                     );
                      //                                                   }),
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                   Container(
                      //                                     decoration:
                      //                                         BoxDecoration(
                      //                                       border: Border.all(
                      //                                           color: Colors
                      //                                               .black12),
                      //                                     ),
                      //                                     child: Padding(
                      //                                       padding:
                      //                                           const EdgeInsets
                      //                                               .only(
                      //                                         bottom: 8,
                      //                                         top: 8,
                      //                                         left: 24,
                      //                                         right: 24,
                      //                                       ),
                      //                                       child:
                      //                                           ExpandablePanel(
                      //                                         header: Text(
                      //                                           '${getTransrlate(context, 'carmade')}',
                      //                                           style: TextStyle(
                      //                                               fontWeight:
                      //                                                   FontWeight
                      //                                                       .bold),
                      //                                         ),
                      //                                         expanded: Padding(
                      //                                           padding:
                      //                                               const EdgeInsets
                      //                                                       .all(
                      //                                                   16.0),
                      //                                           child: origin ==
                      //                                                   null
                      //                                               ? Custom_Loading()
                      //                                               : origin.isEmpty
                      //                                                   ? Container()
                      //                                                   : ListView.builder(
                      //                                                       primary: false,
                      //                                                       shrinkWrap: true,
                      //                                                       physics: NeverScrollableScrollPhysics(),
                      //                                                       itemCount: origin.length,
                      //                                                       itemBuilder: (BuildContext context, int index) {
                      //                                                         return Row(
                      //                                                           children: [
                      //                                                             Checkbox(
                      //                                                                 value: origin[index].check,
                      //                                                                 activeColor: Colors.orange,
                      //                                                                 onChanged: (value) {
                      //                                                                   setState(() {
                      //                                                                     origin[index].check = value;
                      //                                                                   });
                      //                                                                   value ? originSelect.add(origin[index].id) : originSelect.remove(origin[index].id);
                      //                                                                 }),
                      //                                                             Text(
                      //                                                               "${origin[index].countryName} (${origin[index].count_origins ?? ''})",
                      //                                                               softWrap: true,
                      //                                                             ),
                      //                                                           ],
                      //                                                         );
                      //                                                       }),
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                   Container(
                      //                                     decoration:
                      //                                         BoxDecoration(
                      //                                       border: Border.all(
                      //                                           color: Colors
                      //                                               .black12),
                      //                                     ),
                      //                                     child: Padding(
                      //                                       padding:
                      //                                           const EdgeInsets
                      //                                               .only(
                      //                                         bottom: 8,
                      //                                         top: 8,
                      //                                         left: 24,
                      //                                         right: 24,
                      //                                       ),
                      //                                       child:
                      //                                           ExpandablePanel(
                      //                                         header: Text(
                      //                                           '${getTransrlate(context, 'price')}',
                      //                                           style: TextStyle(
                      //                                               fontWeight:
                      //                                                   FontWeight
                      //                                                       .bold),
                      //                                         ),
                      //                                         expanded: Column(
                      //                                           children: [
                      //                                             Row(
                      //                                               mainAxisAlignment:
                      //                                                   MainAxisAlignment
                      //                                                       .spaceBetween,
                      //                                               children: [
                      //                                                 Container(
                      //                                                     width: ScreenUtil.getWidth(context) *
                      //                                                         0.10,
                      //                                                     child: Text(_currentRangeValues
                      //                                                         .start
                      //                                                         .round()
                      //                                                         .toString())),
                      //                                                 Container(
                      //                                                   width: ScreenUtil.getWidth(context) /
                      //                                                       1.6,
                      //                                                   child:
                      //                                                       RangeSlider(
                      //                                                     activeColor:
                      //                                                         Colors.orange,
                      //                                                     inactiveColor:
                      //                                                         Colors.black26,
                      //                                                     values:
                      //                                                         _currentRangeValues,
                      //                                                     min:
                      //                                                         min,
                      //                                                     max:
                      //                                                         max,
                      //                                                     divisions:
                      //                                                         10000,
                      //                                                     labels:
                      //                                                         RangeLabels(
                      //                                                       _currentRangeValues.start.round().toString(),
                      //                                                       _currentRangeValues.end.round().toString(),
                      //                                                     ),
                      //                                                     onChanged:
                      //                                                         (RangeValues values) {
                      //                                                       setState(() {
                      //                                                         _currentRangeValues = values;
                      //                                                       });
                      //                                                     },
                      //                                                   ),
                      //                                                 ),
                      //                                                 Container(
                      //                                                     width: ScreenUtil.getWidth(context) *
                      //                                                         0.10,
                      //                                                     child: Text(_currentRangeValues
                      //                                                         .end
                      //                                                         .round()
                      //                                                         .toString())),
                      //                                               ],
                      //                                             ),
                      //                                             Row(
                      //                                               mainAxisAlignment:
                      //                                                   MainAxisAlignment
                      //                                                       .spaceEvenly,
                      //                                               children: [
                      //                                                 Container(
                      //                                                     width: ScreenUtil.getWidth(context) *
                      //                                                         0.10,
                      //                                                     child:
                      //                                                         Text("${getTransrlate(context, 'from')}")),
                      //                                                 Container(
                      //                                                   width:
                      //                                                       ScreenUtil.getWidth(context) /
                      //                                                           3,
                      //                                                   child:
                      //                                                       MyTextFormField(
                      //                                                     keyboard_type:
                      //                                                         TextInputType.number,
                      //                                                     //enabled: false,
                      //                                                     intialLabel: min
                      //                                                         .floor()
                      //                                                         .toString(),
                      //                                                     validator:
                      //                                                         (String item) {
                      //                                                       if (item !=
                      //                                                           null) {
                      //                                                         if (double.parse(item) < minPrice.floor()) {
                      //                                                           return "${getTransrlate(context, 'from')} < ${minPrice.floor()}";
                      //                                                         } else if (double.parse(item) > filterPrice) {
                      //                                                           return "${getTransrlate(context, 'from')} > $filterPrice";
                      //                                                         }
                      //                                                       } else
                      //                                                         _formKey.currentState.save();
                      //
                      //                                                       return null;
                      //                                                     },
                      //                                                     onChange:
                      //                                                         (v) {
                      //                                                       if (v !=
                      //                                                           null) {
                      //                                                         if (v.isNotEmpty) {
                      //                                                           setState(() {
                      //                                                             if (max >= double.parse(v)) {
                      //                                                               _currentRangeValues = RangeValues(double.parse(v), max);
                      //                                                               min = double.parse(v);
                      //                                                             }
                      //                                                           });
                      //                                                         }
                      //                                                       }
                      //                                                     },
                      //                                                   ),
                      //                                                 ),
                      //                                                 Container(
                      //                                                     width: ScreenUtil.getWidth(context) *
                      //                                                         0.10,
                      //                                                     child:
                      //                                                         Text("${getTransrlate(context, 'to')}")),
                      //                                                 Container(
                      //                                                   width:
                      //                                                       ScreenUtil.getWidth(context) /
                      //                                                           3,
                      //                                                   child:
                      //                                                       MyTextFormField(
                      //                                                     keyboard_type:
                      //                                                         TextInputType.number,
                      //                                                     intialLabel: max
                      //                                                         .floor()
                      //                                                         .toString(),
                      //                                                     validator:
                      //                                                         (String item) {
                      //                                                       if (item !=
                      //                                                           null) {
                      //                                                         if (double.parse(item) > filterPrice) {
                      //                                                           return "${getTransrlate(context, 'from')} > $filterPrice";
                      //                                                         }
                      //                                                       } else
                      //                                                         _formKey.currentState.save();
                      //
                      //                                                       return null;
                      //                                                     },
                      //                                                     onChange:
                      //                                                         (v) {
                      //                                                       if (v !=
                      //                                                           null) {
                      //                                                         if (v.isNotEmpty) {
                      //                                                           if (double.parse(v) >= min) {
                      //                                                             setState(() {
                      //                                                               // if (min <= double.parse(v)) {
                      //                                                               // }
                      //                                                               _currentRangeValues = RangeValues(min, double.parse(v));
                      //                                                               max = double.parse(v);
                      //                                                             });
                      //                                                           }
                      //                                                         }
                      //                                                       }
                      //                                                     },
                      //                                                   ),
                      //                                                 )
                      //                                               ],
                      //                                             ),
                      //                                           ],
                      //                                         ),
                      //                                       ),
                      //                                     ),
                      //                                   ),
                      //                                 ],
                      //                               ),
                      //                             ),
                      //                           ),
                      //                           Padding(
                      //                             padding:
                      //                                 const EdgeInsets.all(4.0),
                      //                             child: Row(
                      //                               children: [
                      //                                 InkWell(
                      //                                   onTap: () {
                      //                                     if (_formKey
                      //                                         .currentState
                      //                                         .validate()) {
                      //                                       _formKey
                      //                                           .currentState
                      //                                           .save();
                      //                                       // Navigator.pop(
                      //                                       //     context,
                      //                                       //     "${!widget.Istryers
                      //                                       //         ? ''
                      //                                       //         : "?width=${widthID ??
                      //                                       //         ''}&height=${heightID ??
                      //                                       //         ''}&size=${sizeID ??
                      //                                       //         ''}"}"
                      //                                       //         "${manufacturerSelect
                      //                                       //         .isEmpty
                      //                                       //         ? ''
                      //                                       //         : "&manufacturers=${manufacturerSelect
                      //                                       //         .toString()}"}"
                      //                                       //         "${partSelect
                      //                                       //         .isEmpty
                      //                                       //         ? ''
                      //                                       //         : "&categories=${partSelect
                      //                                       //         .toString()}"}"
                      //                                       //         "${originSelect
                      //                                       //         .isEmpty
                      //                                       //         ? ''
                      //                                       //         : "&origins=${originSelect
                      //                                       //         .toString()}"}"
                      //                                       //         "${_currentRangeValues
                      //                                       //         .start
                      //                                       //         .round()
                      //                                       //         .toString()
                      //                                       //         .isEmpty
                      //                                       //         ? ''
                      //                                       //         : "&start_price=${_currentRangeValues
                      //                                       //         .start.round()
                      //                                       //         .toString()}"}"
                      //                                       //         "${_currentRangeValues
                      //                                       //         .end
                      //                                       //         .round()
                      //                                       //         .toString()
                      //                                       //         .isEmpty
                      //                                       //         ? ''
                      //                                       //         : "&end_price=${_currentRangeValues
                      //                                       //         .end
                      //                                       //         .round()
                      //                                       //         .toString()}"}");
                      //                                       Filtration = null;
                      //                                       Filtration =
                      //                                           "${manufacturerSelect.isEmpty ? '' : "&manufacturers=${manufacturerSelect.toString()}"}"
                      //                                           "${partSelect.isEmpty ? '' : "&categories=${partSelect.toString()}"}"
                      //                                           "${originSelect.isEmpty ? '' : "&origins=${originSelect.toString()}"}"
                      //                                           "${_currentRangeValues.start.toString().isEmpty ? '' : "&start_price=${_currentRangeValues.start.floor().toString()}"}"
                      //                                           "${_currentRangeValues.end.toString().isEmpty ? '' : "&end_price=${_currentRangeValues.end.round().toString()}"}";
                      //                                       print(Filtration);
                      //                                       Navigator.pop(
                      //                                           context);
                      //                                     }
                      //                                   },
                      //                                   child: Container(
                      //                                     margin:
                      //                                         const EdgeInsets
                      //                                             .all(15.0),
                      //                                     padding:
                      //                                         const EdgeInsets
                      //                                             .all(10.0),
                      //                                     width: ScreenUtil
                      //                                             .getWidth(
                      //                                                 context) /
                      //                                         2.5,
                      //                                     decoration: BoxDecoration(
                      //                                         border: Border.all(
                      //                                             color: Colors
                      //                                                 .orange)),
                      //                                     child: Center(
                      //                                         child: Row(
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .center,
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         Icon(
                      //                                           Icons
                      //                                               .check_circle_outline_sharp,
                      //                                           color: Colors
                      //                                               .orange,
                      //                                         ),
                      //                                         SizedBox(
                      //                                           width: 10,
                      //                                         ),
                      //                                         Text(
                      //                                           '${getTransrlate(context, 'Accept')}',
                      //                                           style: TextStyle(
                      //                                               fontWeight:
                      //                                                   FontWeight
                      //                                                       .bold,
                      //                                               color: Colors
                      //                                                   .orange),
                      //                                         ),
                      //                                       ],
                      //                                     )),
                      //                                   ),
                      //                                 ),
                      //                                 InkWell(
                      //                                   onTap: () async {
                      //                                     widthID = null;
                      //                                     heightID = null;
                      //                                     sizeID = null;
                      //                                     min = 1;
                      //                                     max = 10000;
                      //                                     _currentRangeValues =
                      //                                         RangeValues(
                      //                                             min, max);
                      //                                     Filtration = '';
                      //                                     await widget.Category
                      //                                         ? getDataCategory()
                      //                                         : getData();
                      //                                     Navigator.pop(
                      //                                         context, '1');
                      //                                   },
                      //                                   child: Container(
                      //                                     margin:
                      //                                         const EdgeInsets
                      //                                             .all(15.0),
                      //                                     padding:
                      //                                         const EdgeInsets
                      //                                             .all(10.0),
                      //                                     width: ScreenUtil
                      //                                             .getWidth(
                      //                                                 context) /
                      //                                         2.5,
                      //                                     decoration: BoxDecoration(
                      //                                         border: Border.all(
                      //                                             color: Colors
                      //                                                 .grey)),
                      //                                     child: Center(
                      //                                         child: Row(
                      //                                       crossAxisAlignment:
                      //                                           CrossAxisAlignment
                      //                                               .center,
                      //                                       mainAxisAlignment:
                      //                                           MainAxisAlignment
                      //                                               .center,
                      //                                       children: [
                      //                                         Icon(
                      //                                           Icons.refresh,
                      //                                           color:
                      //                                               Colors.grey,
                      //                                         ),
                      //                                         SizedBox(
                      //                                           width: 10,
                      //                                         ),
                      //                                         Text(
                      //                                           '${getTransrlate(context, 'ReSet')}',
                      //                                           style: TextStyle(
                      //                                               fontWeight:
                      //                                                   FontWeight
                      //                                                       .bold,
                      //                                               color: Colors
                      //                                                   .grey),
                      //                                         ),
                      //                                       ],
                      //                                     )),
                      //                                   ),
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           )
                      //                         ],
                      //                       ),
                      //                     ),
                      //                   );
                      //                 })).then((partSelect) {
                      //       if (partSelect == null) {
                      //         setState(() {
                      //           product = null;
                      //         });
                      //         API(context)
                      //             .get(widget.Istryers
                      //                 ? 'search/ahmed/category/parts${"${!widget.Istryers ? '' : "?width=${widthID ?? ''}&height=${heightID ?? ''}&size=${sizeID ?? ''}"}"}' +
                      //                     "${Filtration.contains('&', 0) ? '${Filtration}' : '&${Filtration}'}"
                      //                 : url +
                      //                     "${Filtration.contains('&', 0) ? '${Filtration}' : '&${Filtration}'}")
                      //             .then((value) {
                      //           if (value != null) {
                      //             if (value['status_code'] == 200) {
                      //               setState(() {
                      //                 product =
                      //                     Product_model.fromJson(value).data;
                      //                 // product?.sort((current, next) => current
                      //                 //     .action_price
                      //                 //     .compareTo(next.action_price));
                      //                 // max =filterPrice= product.last.action_price;
                      //                 // min = product.first.action_price;
                      //                 // _currentRangeValues =
                      //                 //     RangeValues(min, max);
                      //                 if (value['cats_data'] != null) {
                      //                   categories =
                      //                       new List<Categories_item>();
                      //                   value['cats_data'].forEach((v) {
                      //                     categories.add(
                      //                         new Categories_item.fromJson(v));
                      //                   });
                      //                 }
                      //                 if (value['origins_data'] != null) {
                      //                   origin = [];
                      //                   value['origins_data'].forEach((v) {
                      //                     origin.add(Origin.fromJson(v));
                      //                   });
                      //                 }
                      //                 if (value['manufacturers_data'] != null) {
                      //                   manufacturer = [];
                      //                   value['manufacturers_data']
                      //                       .forEach((v) {
                      //                     manufacturer
                      //                         .add(Manufacturer.fromJson(v));
                      //                   });
                      //                 }
                      //               });
                      //             } else {
                      //               showDialog(
                      //                   context: context,
                      //                   builder: (_) => ResultOverlay(
                      //                       "${value['message']}\n${value['errors']}"));
                      //             }
                      //           }
                      //         });
                      //       }
                      //       // widget.Url='site/checkbox/filter/mobile?categories?${partSelect}';
                      //       // if (partSelect != null) {
                      //       //   bool Istryers = widget.Istryers ?? false;
                      //       //   filter=
                      //       //       "${manufacturerSelect
                      //       //       .isEmpty
                      //       //       ? ''
                      //       //       : "&manufacturers=${manufacturerSelect
                      //       //       .toString()}"}"
                      //       //       "${partSelect
                      //       //       .isEmpty
                      //       //       ? ''
                      //       //       : "&categories=${partSelect
                      //       //       .toString()}"}"
                      //       //       "${originSelect
                      //       //       .isEmpty
                      //       //       ? ''
                      //       //       : "&origins=${originSelect
                      //       //       .toString()}"}"
                      //       //       "${_currentRangeValues
                      //       //       .start
                      //       //       .round()
                      //       //       .toString()
                      //       //       .isEmpty
                      //       //       ? ''
                      //       //       : "&start_price=${_currentRangeValues
                      //       //       .start.round()
                      //       //       .toString()}"}"
                      //       //       "${_currentRangeValues
                      //       //       .end
                      //       //       .round()
                      //       //       .toString()
                      //       //       .isEmpty
                      //       //       ? ''
                      //       //       : "&end_price=${_currentRangeValues
                      //       //       .end
                      //       //       .round()
                      //       //       .toString()}"}";
                      //       //   print('url : $filter');
                      //       //   API(context)
                      //       //       .get(Istryers
                      //       //       ? 'search/home/category/parts$partSelect'
                      //       //       : url +
                      //       //       "${filter.contains('&', 0)
                      //       //           ? '${filter}'
                      //       //           : '&${filter}'}")
                      //       //       .then((value) {
                      //       //     if (value != null) {
                      //       //       if (value['status_code'] == 200) {
                      //       //         setState(() {
                      //       //           product =
                      //       //               Product_model
                      //       //                   .fromJson(value)
                      //       //                   .data;
                      //       //           if (value['cats_data'] != null) {
                      //       //             categories = new List<Categories_item>();
                      //       //             value['cats_data'].forEach((v) {
                      //       //               categories.add(
                      //       //                   new Categories_item.fromJson(v));
                      //       //             });
                      //       //           }
                      //       //           if (value['origins_data'] != null) {
                      //       //             origin = [];
                      //       //             value['origins_data'].forEach((v) {
                      //       //               origin.add(Origin.fromJson(v));
                      //       //             });
                      //       //           }
                      //       //           if (value['manufacturers_data'] != null) {
                      //       //             manufacturer = [];
                      //       //             value['manufacturers_data'].forEach((v) {
                      //       //               manufacturer.add(Manufacturer.fromJson(v));
                      //       //             });
                      //       //           }
                      //       //         });
                      //       //       } else {
                      //       //         showDialog(
                      //       //             context: context,
                      //       //             builder: (_) =>
                      //       //                 ResultOverlay(
                      //       //                     "${value['message']}\n${value['errors']}"));
                      //       //       }
                      //       //     }
                      //       //   });
                      //       // }
                      //     });
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         color: Colors.orangeAccent,
                      //         borderRadius: BorderRadius.circular(8),
                      //         border: Border.all(color: Colors.orange)),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(4.0),
                      //       child: Row(
                      //         children: [
                      //           Icon(
                      //             Icons.filter_alt,
                      //             size: 20,
                      //             color: Colors.white,
                      //           ),
                      //           Text(
                      //             ' ${getTransrlate(context, 'filter')}',
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //           Icon(
                      //             Icons.keyboard_arrow_down,
                      //             size: 20,
                      //             color: Colors.white,
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (_) => Sortdialog()).then((val) {
                            sort = val;
                            setState(() {
                              product = null;
                            });
                            API(context)
                                .get('store/${url}?${sort ?? 'ordering=public_price'}')
                                .then((value) {
                              if (value != null) {
                                  setState(() {
                                    product =
                                        Product_model.fromJson(value).data;
                                  });

                              }
                            });
                          });
                        },
                        child: Row(
                          children: [
                            Text(' ${getTransrlate(context, 'Sort')}'),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 30,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  product == null
                      ? Custom_Loading()
                      : product.isEmpty
                          ? NotFoundProduct()
                          : list
                              ? grid_product(product: product)
                              : List_product(
                                  product: product,
                                ),
                  SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getData() {
    partSelect = [];
    originSelect = [];
    manufacturerSelect = [];
    setState(() {
      product = null;
    });

    API(context).get("store/${widget.Url}").then((value) {
      if (value != null) {
        print("value : $value");
          setState(() {
            product = Product_model.fromJson(value).data;
          });

      }
    });
  }
  void getDataCategory() {
    partSelect = [];
    originSelect = [];
    manufacturerSelect = [];
    setState(() {
      product = null;
    });

    API(context).get("store/${widget.Url}").then((value) {
      if (value != null) {
          setState(() {
            product = Product_model.fromJson(value).data;
          });

      }
    });
  }
  ExpandableCategory(Categories_item categoriesItem, Provider_control themeColor) {
    return categoriesItem.id == 1711 || categoriesItem.id == 682
        ? Container()
        : ExpansionTile(
            textColor: Colors.orange,
            iconColor: Colors.orange,
            collapsedTextColor: Colors.black,
            title: Text(
                "${themeColor.getlocal() == 'ar' ? categoriesItem.name : categoriesItem.nameEn}"),
            children: [
              categoriesItem.categories == null
                  ? Container()
                  : ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: categoriesItem.categories.length,
                      itemBuilder: (BuildContext context, int i) {
                        return categoriesItem.categories[i].level == 0
                            ? Row(
                                children: [
                                  Checkbox(
                                      value:
                                          categoriesItem.categories[i].Check,
                                      activeColor: Colors.orange,
                                      onChanged: (value) {
                                        setState(() {
                                          categoriesItem.categories[i].Check =
                                              value;
                                        });
                                        value
                                            ? partSelect.add(categoriesItem
                                                .categories[i].id)
                                            : partSelect.remove(categoriesItem
                                                .categories[i].id);
                                      }),
                                  Text(
                                    "${themeColor.getlocal() == 'ar' ? categoriesItem.categories[i].name ?? categoriesItem.categories[i].name : categoriesItem.categories[i].nameEn ?? categoriesItem.categories[i].name}",
                                    softWrap: true,
                                  ),
                                ],
                              )
                            : ExpandableCategory(
                                categoriesItem.categories[i], themeColor);
                      })
            ],
          );
  }
}
