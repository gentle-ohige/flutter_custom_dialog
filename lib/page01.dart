
import 'package:flutter/material.dart';
import 'package:flutter_app/app_provider.dart';
import 'package:flutter_app/dialog/dialog_bloc.dart';

class Page01 extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: Colors.yellow,
      body:  Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () async {
                AppProvider.showDialog(
                    context: context,
                    dialog: BaseDialog(
                      child:  GestureDetector(
                        onTap: (){
                          AppProvider.showDialog(
                              context: context,
                              dialog: BaseDialog(
                                  child:  GestureDetector(
                                    onTap: (){
                                    },
                                    child:  Container(
                                      height: 300,
                                      width: 400,
                                      color: Colors.yellowAccent,
                                    ),
                                  )
                              )
                          );
                        },
                        child:  Container(
                          height: 400,
                          width: 500,
                          color: Colors.blueAccent,
                        ),
                      )
                    )
                 );
//                showDialog(context:context, builder: (context){
//                  return SimpleDialog(
//                    children: <Widget>[
//                      GestureDetector(
//                        onTap: (){
//                          showDialog(context:context, builder: (context){
//                            return SimpleDialog(
//                              children: <Widget>[
//                                Container(height: 350,width: 250,color:
//                                Colors.grey)
//                              ],
//                            );
//
//                          });
//                        },
//                        child: Container(height: 500,width: 400,color:
//                        Colors.blueAccent)
//                      )
//
//                    ],
//                  );
//
//                });
              },
              child: Text(
                  'PAGE_01',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueAccent)
              ),
            )
          ],
        )
      ),
    );
  }

}