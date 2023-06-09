import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/screen_size.dart';
class Custom_Loading extends StatelessWidget {
  const Custom_Loading({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getHeight(context) / 4,
      width: ScreenUtil.getWidth(context) / 1.5,
      child: Image.asset(
        'assets/images/logo.png',
      ),
    );
  }
}
