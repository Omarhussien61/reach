import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/model/product_model.dart';
import 'package:flutter_pos/utils/screen_size.dart';
import 'package:flutter_pos/widget/slider/slider_dot.dart';

class Photo_Slider extends StatefulWidget {
   Photo_Slider({Key key,this.title,this.photos,}) : super(key: key);
  List<PhotoProduct> photos;
  String title;
  @override
  _Photo_SliderState createState() => _Photo_SliderState();
}

class _Photo_SliderState extends State<Photo_Slider> {
  int _carouselCurrentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.title}"),),
      body: Container(
        child:Column(
          children: [
            CarouselSlider(
              items: widget.photos
                  .map((item) => CachedNetworkImage(
                imageUrl: item.image,
                fit: BoxFit.contain,
              ))
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  height: ScreenUtil.getHeight(context) / 1.4,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _carouselCurrentPage = index;
                    });
                  }),
            ),
            SliderDot(_carouselCurrentPage, widget.photos),

          ],
        ),
      ),
    );
  }
}
