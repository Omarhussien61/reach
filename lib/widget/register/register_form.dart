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
  bool passwordVisible = false;
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
                  labelText: getTransrlate(context, 'name'),
                  hintText: getTransrlate(context, 'name'),
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
                  labelText: getTransrlate(context, 'City'),
                  hintText: getTransrlate(context, 'City'),
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
                  labelText: getTransrlate(context, 'district'),
                  hintText: getTransrlate(context, 'district'),
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
                  labelText: getTransrlate(context, 'Addres'),
                  hintText: getTransrlate(context, 'Addres'),
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
                  labelText: getTransrlate(context, 'phone'),
                  hintText: getTransrlate(context, 'phone'),
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
                  labelText: getTransrlate(context, 'password'),
                  hintText: getTransrlate(context, 'password'),
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
                    } else if (!value.contains(new RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'))) {
                      return "${getTransrlate(context, 'invalidpass')}";
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
                  hintText: getTransrlate(context, 'ConfirmPassword'),
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
    API(context).post('user/register', {
      'name': model.Name,
      'email': model.email,
      'password': model.password,
      "password_confirmation": model.password_confirmation,
    }).then((value) {
      if (!value.containsKey('errors')) {
        setState(() => _isLoading = false);
        var user = value['data'];
        //   prefs.setString("user_email", user['email']);
        // //  prefs.setString("email_verified_at", user['email_verified_at']);
        //   if (user.containsKey('vendor_details')) {
        //     prefs.setInt(
        //         "complete", user['vendor_details']['complete']);
        //     prefs.setString("vendor", 'vendor');
        //   }
        //   prefs.setString("user_name", user['name']);
        //   prefs.setString("token", user['token']);
        //   prefs.setInt("user_id", user['id']);
        //   themeColor.setLogin(true);
        showDialog(
                context: context,
                builder: (_) => ResultOverlay('${value['message']}'))
            .whenComplete(() {
          Nav.routeReplacement(context, LoginPage());
        });

        // Navigator.pushAndRemoveUntil(
        //     context, MaterialPageRoute(builder: (_) => Account()), (r) => false);
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                ResultOverlay('${value['message']}\n${value['errors']}'));

        setState(() => _isLoading = false);
      }
    });
  }
}
