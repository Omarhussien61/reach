import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/model/user_info.dart';
import 'package:flutter_pos/screens/account/changePasswordPAge.dart';
import 'package:flutter_pos/service/api.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:flutter_pos/widget/custom_loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String name, email;
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();
  bool _isLoading = false;
  bool loading = false;
  User userModal;
  String password;
  final _formKey = GlobalKey<FormState>();
  List<String> items = ["male", "female"];
  TextEditingController _tocontroller = TextEditingController();
  submitForm() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    _isLoading = true;
    try {
      setState(() => _isLoading = false);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: Colors.white,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(getTransrlate(context, 'ProfileSettings'),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              color: Colors.black12,
              width: ScreenUtil.getWidth(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name ?? " "),
                    Text(email ?? " "),
                  ],
                ),
              ),
            ),
            _isLoading
                ? Container(
                    // height: double.infinity,
                    // width: double.infinity,
                    color: Colors.white,
                    child: Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                themeColor.getColor()))))
                : userModal == null
                    ? Custom_Loading()
                    : Container(
                        color: Colors.white,
                        child: Container(
                          color: Colors.white,
                          child: Container(
                            color: Color(0xffFFFFFF),
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        getTransrlate(context, 'Firstname'),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          initialValue: userModal.name,
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(254),
                                          ],
                                          decoration: const InputDecoration(
                                            hintText: "ادخل الاسم",
                                          ),
                                          enabled: !_status,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return getTransrlate(context, 'requiredempty');
                                            }else   if (value.length<=2) {
                                              return "${getTransrlate(context, 'requiredlength')}";
                                            }
                                            return null;
                                          },
                                          autofocus: !_status,
                                          onSaved: (String val) =>
                                              userModal.name = val,
                                          onChanged: (String val) {
                                            userModal.name = val;
                                          },
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0, right: 25.0, top: 25.0),
                                      child: Text(
                                        getTransrlate(context, 'Lastname'),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          initialValue: userModal.lastName,
                                          decoration: const InputDecoration(),
                                          enabled: !_status,
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(254),
                                          ],
                                          validator: (String value) {
                                            // if (value.isEmpty) {
                                            //   return getTransrlate(
                                            //       context, 'Lastname');
                                            // }
                                            // _formKey.currentState.save();
                                            // return null;
                                          },
                                          autofocus: !_status,
                                          onSaved: (String val) =>
                                              userModal.lastName = val,
                                          onChanged: (String val) {
                                            userModal.lastName = val;
                                          },
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Text(
                                          getTransrlate(context, 'mail'),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(200),
                                          ],
                                          initialValue: userModal.email,
                                          decoration: const InputDecoration(),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return getTransrlate(
                                                  context, 'mail');
                                            } else if (!RegExp(
                                                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                                .hasMatch(value)) {
                                              return getTransrlate(
                                                  context, 'invalidemail');
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          enabled:false,
                                          onSaved: (String val) =>
                                              userModal.email = val,
                                          onChanged: (String val) =>
                                              userModal.email = val,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Text(
                                          getTransrlate(context, 'phone'),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 2.0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(17),
                                          ],
                                          initialValue: userModal.phoneNo,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(),
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return getTransrlate(context, 'phone');
                                            }else if (value.length<10) {
                                              return "${getTransrlate(context, 'shorterphone')}";
                                            }
                                            _formKey.currentState.save();
                                            return null;
                                          },
                                          enabled: !_status,
                                          onSaved: (String val) =>
                                              userModal.phoneNo = val,
                                          onChanged: (String val) =>
                                              userModal.CountroyCode = val,
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Text(
                                          getTransrlate(context, 'birthdate'),
                                        )),
                                    InkWell(
                                      onTap: (){
                                        _status?null:  _selectDateto(context);
                                      },
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 25.0, right: 25.0, top: 2.0),
                                          child: TextFormField(
                                            controller: _tocontroller,
                                            keyboardType: TextInputType.datetime,
                                            decoration: InputDecoration(),
                                            inputFormatters: [
                                              new LengthLimitingTextInputFormatter(254),
                                            ],
                                            enabled:false,
                                            validator: (String value) {

                                            },
                                            onSaved: (String val) =>
                                                userModal.birthdate = val,
                                            onChanged: (String val) =>
                                                userModal.birthdate = val,
                                          )),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Text(
                                         getTransrlate(context, 'gender'),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 25.0,
                                          right: 25.0,
                                          top: 10.0,
                                          bottom: 10),
                                      child: DropdownSearch<String>(
                                        maxHeight: 120,
                                        validator: (String item) {
                                          if (item == null) {
                                            return "${getTransrlate(context, 'requiredempty')}";
                                          } else
                                            return null;
                                        },
                                        items: items,
                                        selectedItem: userModal.gender,

                                        enabled: !_status,
                                        //  onFind: (String filter) => getData(filter),
                                        itemAsString: (String u) => u,
                                        onChanged: (String data) =>
                                            userModal.gender = data,
                                      ),
                                    ),
                                    _status
                                        ? _getEditIcon()
                                        : _getActionButtons(),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0, right: 25.0, top: 25.0),
                                        child: Text(
                                          getTransrlate(context, 'password'),
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: 25.0,
                                            right: 25.0,
                                            top: 2.0,
                                            bottom: 10),
                                        child: TextFormField(
                                          inputFormatters: [
                                            new LengthLimitingTextInputFormatter(254),
                                          ],
                                          initialValue: "123456789",
                                          decoration: InputDecoration(
                                              hintText: "ادخل كلمة المرور"),
                                          enabled: !_status,
                                          obscureText: true,
                                        )),
                                    _getChangePassword(),
                                  SizedBox(height: 20,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
          ]),
        ));
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }
  Future<void> _selectDateto(BuildContext context) async {
print(userModal.birthdate);
    final DateTime picked = await showDatePicker(
        context: context,initialDate:userModal.birthdate==null? DateTime(2005):userModal.birthdate.isEmpty? DateTime(2005):DateTime.parse(userModal.birthdate),lastDate: DateTime(2005), firstDate: DateTime(1930));
    if (picked != null)
      setState(() {
        _tocontroller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }
  Widget _getActionButtons() {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
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
                ):InkWell(
                  onTap: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    //  final SharedPreferences prefs = await SharedPreferences.getInstance();
                      setState(() => loading = true);
                      API(context).post('user/edit/profile', {
                        "name": userModal.name,
                        "email": userModal.email,
                        "last_name": userModal.lastName,
                        "phone_no": userModal.phoneNo,
                        "birthdate": userModal.birthdate,
                        "gender": userModal.gender,
                      }).then((value) {
                        if (value != null) {
                          setState(() => loading = false);

                          if (value['status_code'] == 200) {

                            getUser();
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay(value['message']));
                            setState(() {
                              _status = true;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (_) =>
                                    ResultOverlay("${value['errors']??value['message']}" ));
                          }
                        }
                      });
                    }
                  },
                  child: Container(
                      width: ScreenUtil.getWidth(context) / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange)),
                      child: Center(
                        child: Text(
                            getTransrlate(context, 'save'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      )),
                ),
              ),
              flex: 2,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  },
                  child: Container(
                      width: ScreenUtil.getWidth(context) / 2.5,
                      padding: const EdgeInsets.all(10.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child: Text(
    getTransrlate(context, 'cancel'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      )),
                ),
              ),
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _getEditIcon() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context) / 2.5,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'edit'),
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
          setState(() {
            _status = false;
          });
        },
      ),
    );
  }

  Widget _getChangePassword() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: ScreenUtil.getWidth(context) / 2.5,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.orange)),
          child: Center(
            child: AutoSizeText(
              getTransrlate(context, 'changePassword'),
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
          Nav.route(context, changePassword());
        },
      ),
    );
  }

  void getUser() {
    SharedPreferences.getInstance().then((pref) => {
      setState(() {
        name = pref.getString('user_name');
        email = pref.getString('user_email');
      }),
      API(context).get('user/profile/info').then((value) {
        if (value != null) {
          if (value['status_code'] == 200) {
            var user = value['data'];
            pref.setString("user_email", user['email']??' ');
            pref.setString("user_name", user['name']??' ');
            setState(() {
              userModal = UserInformation.fromJson(value).data;
            });
            userModal.birthdate==null?null: _tocontroller.text=DateFormat('yyyy-MM-dd').format(DateTime.parse(userModal.birthdate));
          } else {
            showDialog(
                context: context,
                builder: (_) => ResultOverlay(value['message']));
          }
        }
      })
    });

  }
}
