
import 'package:flutter/cupertino.dart';

class SlideAnimationWrap extends StatefulWidget {

  final Duration duration;
  final Curve animationCurve;
  final bool isExpanded;

  final Function(AnimationStatus) animateStateListener;
  final Widget child;

  SlideAnimationWrap({
    this.duration = const Duration(milliseconds: 400),
    this.animationCurve = Curves.ease,
    this.isExpanded = true,
    this.child,
    this.animateStateListener
  });

  @override
  State<StatefulWidget> createState() {
    return _SlideAnimationWrap();
  }

}

class _SlideAnimationWrap extends State<SlideAnimationWrap> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation<Offset> _expandAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
      reverseDuration: widget.duration,

    );

    _expandAnimation = _controller
        .drive(CurveTween(curve: Curves.easeInOut))
        .drive(Tween<Offset>(
        begin:const Offset(2, 0),
        end: const Offset(0, 0)));

    if( widget.animateStateListener != null)
      _expandAnimation.addStatusListener(widget.animateStateListener);

    if(widget.isExpanded){
      _controller.value = 0;
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(SlideAnimationWrap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget.isExpanded != widget.isExpanded) {
      if (widget.isExpanded) {
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
    return SlideTransition(
      position: _expandAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}