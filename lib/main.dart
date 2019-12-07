import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/app_provider.dart';
import 'package:flutter_app/dialog/dialog%20contents_wrap.dart';
import 'package:flutter_app/dialog/dialog_bloc.dart';
import 'package:flutter_app/dialog/dialog_button.dart';
import 'package:flutter_app/dialog/dialog_frame.dart';
import 'package:flutter_app/screnn_shot.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloc Dialog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AppProvider(child: MyHomePage()),
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
    // TODO: implement initState
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
                            AppProvider.showDialog(context: context, interface: DialogInterface(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 2 /3,
                                  child: FutureBuilder<Uint8List>(
                                    future: ScreenShot.screenCapture(screenKey),
                                    builder: (context, snapshot){
                                      if(!snapshot.hasData) return Text("Loading");
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.waiting:
                                          // TODO: Handle this case.
                                          return Text("Loading");
                                        default:
                                          return  Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              DialogContentsWarp(
                                                child: Image.memory(snapshot.data)
                                              ),

                                              FlatButton(

                                                child: Container(
                                                    child: Text("Confirm"),
                                                     color:  Colors.black12,
                                                  width:  MediaQuery.of(context).size.width * 1 / 2,
                                                 )

                                              ),

                                              FlatButton(
                                                  child: Container(
                                                    child: Text("Confirm"),
                                                    color:  Colors.black12,
                                                    width:  MediaQuery.of(context).size.width * 1 / 2,
                                                  )
                                              )
                                            ],
                                          );
                                      }

                                    },
                                  ),

                                )));

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

        DialogFrame(bloc: AppProvider.of(context).dialogBloc)
      ],
    );


  }
}
