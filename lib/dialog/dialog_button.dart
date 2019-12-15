import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  String txt;
  Function onPressed;
  double cornerHeight = 8;
  BorderRadius borderRadius;
  bool isTopCornerRound;
  bool isBottomCornerRound;


  DialogButton({
    this.txt = "",
    this.onPressed,
    this.isTopCornerRound = false,
    this.isBottomCornerRound = false
  }){
    borderRadius = BorderRadius.vertical(
      top: isTopCornerRound ? Radius.circular(cornerHeight) :  Radius.circular(0),
      bottom: isBottomCornerRound ? Radius.circular(cornerHeight) : Radius.circular(0),
    );
  }


  @override
  Widget build(BuildContext context) {
    return
      ClipRRect(
          borderRadius: borderRadius,
          child:
          Container(
              height: 40,
              width: MediaQuery.of(context).size.width,
              color:  Colors.black12,
              child:  FlatButton(
                child: Text(txt),
                onPressed: onPressed,
              )
          )
      );
  }

}