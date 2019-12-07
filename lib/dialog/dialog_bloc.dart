
import 'dart:async';

import 'package:flutter/cupertino.dart';

class DialogBloc {

  List<DialogViewState> states;
  StreamController<List<DialogViewState>> dialogStateController;
  Stream<List<DialogViewState>> get dialogStatesStream => dialogStateController.stream;
  Sink<List<DialogViewState>> get dialogStatesSink => dialogStateController.sink;



  DialogBloc(){
    dialogStateController = StreamController<List<DialogViewState>>.broadcast();
    states = [];
    dialogStateController.add([]);
  }

  void dispose() {
    dialogStateController.close();
  }

  void showDialog({DialogInterface interface}) async {
    states.add(DialogViewState(interface: interface));
    dialogStatesSink.add(states);
  }

  void popDialog() async {
    if(states.length == 0)return;
    states.last.isShow = false;
    dialogStatesSink.add(states);
  }

  void inspectDialogStates() async {
    states = states.where((state)=> state.isShow).toList();
    dialogStatesSink.add(states);
  }
}

class DialogInterface {
  Widget child;
  Function outSideTapped;

  DialogInterface({
    @required this.child,
    this.outSideTapped
  });

}

class DialogViewState {
  DialogInterface interface;
  bool isShow = true;

  DialogViewState({
    @required this.interface,
  });

}