

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_provider.dart';
import 'package:flutter_app/dialog/fade_animation_wrap.dart';
import 'package:flutter_app/dialog/slide_animation_wrap.dart';
import 'dialog_bloc.dart';

class DialogScreen extends StatefulWidget{
  final DialogBloc dialogBloc;
  DialogScreen({this.dialogBloc});

  @override
  State<StatefulWidget> createState() {
    return DialogScreenState();
  }
}

class DialogScreenState extends State<DialogScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // DilogBlocの制御情報(DialogStateController)をSubscribe
    return StreamBuilder<List<DialogStateController>>(
      stream: widget.dialogBloc.statesStream,
      builder: (context, snapshot) {
        if(!snapshot.hasData || snapshot.data.length == 0) {
          return Align(
              alignment: Alignment.topLeft,
              child: SizedBox(height: 0,width: 0)
          );
        }
        List<Widget> widgets = [];

        // Dialogの背景
        widgets.add(Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: snapshot.data.last.dialog.outSideTapped ?? (){
              AppProvider.popDialog(context);
            },
            child:
            FadeAnimationWrap(
              isShow: widget.dialogBloc.controllers.length > 0,
              child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      color: Color.fromARGB(40, 0, 0, 0),
                    ),
                  )
              ),
            ),
          ),
        ),);

        // Dialogの構成情報より画面を生成
        snapshot.data.forEach(
                (controller){
              widgets.add(
                      (){
                    switch(controller.dialog.type){
                      case DialogType.bottom:
                        return modalDialog(controller);
                      default :
                        return centerDialog(controller);
                    }
                  }()
              );
            }
        );
        return
          Container(
            child: Stack(
                children: widgets
            ),
          );
      },
    );
  }

  Widget centerDialog(DialogStateController controller){
    return  Align(
        alignment: Alignment.center,
        child: FadeAnimationWrap(
            isShow: controller.isShow,
            child: Container(
              child: controller.dialog.child,
              padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
            ),

            animateStateListener: (state){
              switch(state){
                case AnimationStatus.dismissed:
                  AppProvider.inspectDialog(context);
                  break;
                default: break;
              }
            }
        )


    );
  }

  Widget modalDialog(DialogStateController controller){
    return SlideAnimationWrap(
        isShow: controller.isShow,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: controller.dialog.child,
            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
          ),
        ),
        animateStateListener: (state){
          switch(state){
            case AnimationStatus.dismissed:
              AppProvider.inspectDialog(context);
              break;
            default: break;
          }
        }
    );
  }
}