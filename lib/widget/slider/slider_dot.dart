import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';

class SliderDot extends StatelessWidget {
  final int _current;
  final List<PhotoProduct> images;
  SliderDot(this._current, this.images);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: images.map((url) {
        int index = images.indexOf(url);
        return Container(
          width: 11.0,
          height: 11.0,
          margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            shape: BoxShape.rectangle,
            color: _current == index ? Colors.orange : Colors.grey,
          ),
        );
      }).toList(),
    );
  }
}
