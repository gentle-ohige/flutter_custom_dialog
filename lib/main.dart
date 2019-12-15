import 'package:flutter/material.dart';
import 'package:flutter_app/app_provider.dart';
import 'package:flutter_app/dialog/dialog_bloc.dart';
import 'package:flutter_app/dialog/dialog_button.dart';

import 'dialog/dialog_contents_wrap.dart';
import 'dialog/dialog_screen.dart';

// 最上位Blocを用意して囲みます
void main() => runApp(AppProvider(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Stack(
        children: <Widget>[
          MyHomePage(),
          DialogScreen(
            dialogBloc: AppProvider.of(context).dialogBloc,
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {


  GlobalKey screenKey = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          child:
          RepaintBoundary(
              key: screenKey,
              child:Scaffold(

                backgroundColor: Colors.yellow,
                body:  Center(
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          onPressed: (){
                            showScreenDialog();
                          },
                          child: Text(
                              'Show Dialog',
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blueAccent)
                          ),

                        ),
                      ],
                    )
                ),
              )
          )
        ),
      ],
    );
  }

  Widget showScreenDialog() {
    AppProvider.showDialog(
        context,
        BaseDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DialogContentsWarp(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1 / 2,
                    child:  FutureBuilder<Uint8List>(
                    future: ScreenShot.screenCapture(screenKey),
                    builder: (context, snapshot){
                      if(!snapshot.hasData) {
                        return Center(
                          child: Container(
                            height: 64,
                            width: 64,
                            child: CircularProgressIndicator()
                          ),
                        );
                      }
                      return  Image.memory(snapshot.data);
                    },
                  )
                )
              ),
              SizedBox(
                height: 24,
              ),
              DialogButton(
                isTopCornerRound: true,
                 txt: "ShowModal",
                  onPressed: (){
                    showBottomModal();
                  },
              ),
              SizedBox(
                height: 2,
              ),
              DialogButton(
                isBottomCornerRound: true,
                txt: "Close",
                onPressed: (){
                  AppProvider.popDialog(context);
                },
              ),
            ],
          )
        )
    );
  }

  Widget showBottomModal() {
    AppProvider.showDialog(
        context,
        BaseDialog(
            type: DialogType.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                DialogButton(
                  isTopCornerRound: true,
                  txt: "Button01",
                  onPressed: (){

                  },
                ),
                SizedBox(
                  height: 2,
                ),
                DialogButton(
                  txt: "Button01",
                  onPressed: (){

                  },
                ),
                SizedBox(
                  height: 2,
                ),
                DialogButton(
                  txt: "Close",
                  onPressed: (){
                    AppProvider.popDialog(context);
                  },
                ),
                Container(
                  height: 24,
                  color: Colors.black12,
                )
              ],
            )
        )
    );
  }
}
