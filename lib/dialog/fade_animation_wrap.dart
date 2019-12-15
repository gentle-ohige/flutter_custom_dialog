
import 'package:flutter/cupertino.dart';

class FadeAnimationWrap extends StatefulWidget {

  final Duration duration;
  final Curve animationCurve;
  final bool isShow;

  final Function(AnimationStatus) animateStateListener;
  final Widget child;

  FadeAnimationWrap({
    this.duration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.ease,
    this.isShow = true,
    this.child,
    this.animateStateListener
  });

  @override
  State<StatefulWidget> createState() {
    return _FadeAnimationWrap();
  }

}

class _FadeAnimationWrap extends State<FadeAnimationWrap> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _expandAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
      reverseDuration: widget.duration,

    );
    _expandAnimation = _controller.drive(CurveTween(curve: widget.animationCurve));
    if( widget.animateStateListener != null)
      _expandAnimation.addStatusListener(widget.animateStateListener);
    if(widget.isShow){
      _controller.value = 0;
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(FadeAnimationWrap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.isShow != widget.isShow) {
      if (widget.isShow) {
        _controller.forward();
      }
      else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return FadeTransition(
        opacity: _expandAnimation,
        child: IgnorePointer(
          ignoring: !widget.isShow,
          child: widget.child,
        )
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}