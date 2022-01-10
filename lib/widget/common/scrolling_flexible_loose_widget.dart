import 'package:flutter/material.dart';

class ScrollingFlexibleLooseWidget extends StatelessWidget {

  final Widget child;
  final ScrollPhysics? physics;

  const ScrollingFlexibleLooseWidget({required this.child, this.physics, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.loose,
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: physics ?? const BouncingScrollPhysics(),
            child: child,
          ),
        )
    );
  }
}