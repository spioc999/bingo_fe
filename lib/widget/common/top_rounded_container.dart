import 'package:flutter/material.dart';

class TopRoundedContainer extends StatelessWidget {

  final Widget child;
  final double? height;
  final Color color;

  const TopRoundedContainer({required this.child, this.height, this.color = Colors.white, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(1, 0), // changes position of shadow
            ),
          ],
        ),
        height: height,
        child: child,
      ),
    );
  }
}