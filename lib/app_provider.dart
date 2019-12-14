
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/dialog/dialog_bloc.dart';
import 'package:flutter_app/dialog/dialog_screen.dart';

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


  static void showDialog({BuildContext context,BaseDialog dialog}) {
    final AppProviderState result = context.ancestorStateOfType(const TypeMatcher<AppProviderState>());
    result.showDialog(dialog);

  }

  static void popDialog({BuildContext context}) {
    final AppProviderState result = context.ancestorStateOfType(const TypeMatcher<AppProviderState>());
    result.popDialog();
  }

  static void inspectDialog({BuildContext context}) {
    final AppProviderState result = context.ancestorStateOfType(const TypeMatcher<AppProviderState>());
    result.insepectDialog();
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppProviderState();
  }

}

class AppProviderState extends State<AppProvider> {

  @override
  void initState() {
    super.initState();
  }

  void showDialog(BaseDialog dialog) {
    setState(() {
      widget.dialogBloc.showDialog(dialog: dialog);
    });
  }

  void popDialog(){
    setState(() {
      widget.dialogBloc.popDialog();
    });
  }

  void insepectDialog(){
    setState(() {
      widget.dialogBloc.inspectDialogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _AppProvider(
      key: widget.key,
      child:  Stack(
        children: <Widget>[

          widget.child,
          DialogScreen(
            dialogBloc: widget.dialogBloc,
          )
        ],
      ),
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