import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/account/Account.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/screens/homepage.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_pos/widget/custom_textfield.dart';
import 'package:flutter_pos/widget/register/register_form_model.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  Model model = Model();
  bool PhoneStatue = false;
  bool passwordVisible = true;
  bool _isLoading = false;
  String CountryNo = '+20';
  String verificationId;
  String errorMessage = '';
  String smsOTP;
  int checkboxValueA = 1;
  final formKey = GlobalKey<FormState>();
  List<String> country = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 36, left: 48),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                MyTextFormField(
                  labelText: getTransrlate(context, 'Firstname'),
                 // hintText: getTransrlate(context, 'Firstname'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    } else if (value.length <= 2) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    model.Name = value;
                  },
                ),
                MyTextFormField(
                  labelText: getTransrlate(context, 'Lastname'),
            //      hintText: getTransrlate(context, 'Lastname'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    } else if (value.length <= 2) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    model.City = value;
                  },
                ),

                //
                //
                // MyTextFormField(
                //   labelText: getTransrlate(context, 'Username'),
                //  // hintText: getTransrlate(context, 'Username'),
                //   validator: (String value) {
                //     if (value.isEmpty) {
                //       return getTransrlate(context, 'requiredempty');
                //     } else if (value.length <= 2) {
                //       return "${getTransrlate(context, 'requiredlength')}";
                //     }
                //     return null;
                //   },
                //   onSaved: (String value) {
                //     model.address = value;
                //   },
                // ),
                MyTextFormField(
                  keyboard_type: TextInputType.number,

                  labelText: getTransrlate(context, 'phone'),
                //  hintText: getTransrlate(context, 'phone'),
                  suffixIcon: Container(width:50,height:50,child: Center(child: Text('+20',textDirection: TextDirection.ltr,))),
                  textDirection: TextDirection.ltr,

                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    } else if (value.length <= 2) {
                      return "${getTransrlate(context, 'requiredlength')}";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    model.phone = "+20${value.startsWith('0')?value.replaceRange(0, 1, ''):value}";
                  },
                ),

                MyTextFormField(
                  labelText: getTransrlate(context, 'password'),
              //    hintText: getTransrlate(context, 'password'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black26,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  isPassword: passwordVisible,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    } else if (value.length < 8) {
                      return getTransrlate(context, 'PasswordShorter');
                    }
                    _formKey.currentState.save();

                    return null;
                  },
                  onSaved: (String value) {
                    model.password = value;
                  },
                ),
                MyTextFormField(
                  labelText: getTransrlate(context, 'ConfirmPassword'),
          //        hintText: getTransrlate(context, 'ConfirmPassword'),
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black26,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  isPassword: passwordVisible,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return getTransrlate(context, 'requiredempty');
                    } else if (value != model.password) {
                      return getTransrlate(context, 'Passwordmatch');
                    }

                    _formKey.currentState.save();

                    return null;
                  },
                  onSaved: (String value) {
                    model.password_confirmation = value;
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
                        setState(() => _isLoading = true);
                        register(themeColor);
                      }
                    },
                    child: Text(
                      getTransrlate(context, 'RegisterNew'),
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
        ),
        _isLoading
            ? Container(
                color: Colors.white,
                height: ScreenUtil.getHeight(context) / 2,
                width: ScreenUtil.getWidth(context),
                child: Custom_Loading())
            : Container()
      ],
    );
  }

  register(Provider_control themeColor) async {
    model.gender = checkboxValueA.toString();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    API(context).post('account/api/register/', {
      'first_name': model.Name,
      'last_name': model.City,
      'phone': model.phone,
      'username': model.phone,
      'password': model.password,
      "rePassword": model.password_confirmation,
    }).then((value) {
      if (!value.containsKey('detail')) {
        setState(() => _isLoading = false);
          prefs.setString("first_name", value['first_name']);
          prefs.setString("last_name", value['last_name']);
        //  prefs.setString("email_verified_at", user['email_verified_at']);

          prefs.setString("username", value['username']);
        //  prefs.setString("token", value['token']);
          prefs.setString("password", value['password']);
          themeColor.setLogin(true);
        showDialog(
                context: context,
                builder: (_) => ResultOverlay('تم التسجيل برجاء تسجيل الدخول الان'))
            .whenComplete(() {
          Nav.routeReplacement(context, LoginPage());
        });
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                ResultOverlay('${value['message']}\n${value['detail']}'));

        setState(() => _isLoading = false);
      }
    });
  }
}
