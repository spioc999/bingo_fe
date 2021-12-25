import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseWidget extends StatelessWidget {

  final Widget child;
  final bool safeAreaBottom;
  final bool safeAreaTop;
  final BottomAppBar? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final WillPopCallback? onWillPop;
  final SystemUiOverlayStyle? overlayStyle;
  final Color backgroundColorBody;

  const BaseWidget({
    Key? key,
    required this.child,
    this.safeAreaBottom = false,
    this.safeAreaTop = false,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.onWillPop,
    this.overlayStyle,
    this.backgroundColorBody = Colors.white
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: onWillPop != null && onWillPop is WillPopCallback ? () => onWillPop!() : () => Future.value(true),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle ?? SystemUiOverlayStyle.dark,
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: bottomNavigationBar,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          body: Center(
            child: SafeArea(
              top: safeAreaTop,
              bottom: safeAreaBottom,
              child: Container(
                color: backgroundColorBody,
                width: double.infinity,
                height: double.infinity,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
