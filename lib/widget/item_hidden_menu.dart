import 'package:flutter/material.dart';
import 'package:flutter_pos/utils/screen_size.dart';

class ItemHiddenMenu extends StatelessWidget {
  /// name of the menu item
  final String name;
  final String lable;

  final Widget icon;

  /// callback to recibe action click in item
  final Function onTap;

  final Color colorLineSelected;

  /// Base style of the text-item.
  final TextStyle baseStyle;

  /// style to apply to text when item is selected
  final TextStyle selectedStyle;

  final bool selected;

  ItemHiddenMenu({
    Key key,
    this.name,
    this.icon,this.lable,
    this.selected = false,
    this.onTap,
    this.colorLineSelected = Colors.blue,
    this.baseStyle,
    this.selectedStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        color:Colors.black26,

        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 10.0, top: 10.0, left: 24),
              child: InkWell(
                onTap: onTap,
                child: Row(
                  children: <Widget>[
                    Container(width: 100, child: icon),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        name,
                        style: (this.baseStyle ??
                                TextStyle(color: Colors.grey, fontSize: 14.0))
                            .merge(this.selected
                                ? this.selectedStyle ??
                                    TextStyle(color: Colors.black, fontSize: 14)
                                : TextStyle(color: Colors.black, fontSize: 14)),
                      ),
                    ),lable==null?Container():lable.isEmpty?Container():Row(
                      children: [
                        Icon(Icons.check,color: Colors.lightGreen,),
                        Container(
                          width: ScreenUtil.getWidth(context)/3,
                          child: Text(
                            "$lable",maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: (this.baseStyle ??
                                    TextStyle(color: Colors.grey, fontSize: 10.0))
                                .merge(this.selected
                                    ? this.selectedStyle ??
                                        TextStyle(color: Colors.black, fontSize: 10)
                                    : TextStyle(color: Colors.black, fontSize: 10)),
                          ),
                        ),
                      ],
                    ),
                    onTap == null
                        ? Container()
                        : Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          )
                  ],
                ),
              ),
            ),
            onTap == null
                ? Container()
                : Container(
                    height: 1,
                    color: Colors.black12,
                  )
          ],
        ),
      ),
    );
  }
}
