import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class Support_Screen extends StatelessWidget {
   Support_Screen({Key key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
            width: ScreenUtil.getWidth(context) / 2,
            child: AutoSizeText(
              '${getTransrlate(context, 'Support')}',
              minFontSize: 10,
              maxFontSize: 16,
              maxLines: 1,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '${getTransrlate(context, 'Saudi')}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 15,
                ),
                Text(
                  '${getTransrlate(context, 'contact')}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // Set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(10.0)), // Set rounded corner radius
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black12,
                              offset: Offset(1, 3))
                        ] // Make rounded corner of border
                    ),
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            MyTextFormField(
                              labelText: getTransrlate(context, 'name'),
                              hintText: getTransrlate(context, 'name'),
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return getTransrlate(context, 'requiredempty');
                                }
                                return null;
                              },
                              onSaved: (String value) {
                                //model.Name = value;
                              },
                            ),
                            MyTextFormField(
                              labelText: getTransrlate(context, 'Email'),
                              hintText: getTransrlate(context, 'Email'),
                              isEmail: true,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return getTransrlate(context, 'requiredempty');
                                } else if (!RegExp(
                                    r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                                    .hasMatch(value)) {
                                  return getTransrlate(context, 'invalidemail');
                                }
                                _formKey.currentState.save();
                                return null;
                              },
                              onSaved: (String value) {
                                // model.email = value;
                              },
                            ),
                            MyTextFormField(
                              labelText: getTransrlate(context, 'phone'),
                              hintText: getTransrlate(context, 'phone'),
                              isEmail: true,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return getTransrlate(context, 'requiredempty');
                                }
                                _formKey.currentState.save();
                                return null;
                              },
                              onSaved: (String value) {
                                // model.email = value;
                              },
                            ),
                            MyTextFormField(
                              labelText: getTransrlate(context, 'massage'),
                              hintText: getTransrlate(context, 'massage'),
                              isEmail: true,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return getTransrlate(context, 'requiredempty');
                                }
                                _formKey.currentState.save();
                                return null;
                              },
                              onSaved: (String value) {
                                // model.email = value;
                              },
                            ),
                            Container(
                              height: 40,
                              width: ScreenUtil.getWidth(context),
                              margin: EdgeInsets.only(top: 12, bottom: 0),
                              child: TextButton(
                                style:getStyleButton( Colors.orange),

                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    Navigator.pop(context);
                                    showDialog(
                                        context: context,
                                        builder: (_) => ResultOverlay('  سيتم التواصل معكم فى اقرب وقت '
                                            ));
                                  }
                                },
                                child: Text(
                                  getTransrlate(context, 'Submit'),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
