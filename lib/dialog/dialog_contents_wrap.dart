import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogContentsWarp extends StatelessWidget {
  double height = 8;
  BorderRadius borderRadius;
  final Widget child;

  DialogContentsWarp({this.child}){
    borderRadius = BorderRadius.vertical(
      top: Radius.circular(height),
      bottom: Radius.circular(height),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      ClipRRect(
          borderRadius: borderRadius,
          child: Container(
              padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              color:  Colors.black12,
              child:  child
          )
      );
  }

}
