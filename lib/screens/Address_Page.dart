import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/add_address.dart';
import 'package:flutter_pos/model/shipping_address.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Shipping_Address extends StatefulWidget {
  const Shipping_Address({Key key}) : super(key: key);

  @override
  _Shipping_AddressState createState() => _Shipping_AddressState();
}

class _Shipping_AddressState extends State<Shipping_Address> {
  List<Address> address;
  int checkboxValue;

  @override
  void initState() {

    getAddress();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset("assets/icons/User Icon.svg",color: Colors.white,height: 25,),
            SizedBox(width: 10,),
            Text(getTransrlate(context, 'MyAddress')),
          ],
        ),
      ),

      body:Container(
        child: address == null
            ? Container()
            : Column(
              children: [
                Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: address.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Radio<int>(
                              value: index,
                              groupValue: checkboxValue,
                              activeColor: themeColor.getColor(),
                              focusColor: themeColor.getColor(),
                              hoverColor: themeColor.getColor(),
                              onChanged: (int value) {
                                setState(() {
                                  checkboxValue = value;
                                });
                              },
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  checkboxValue = index;
                                });
                                  }

                              ,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    address[index].recipientName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),   Text(
                                    address[index].address,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: SizedBox(
                                  height: 1,
                                )),
                            IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                API(context).Delete('user/delete/shipping/${address[index].id}').then((value) {
                                  if (value != null) {
                                    if (value['status_code'] == 200) {
                                      showDialog(
                                          context: context,
                                          builder: (_) => ResultOverlay(
                                              value['message']));
                                      getAddress();
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (_) => ResultOverlay(
                                              value['message']));
                                    }
                                  }
                                });
                              },
                            )
                          ],
                        )),
                  );
                },
          ),
        ),
                Center(
                  child: GestureDetector(
                    child: Container(
                      width: ScreenUtil.getWidth(context) / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
                      child: Center(
                        child: AutoSizeText(
                          getTransrlate(context, 'AddNewAddress'),
                          overflow: TextOverflow.ellipsis,
                          maxFontSize: 14,
                          maxLines: 1,
                          minFontSize: 10,
                          style:
                          TextStyle(fontWeight: FontWeight.bold, color: Colors.orange),
                        ),
                      ),
                    ),
                    onTap: () {
                    Nav.route(context, AddAddress());
                    },
                  ),
                )
              ],
            ),
      ),
    );
  }

  void getAddress() {
    API(context).get('user/all/shippings').then((value) {
      if (value != null) {
        setState(() {
          address = ShippingAddress.fromJson(value).data;
        });
      }
    });
  }
}