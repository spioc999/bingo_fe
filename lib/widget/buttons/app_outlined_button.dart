import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final Function? onTap;
  final Function? onLongPress;
  final bool enabled;
  final bool isLoading;

  const AppOutlinedButton({this.text = '', this.onTap, this.enabled = true, this.isLoading = false, this.onLongPress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (isLoading){
      child = const SizedBox(width: 26, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 3.5,));
    }else{
      child = RomanText(text.toUpperCase(), fontSize: 19,);
    }
    return InkWell(
      splashColor: Colors.black,
      borderRadius: const BorderRadius.all(Radius.circular(30.0)),
      onTap: enabled && onTap != null && !isLoading ? () => onTap!() : null,
      onLongPress: enabled && onLongPress != null ? () => onLongPress!() : null,
      child: Container(
        alignment: Alignment.center,
        height: 42,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: Colors.black, width: 0.1),
        ),
        child: SizedBox(height: 26, child: child),
      ),
    );
  }
}
