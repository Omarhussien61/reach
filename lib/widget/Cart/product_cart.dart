import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/cart_model.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/ServiceData.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class ProductCart extends StatefulWidget {
  const ProductCart({
    Key key,
    @required this.themeColor,
    this.carts,
  }) : super(key: key);

  final Provider_control themeColor;
  final Item carts;

  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {

  List<String> items = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "other",
  ];

  bool loading = false;
  bool uloading = false;
  bool other = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ServiceData = Provider.of<Provider_Data>(context);
    final Servicetheme = Provider.of<Provider_control>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ScreenUtil.getWidth(context) / 4,
              child: CachedNetworkImage(
                imageUrl: widget.carts.product.image,
                errorWidget: (context, url, error) => Icon(
                  Icons.image,
                  color: Colors.black12,
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  width: ScreenUtil.getWidth(context) / 2.5,

                  child: AutoSizeText(
                    widget.carts.product.name,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  //width: ScreenUtil.getWidth(context) / 1.7,
                  padding: EdgeInsets.only(left: 10, top: 2, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 12),
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Container(
                                //   width: ScreenUtil.getWidth(context) / 3.2,
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //     crossAxisAlignment: CrossAxisAlignment.center,
                                //     children: [
                                //       Container(
                                //         child: AutoSizeText(
                                //           getTransrlate(context, 'price'),
                                //           maxLines: 1,
                                //           minFontSize: 14,
                                //           style: TextStyle(fontWeight: FontWeight.w400),
                                //         ),
                                //       ),
                                //       SizedBox(
                                //         height: 10,
                                //       ),
                                //       Container(
                                //         child: AutoSizeText(
                                //           " ${widget.carts.product.publicPrice} ${getTransrlate(context, 'Currency')}",
                                //           maxLines: 1,
                                //           minFontSize: 14,
                                //           style: TextStyle(
                                //               color: widget.themeColor.getColor(),
                                //               fontWeight: FontWeight.bold),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // InkWell(
                                //   onTap: () {
                                //     setState(() {
                                //       other = !other;
                                //     });
                                //   },
                                //   child: Container(
                                //     width: 100,
                                //     decoration: BoxDecoration(
                                //         border: Border.all(
                                //             width: 1, color: Colors.black12)),
                                //     child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: Row(
                                //         crossAxisAlignment: CrossAxisAlignment.center,
                                //         mainAxisAlignment:
                                //         MainAxisAlignment.spaceEvenly,
                                //         children: [
                                //           Container(
                                //               width: 50,
                                //               child:
                                //               Text("${widget.carts.quantity}")),
                                //           Icon(Icons.arrow_drop_down)
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                widget.carts.quantity!=0?   IconButton(icon:  Icon(Icons.remove_circle,color: Colors.grey,),onPressed: ()=>setState(()=>widget.carts.quantity--),):new Container(),
                                 Text(widget.carts.quantity.toString()),
                                 IconButton(icon: new Icon(Icons.add_circle,color: Servicetheme.getColor(),),onPressed: ()=>setState(()=>widget.carts.quantity++)),
                                Container(
                                  width: ScreenUtil.getWidth(context) / 5,
                                  child: Container(
                                    child: AutoSizeText(
                                      " ${widget.carts.subTotal} ${getTransrlate(context, 'Currency')}",
                                      maxLines: 1,
                                      minFontSize: 11,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            !other
                                ? Container(
                              child: Form(
                                key: _formKey,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10,
                                      left: 2,
                                      right: 2,
                                      top: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black12)),
                                  height: 90,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${getTransrlate(context, 'quantity')} :",
                                      ),

                                      Container(
                                        width: 100,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 12),
                                        padding: const EdgeInsets.all(3.0),
                                        child: MyTextFormField(
                                          istitle: true,
                                          intialLabel: widget.carts.quantity.toString(),
                                          keyboard_type:
                                          TextInputType.number,
                                          labelText: getTransrlate(
                                              context, 'quantity'),
                                          hintText: getTransrlate(
                                              context, 'quantity'),
                                          isPhone: true,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return "كمية";
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          onSaved: (String value) {
                                            widget.carts.quantity =
                                                int.parse(value);
                                          },
                                        ),
                                      ),
                                      uloading?Center(
                                        child: CircularProgressIndicator(  valueColor:
                                        AlwaysStoppedAnimation<Color>( Colors.lightGreen),),
                                      ):  InkWell(
                                        onTap: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            _formKey.currentState.save();
                                            setState(() => uloading = true);

                                            API(context)
                                                .post('add/to/cart', {
                                              "product_id":
                                              widget.carts.product.id,
                                              "quantity":
                                              widget.carts.quantity,
                                              "order_id":
                                              widget.carts.id
                                            }).then((value) {
                                              setState(() => uloading = false);

                                              if (value != null) {
                                                if (value['status_code'] ==
                                                    200) {

                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ResultOverlay(value[
                                                          'message']));

                                                  ServiceData.getCart(
                                                      context);
                                                  setState(() {
                                                    other=!other;

                                                  });
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ResultOverlay(value[
                                                          'message']));
                                                }
                                              }
                                            });
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          margin:
                                          const EdgeInsets.symmetric(
                                              horizontal: 2,
                                              vertical: 1),
                                          padding:
                                          const EdgeInsets.all(12.0),
                                          color: Colors.lightGreen,
                                          child: Center(
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.cart,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    getTransrlate(
                                                        context, 'updateCart'),
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                                : Container(),
                          ],
                        ),
                      ),

                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Container(
                          height: 1,
                          color: Colors.black12,
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
            loading?Padding(
              padding: const EdgeInsets.all(2.0),
              child: SizedBox(
                height: 20.0,
                width: 20.0,
                child: Center(
                  child: CircularProgressIndicator(  valueColor:
                  AlwaysStoppedAnimation<Color>( Colors.orange),),
                ),
              ),
            ): IconButton(
                onPressed: () {
                  deleteItem(ServiceData);
                },
                icon: Icon(
                  Icons.delete_outline,
                  size: 25,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  void deleteItem(Provider_Data ServiceData) {
    setState(() => loading = true);

    API(context).Delete('6/items/${widget.carts.id}/').then((value) {
      setState(() => loading = false);

      if (value != null) {
        if (value['status_code'] == 200) {
          showDialog(
              context: context,
              builder: (_) => ResultOverlay(value['message']));
          ServiceData.getCart(context);
        } else {
          showDialog(
              context: context,
              builder: (_) => ResultOverlay(value['errors']));
        }
      }
    });
  }
}
