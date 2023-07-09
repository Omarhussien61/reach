
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/category_tickit.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:url_launcher/url_launcher.dart';

class Tickits extends StatefulWidget {
  const Tickits({Key key,this.vendor_id,this.order_id,this.product_id}) : super(key: key);
 final  String order_id, vendor_id,product_id;

  @override
  _TickitsState createState() => _TickitsState();
}

class _TickitsState extends State<Tickits> {
  final _formKey = GlobalKey<FormState>();
  String typeTickit, addressTickit, messageTickit, priortyTickit,category_id;
  List<Categorytickit> _data;
  List<Categorytickit> priorty;
  File attachment;
bool    loading = false;

  @override
  void initState() {
API(context).get('ticket/categorieslist')..then((value) {
  if (value != null) {
    setState(() {
      _data = Category_tickit.fromJson(value).data;
    });
  }
});API(context).get('ticket/priority/list')..then((value) {
  if (value != null) {
    setState(() {
      priorty = Category_tickit.fromJson(value).data;
    });
  }
});
super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.local_shipping_outlined,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Container(
                width: ScreenUtil.getWidth(context) / 2,
                child: AutoSizeText(
                  '${getTransrlate(context, 'Myorders')}',
                  minFontSize: 10,
                  maxFontSize: 16,
                  maxLines: 1,
                )),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil.getWidth(context) / 10),
            child: Column(
              children: [
                _data == null
                    ? Container()
                    : DropdownSearch<Categorytickit>(

                      label:"${getTransrlate(context, 'typeTickit')}",
                      validator: (Categorytickit item) {
                        if (item == null) {
                          return "${getTransrlate(context, 'Required')}";
                        } else
                          return null;
                      },
                      items: _data,
                      //  onFind: (String filter) => getData(filter),
                      itemAsString: (Categorytickit u) => u.name,
                      onChanged: (Categorytickit data) =>
                      category_id = data.id.toString(),
                    ),
                SizedBox(height: 16,),
                priorty == null
                    ? Container()
                    : DropdownSearch<Categorytickit>(
                  label: " ${getTransrlate(context, 'priortyTickit')} ",
                  validator: (Categorytickit item) {
                    if (item == null) {
                      return "${getTransrlate(context, 'Required')}";
                    } else
                      return null;
                  },
                  items: priorty,
                  //  onFind: (String filter) => getData(filter),
                  itemAsString: (Categorytickit u) => u.name,
                  onChanged: (Categorytickit data) =>
                  priortyTickit = data.id.toString(),
                ),
                SizedBox(height: 16,),
                // MyTextFormField(
                //   intialLabel: 'low',
                //   Keyboard_Type: TextInputType.emailAddress,
                //   labelText: '${getTransrlate(context, 'priortyTickit')}',
                //   hintText: '${getTransrlate(context, 'priortyTickit')}',
                //   isPhone: true,
                //   validator: (String value) {
                //     if (value.isEmpty) {
                //       return '${getTransrlate(context, 'priortyTickit')} (low & high)';
                //     }
                //     _formKey.currentState.save();
                //     return null;
                //   },
                //   onSaved: (String value) {
                //     addressTickit = value;
                //   },
                // ),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.emailAddress,
                  labelText: '${getTransrlate(context, 'addressTickit')}',
                  hintText: '${getTransrlate(context, 'addressTickit')}',
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return '${getTransrlate(context, 'addressTickit')}';
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    typeTickit = value;
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(onTap: (){
                    getAttachment();
                  },
                    child: Container(
                      width: ScreenUtil.getWidth(context) /
                          1.5,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.orange,
                              width: 1)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Center(child: Row(mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.upload_outlined,color: Colors.orange,),
                            Text('${getTransrlate(context, 'Attach')}',style: TextStyle(color: Colors.orange),),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
                attachment == null
                    ? Container()
                    : Container(
                        child: Row(
                          children: [
                            Container(
                              width: ScreenUtil.getWidth(
                                  context) /
                                  2.5,
                              child: Text(
                                "${attachment
                                    .path}",
                                maxLines: 1,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                CupertinoIcons
                                    .clear_circled,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  attachment = null;
                                });
                              },
                            ),
                          ],
                        )),
                MyTextFormField(
                  intialLabel: '',
                  keyboard_type: TextInputType.emailAddress,
                  labelText: '${getTransrlate(context, 'massage')}',
                  hintText: '${getTransrlate(context, 'massage')}',
                  isPhone: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return '${getTransrlate(context, 'massage')}';
                    }
                    _formKey.currentState.save();
                    return null;
                  },
                  onSaved: (String value) {
                    messageTickit = value;
                  },
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child:  loading?TextButton(
                        style:getStyleButton( Colors.orange),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:Container(
                            height: 30,
                            child: Center(
                                child: CircularProgressIndicator(
                                  valueColor:
                                  AlwaysStoppedAnimation<Color>( Colors.white),
                                )),
                          ),
                        ),
                        onPressed: () async {
                        },
                      ):GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 3,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(border: Border.all(
                              color: Colors.orange)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'save'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style:
                              TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.orange),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            setState(() => loading = true);
                            API(context).postFile('new/ticket',
                                {
                                  "title": typeTickit??' ',
                                  "ticketpriority_id": priortyTickit??' ',
                                  "message": messageTickit??' ',
                                  "order_id": widget.order_id??'',
                                  "vendor_id": widget.vendor_id??'',
                                  "category_id": category_id??'',
                                  "product_id": widget.product_id??''
                                },attachment: attachment).then((value) {
                              if (value != null) {                              setState(() => loading = true);

                              setState(() => loading = false);

                              if (value['status_code'] == 201) {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay(value['message']));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (_) =>
                                        ResultOverlay("${value['message']}\n${value['errors']}"));
                              }
                              }
                            });
                          }
                        },
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        child: Container(
                          width: ScreenUtil.getWidth(context) / 3,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(border: Border.all(
                              color: Colors.grey)),
                          child: Center(
                            child: AutoSizeText(
                              getTransrlate(context, 'close'),
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 14,
                              maxLines: 1,
                              minFontSize: 10,
                              style:
                              TextStyle(fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        onTap: () {

                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),);
  }
  getAttachment() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      attachment = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

}
