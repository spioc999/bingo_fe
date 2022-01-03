import 'package:flutter/material.dart';

class ScrollingExpandedWidget extends StatelessWidget {

  final Widget child;
  final ScrollPhysics? physics;

  const ScrollingExpandedWidget({required this.child, this.physics, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
          physics: physics ?? const BouncingScrollPhysics(),
          child: child,
        )
    );
  }
}