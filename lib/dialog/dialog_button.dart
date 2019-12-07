import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  double height = 8;
  BorderRadius borderRadius;
  bool isTopCornerRound;
  bool isBottomCornerRound;
  String txt;

  DialogButton({
    this.txt = "",
    this.isTopCornerRound = false,
    this.isBottomCornerRound = false
  }){
    borderRadius = BorderRadius.vertical(
      top: isTopCornerRound ? Radius.circular(height) : null,
      bottom: isBottomCornerRound ? Radius.circular(height) : null,
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      ClipRRect(
          borderRadius: borderRadius,
          child: Container(
              color:  Colors.black12,
              child:  FlatButton(
                child: Text(txt),
              )
          )
      );
  }

}