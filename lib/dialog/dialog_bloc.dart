
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/app_provider.dart';


class DialogBloc {

  List<DialogStateController> controllers;
  StreamController _streamController;

  DialogBloc(){
    controllers = [];
  }

  void showDialog({BaseDialog dialog}) async {
    if(controllers.length > 0) {
      controllers.last.state = DialogState.hide;
    }
    controllers.add(DialogStateController(dialog: dialog));
  }

  void popDialog() async {
    if(controllers.length == 0) return;

    controllers.last.state = DialogState.dismiss;
    if( controllers.length >= 2) {
      controllers[controllers.length - 2].state = DialogState.show;
    }
  }

  void inspectDialogs() async {
    // remove last stats
    controllers = controllers.where((dialog)=> dialog.state != DialogState.dismiss).toList();
  }
}


class BaseDialog {
  Widget child;
  Function outSideTapped;
  DialogType type;


  BaseDialog({
    this.child,
    this.outSideTapped,
    this.type = DialogType.center
  });
}


class DialogStateController {
  BaseDialog dialog;
  DialogState state = DialogState.show;

  DialogStateController({
    @required this.dialog,
  });

  bool get isShow {
    return state == DialogState.show;
  }

}

enum DialogType {
  center,
  modal,
}


enum DialogState {
  show,
  hide,
  dismiss,
}
