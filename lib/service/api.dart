import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pos/screens/Maintenance.dart';
import 'package:flutter_pos/screens/account/login.dart';
import 'package:flutter_pos/utils/Provider/provider.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';
import 'package:flutter_pos/utils/navigator.dart';
import 'package:flutter_pos/widget/ResultOverlay.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  BuildContext context;
  bool Check = true;

  API(this.context, {Check}) {
    if (Check == null) {
      this.Check = true;
    } else {
      this.Check = Check;
    }
  }

  String deviceName;
  String deviceVersion;
  String identifier;

  get(String url) async {
    final full_url =
        Uri.parse('${GlobalConfiguration().getString('base_url')}$url');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.get(full_url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        //'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
        'Accept-Language': Provider.of<Provider_control>(context,listen: false).getlocal(),
      });
      print(full_url);

      return getAction(response);
    } catch (exception, stackTrace) {
      showDialog(
        context: context,
        builder: (_) => ResultOverlay(
            "${getTransrlate(context, 'ConnectionFailed')}"),
      );
    } finally {}
  }

  post(
    String url,
    Map<String, dynamic> body,
  ) async {
    print(body);
    final full_url =
        Uri.parse('${GlobalConfiguration().getString('base_url')}$url');

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("url =${full_url}");
    print("token =${prefs.getString('token')}");

    try {
      http.Response response = await http.post(full_url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          // 'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
            'Accept-Language': Provider.of<Provider_control>(context,listen: false).getlocal(),
          },
          body: json.encode(body));
      return getAction(response);
    } catch (e) {

      showDialog(
        context: context,
        builder: (_) => ResultOverlay(
            "${getTransrlate(context, 'ConnectionFailed')}"),
      );
    } finally {}
  }  patch(
    String url,
    Map<String, dynamic> body,
  ) async {
    print(body);
    final full_url =
        Uri.parse('${GlobalConfiguration().getString('base_url')}$url');

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("url =${full_url}");
    print("token =${prefs.getString('token')}");

    try {
      http.Response response = await http.patch(full_url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          // 'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
            'Accept-Language': Provider.of<Provider_control>(context,listen: false).getlocal(),
          },
          body: json.encode(body));
      return getAction(response);
    } catch (e) {

      showDialog(
        context: context,
        builder: (_) => ResultOverlay(
            "${getTransrlate(context, 'ConnectionFailed')}"),
      );
    } finally {}
  }
  posturl(
    String url,
    Map<String, dynamic> body,
  ) async {
    print( json.encode(body));
    final full_url =
        Uri.parse('${GlobalConfiguration().getString('base_url')}$url');


    try {
      http.Response response = await http.post(full_url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Accept-Language': Provider.of<Provider_control>(context,listen: false).getlocal(),
          },
          body: json.encode(body));
      return getAction(response);
    } catch (e) {

      showDialog(
        context: context,
        builder: (_) => ResultOverlay(
            "${getTransrlate(context, 'ConnectionFailed')}"),
      );
    } finally {}
  }

  postFile(String url, Map<String, String> body,
      {File commercialDocs,
      File taxCardDocs,
      File wholesaleDocs,
      File attachment,
      File bankDocs}) async {
    final full_url =
        Uri.parse('${GlobalConfiguration().getString('base_url')}$url');
    try {
      print(full_url);
      var request = http.MultipartRequest(
        'POST', Uri.parse(full_url.toString())); // your server url
    request.fields.addAll(body); // any other fields required by your server
    attachment==null?null:  request.files.add(await http.MultipartFile.fromPath('image', '${attachment.path}')); // file you want to upload
    commercialDocs==null?null:  request.files.add(await http.MultipartFile.fromPath('commercialDocs', '${commercialDocs.path}')); // file you want to upload
    taxCardDocs==null?null: request.files.add(await http.MultipartFile.fromPath('taxCardDocs', '${taxCardDocs.path}')); // file you want to upload
    wholesaleDocs==null?null: request.files.add(await http.MultipartFile.fromPath('wholesaleDocs', '${wholesaleDocs.path}')); // file you want to upload
    bankDocs==null?null: request.files.add(await http.MultipartFile.fromPath('bankDocs', '${bankDocs.path}')); // file you want to upload
    http.StreamedResponse response = await request.send();
    //print(await request.files);

    return response.stream.bytesToString().then((value) {
      print(jsonDecode(value));
      return jsonDecode(value);
    } );
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => ResultOverlay(
            "${getTransrlate(context, 'ConnectionFailed')}"),
      );
    } finally {}
  }
  Put(String url, Map<String, dynamic> body) async {
    final full_url =
        Uri.parse('${GlobalConfiguration().getString('api_base_url')}$url');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.put(full_url,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token') ?? identifier}',
            'Accept-Language': Provider.of<Provider_control>(context,listen: false).getlocal(),
          },
          body: json.encode(body));
      return getAction(response);
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => ResultOverlay(
            "${getTransrlate(context, 'ConnectionFailed')}"),
      );
    } finally {}
  }
  Delete(String url) async {

    final full_url =
        Uri.parse('${GlobalConfiguration().getString('base_url')}$url');
    print(full_url);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.delete(
        full_url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Accept-Language': Provider.of<Provider_control>(context,listen: false).getlocal(),
        },
      );
      var myDataString = utf8.decode(response.bodyBytes);
      ///obtain json from string
      return jsonDecode(myDataString);
    } catch (e) {
      // showDialog(
      //   context: context,
      //   builder: (_) => ResultOverlay(
      //       "${getTransrlate(context, 'ConnectionFailed')}"),
      // );
    } finally {}
  }
  getAction(http.Response response) {
    print(response.body);
    if (Check) {
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: response.body.toString()
            ));
      } else if (response.statusCode == 401) {
        var myDataString = utf8.decode(response.bodyBytes);
        ///obtain json from string
        var myDataJson = jsonDecode(myDataString);
        return myDataJson;
        // Nav.routeReplacement(context, LoginPage());
      } else {
        var myDataString = utf8.decode(response.bodyBytes);
        ///obtain json from string
        var myDataJson = jsonDecode(myDataString);
        return myDataJson;      }
    } else {
      var myDataString = utf8.decode(response.bodyBytes);
      ///obtain json from string
      var myDataJson = jsonDecode(myDataString);
      return myDataJson;
    }
  }
}
