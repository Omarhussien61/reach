import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/Categories_model.dart';
import 'package:flutter_pos/screens/account/Account.dart';
import 'package:flutter_pos/screens/order/cart.dart';
import 'package:flutter_pos/screens/product/companies.dart';
import 'package:flutter_pos/screens/product/companiesScreen.dart';
import 'package:flutter_pos/screens/product/products_page.dart';
import 'package:flutter_pos/screens/product/sub_category.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/model/ads.dart';
import 'package:flutter_pos/model/car_type.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/screens/product/category.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/widget/SearchOverlay.dart';
import 'package:flutter_pos/widget/app_bar_custom.dart';
import 'package:flutter_pos/widget/category/category_card.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/product/product_card.dart';
import 'package:flutter_pos/widget/product/product_list_titlebar.dart';
import 'package:flutter_pos/widget/slider/Banner.dart';
import 'package:flutter_pos/widget/slider/slider_dotAds.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CarType> cartype;
  int checkboxType = 0;
  final ScrollController _scrollController = ScrollController();
  int complete;
  PersistentTabController _controller;
  final navigatorKey = GlobalKey<NavigatorState>();
  List<Widget> _buildScreens() {
    return [HomePage(), CategoryScreen(), CartScreen(), Account()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    final data = Provider.of<Provider_Data>(context);

    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: getTransrlate(context, 'HomePage'),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.apps),
        title: (getTransrlate(context, 'category')),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Stack(
          children: [
            Center(child: Icon(CupertinoIcons.cart)),
            Center(
                child: Text(
              data.cart_model != null
                  ? " ${data.cart_model.items == null ? 0 : data.cart_model.items.length ?? 0} "
                  : '',
              style: TextStyle(
                  height: 1,
                  backgroundColor: Colors.white,
                  color: Colors.orange),
            )),
          ],
        ),
        iconSize: 35,
        title: (getTransrlate(context, 'Cart')),
        textStyle: TextStyle(height: 1),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.menu,
          size: 35,
        ),
        title: (getTransrlate(context, 'MyProfile')),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  void initState() {
    Provider.of<Provider_Data>(context, listen: false).getData( context);
    Provider.of<Provider_Data>(context, listen: false).getCart( context);
    SharedPreferences.getInstance().then((value) {
      complete = value.getInt('complete');
    });
    super.initState();
  }



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _carouselCurrentPage = 0;
  String pathImage;

  @override
  Widget build(BuildContext context) {
    final provider_Data = Provider.of<Provider_Data>(context);
    final theme = Provider.of<Provider_control>(context);
    return Scaffold(
      key: _scaffoldKey,
      // drawer: HiddenMenu(),
      body: HomePage()
      // PersistentTabView(
      //   context,
      //   controller: _controller,
      //   screens: _buildScreens(),
      //   items: _navBarsItems(),
      //   navBarHeight: 60,
      //   margin: EdgeInsets.only(bottom: 10),
      //   confineInSafeArea: true,
      //   backgroundColor: Colors.white,
      //   // Default is Colors.white.
      //   handleAndroidBackButtonPress: true,
      //   // Default is true.
      //   resizeToAvoidBottomInset: true,
      //   // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      //   stateManagement: true,
      //   // Default is true.
      //   hideNavigationBarWhenKeyboardShows: true,
      //   // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      //   decoration: NavBarDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //     border: Border.all(color: Colors.black12, width: 1),
      //     colorBehindNavBar: Colors.white,
      //   ),
      //   popAllScreensOnTapOfSelectedTab: true,
      //
      //   selectedTabScreenContext: (v) {
      //     if (_controller.index == 2) {
      //       provider_Data.getCart(context);
      //     }
      //     // if (_controller.index == 0) {
      //     //     _scrollController.animateTo(
      //     //         _scrollController.position.minScrollExtent,
      //     //         duration: const Duration(milliseconds: 400),
      //     //         curve: Curves.fastOutSlowIn);
      //     //          }
      //   },
      //   onItemSelected: (i) {
      //     if (i == 0) {
      //       _scrollController.animateTo(
      //           _scrollController.position.minScrollExtent,
      //           duration: const Duration(milliseconds: 400),
      //           curve: Curves.fastOutSlowIn);
      //     }
      //   },
      //   popActionScreens: PopActionScreensType.once,
      //   itemAnimationProperties: ItemAnimationProperties(
      //     // Navigation Bar's items animation properties.
      //     duration: Duration(milliseconds: 200),
      //     curve: Curves.ease,
      //   ),
      //
      //   screenTransitionAnimation: ScreenTransitionAnimation(
      //     // Screen transition animation on change of selected tab.
      //     animateTabTransition: false,
      //     curve: Curves.ease,
      //     duration: Duration(milliseconds: 200),
      //   ),
      //   navBarStyle:
      //       NavBarStyle.style6, // Choose the nav bar style with this property.
      // ),
    );
  }

  Widget HomePage() {
    final themeColor = Provider.of<Provider_control>(context);
    final provider_data = Provider.of<Provider_Data>(context);

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          AppBarCustom(),
          Expanded(
            child: RefreshIndicator(
              color: themeColor.getColor(),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: MyTextFormField(
                        press: (){
                          showDialog(context: context, builder: (_) => SearchOverlay());
                        },
                        hintText: 'ما الذي تبحث عنه ؟',
                        prefix: IconButton(icon: Icon(Icons.search),onPressed: (){
                          showDialog(context: context, builder: (_) => SearchOverlay());
                        },),
                        suffixIcon:IconButton(icon: Icon(Icons.filter_list_outlined),onPressed: (){
                          Nav.route(
                              context,
                              Products_Page(
                                Url:
                                'filter',
                                Category: true,
                              ));
                        },),
                        onChange: (value) {},
                      ),
                    ),
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "تسوق حسب الاقسام",
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            textDirection:
                            TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    provider_data.Mostcategories == null
                        ? Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Custom_Loading(),
                          )
                        : Container(child: list_category_navbar(themeColor, provider_data.Mostcategories,true)),

                       SizedBox(
                      height: 20,
                    ),
                    provider_data.productMostView == null
                        ? Container()
                        : Container(child: list_category(themeColor)),
                    provider_data.product == null
                        ? Container()
                        : provider_data.product.isEmpty
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ProductListTitleBar(
                                              themeColor: themeColor,
                                              title: getTransrlate(
                                                  context, 'offers'),
                                              description: getTransrlate(
                                                  context, 'showAll'),
                                              url:
                                                  'discount',
                                            ),
                                  list_product(
                                      themeColor, provider_data.product),
                                ],
                              ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "ماركات مميزة",
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            textDirection:
                            TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight:
                                FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    provider_data.productMostSale == null
                        ? Container()
                        : provider_data.productMostSale.isEmpty
                            ? Container()
                            : Column(
                                        children: [
                                          ProductListTitleBar(
                                            themeColor: themeColor,
                                            title: getTransrlate(
                                                context, 'moresale'),
                                            description: getTransrlate(
                                                context, 'showAll'),
                                            url:
                                                'meddiscounts',
                                          ),
                                          list_product(themeColor,
                                              provider_data.productMostSale),
                                          SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                    SizedBox(
                      height: 10,
                    ),
                    provider_data.categories == null
                        ? Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Custom_Loading(),
                    )
                        : Container(child: list_category_navbar(themeColor, provider_data.categories,false)),
  InkWell(
    onTap: (){
      Nav.route(
          context,
          CompaniesScreen(
          ));
    },
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
          decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(8),
            border: Border.all(color:themeColor.getColor() )
                ),
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text('عرض كل الماركات')),
      )),
    ),
  )
                  ],
                ),
              ),
              onRefresh: _refreshLocalGallery,
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _refreshLocalGallery() async {
  }

  Widget list_category(
    Provider_control themeColor,
  ) {
    final provider_data = Provider.of<Provider_Data>(context);

    return provider_data.productMostView.isEmpty
        ? Container()
        : Column(
            children: [
              Text("${getTransrlate(context, 'DescOpportunities')}",
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
              Center(
                child: ResponsiveGridList(
                  scroll: false,
                  desiredItemWidth: 100,
                  rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  minSpacing: 10,
                  children: provider_data.productMostView
                      .map((product) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: CategoryCard(
                              themeColor: themeColor,
                              product: product,
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          );
  }

  Widget list_category_navbar(
    Provider_control themeColor,
      List<Categories_item>  Mostcategories,
      bool iscategory
  ) {
    return Mostcategories.isEmpty
        ? Container()
        : Center(
            child: ResponsiveGridList(
              scroll: false,
              desiredItemWidth: 100,
              rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
              minSpacing: 10,
              children:Mostcategories.map((product) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Container(
                      margin:
                          EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        onTap: () {
                          iscategory?
                          Nav.route(context, SubCategoryScreen(Categories:product,)):
                          Nav.route(
                              context,
                              Products_Page(
                                id: product.id,
                                name:
                                "${themeColor.getlocal() == 'ar' ? product.name ??
                                    product.nameEn : product.nameEn ?? product.name}",
                                Url:
                                'companies/${product.id}',
                                Istryers: product.id == 1711 || product.id == 682,
                                Category: true,
                                Category_id: product.id,
                              ));;

                          // Nav.route(
                          //     context,
                          //     Products_Page(
                          //       id: product.id,
                          //       name:
                          //           "${themeColor.getlocal() == 'ar' ? product.name ?? product.nameEn : product.nameEn ?? product.name}",
                          //       Url:
                          //           '${iscategory?"categories":"companies"}/${product.id}',
                          //       Istryers:
                          //           product.id == 1711 || product.id == 682,
                          //       Category: true,
                          //       Category_id: product.id,
                          //     )
                          //
                          // );
                        },
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.black12),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.network(

                                  (product.photo == null)
                                      ? 'http://arabimagefoundation.com/images/defaultImage.png'
                                      : product.photo,
                                  height: ScreenUtil.getHeight(context) / 12,
                                  width: ScreenUtil.getWidth(context) / 3.2,
                                  errorBuilder: (context, url, error) => Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Image.asset(
                                      'assets/images/alt_img_category.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            AutoSizeText(
                              "${themeColor.getlocal() == 'ar' ? product.name ?? product.nameEn : product.nameEn ?? product.name}",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )).toList(),
            ),
          );
  }

  Widget list_product(Provider_control themeColor, List<Product> product) {
    return product.isEmpty
        ? Container()
        : ResponsiveGridList(
            scroll: false,
            desiredItemWidth: 150,
            minSpacing: 10,
            children: product
                .map((e) => Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 8),
                        child: ProductCard(
                          themeColor: themeColor,
                          product: e,
                        ),
                      ),
                    ))
                .toList(),
          );
  }
}
