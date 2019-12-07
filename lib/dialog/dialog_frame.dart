

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app_provider.dart';
import 'package:flutter_app/dialog/fade_animation_wrap.dart';
import 'dialog_bloc.dart';

class DialogFrame extends StatefulWidget{
  DialogBloc bloc;
  DialogFrame({this.bloc});

  @override
  State<StatefulWidget> createState() {
    return DialogFrameState();
  }
}

class DialogFrameState extends State<DialogFrame> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<List<DialogViewState>>(
      stream: widget.bloc.dialogStatesStream,
      builder: (context, snapshot) {
        if(!snapshot.hasData || snapshot.data.length == 0) {
          return Align(
              alignment: Alignment.topLeft,
              child: SizedBox(height: 0,width: 0)
          );
        }
        DialogViewState viewState = snapshot.data.last;

        return
          Container(
            child: Stack(
              // BackGround

                children:
                [
                  Positioned(
                      top: 0,
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: viewState.interface.outSideTapped ?? (){
                              AppProvider.popDialog(context: context);
                        },
                        child:
                        FadeAnimationWrap(
                          isExpanded: viewState.isShow,
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
                      ),

                  Align(
                      alignment: Alignment.center,
                      child:FadeAnimationWrap(
                          isExpanded: viewState.isShow,
                          child: Container(
                            child: viewState.interface.child,
                            padding: EdgeInsets.fromLTRB(24, 0, 24, 0),
                          ),
                          animateStateListener: (state){
                            switch(state){
                              case AnimationStatus.dismissed:
                                AppProvider.of(context).dialogBloc.inspectDialogStates();
                                break;
                              default: break;
                            }
                          }
                      )
                  ),
                ]
            ),
          );

      },


    );
  }

}