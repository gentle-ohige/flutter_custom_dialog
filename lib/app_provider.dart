
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/dialog/dialog_bloc.dart';

class AppProvider extends StatefulWidget {
  final Widget child;
  DialogBloc dialogBloc;

  AppProvider({
    Key key,
    @required this.child
  }):super(key: key){
    dialogBloc = DialogBloc();
  }

  static _AppProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_AppProvider);
  }

  static void showDialog({BuildContext context, DialogInterface interface}) {
    _AppProvider provider =  context.inheritFromWidgetOfExactType(_AppProvider);
    DialogBloc bloc = provider.dialogBloc;
    bloc.showDialog(interface: interface);
  }

  static void popDialog({BuildContext context}) {
    (context.inheritFromWidgetOfExactType(_AppProvider) as _AppProvider).dialogBloc.popDialog();
  }



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppProviderState();
  }

}

class AppProviderState extends State<AppProvider> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _AppProvider(
      key: widget.key,
      child: widget.child,
      dialogBloc: widget.dialogBloc,
    );
  }

}

class _AppProvider extends InheritedWidget {
  final Widget child;
  final DialogBloc dialogBloc;

  _AppProvider({
    Key key,
    @required this.child,
    @required this.dialogBloc
  });

  @override
  bool updateShouldNotify(_AppProvider oldWidget) {
    // TODO: implement updateShouldNotify
    return dialogBloc != oldWidget.dialogBloc ;
  }

}