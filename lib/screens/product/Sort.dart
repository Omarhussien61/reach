import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/local/LanguageTranslated.dart';

class Sortdialog extends StatefulWidget {
  Sortdialog({Key key, this.character}) : super(key: key);
  String character="ordering=-public_price";

  @override
  _SortdialogState createState() => _SortdialogState();
}

class _SortdialogState extends State<Sortdialog> {
  List characters = ["ordering=public_price", "ordering=-public_price","ordering=-id", "ordering=id"];
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 4),
            height: 72,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Color(0xffCCCCCC),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
                top: 8,
                left: 24,
                right: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${getTransrlate(context, 'Sort')}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff7B7B7B)),
                  ),
                  IconButton(
                      icon:
                          Icon(Icons.close, size: 35, color: Color(0xff7B7B7B)),
                      onPressed: () {
                        Navigator.pop(context, 'ordering=public_price');
                      })
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: RadioListTile<String>(
              title:  Text('${getTransrlate(context, 'SortByPriceLess')}'),
              value: characters[0],
              activeColor: Colors.orange,
              groupValue: widget.character,
              onChanged: (String value) {
                setState(() {
                  widget.character = value;
                  Navigator.pop(context, "${value??'ordering=-public_price'}");
                });
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: RadioListTile<String>(
              title:  Text('${getTransrlate(context, 'SortByPricemore')}'),
              value: characters[1],
              activeColor: Colors.orange,
              groupValue: widget.character,
              onChanged: (String value) {
                setState(() {
                  widget.character = value;
                  Navigator.pop(context, "${value}");
                });
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: RadioListTile<String>(
              title:  Text('${getTransrlate(context, 'SortByNew')}'),
              value: characters[2],
              activeColor: Colors.orange,
              groupValue: widget.character,
              onChanged: (String value) {
                setState(() {
                  widget.character = value;
                    Navigator.pop(context,value);

                });
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: RadioListTile<String>(
              title:  Text('${getTransrlate(context, 'SortByold')}'),
              value: characters[3],
              activeColor: Colors.orange,
              groupValue: widget.character,
              onChanged: (String value) {
                setState(() {
                  widget.character = value;
                    Navigator.pop(context,value);

                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
