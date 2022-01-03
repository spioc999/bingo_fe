import 'package:bingo_fe/widget/texts/bold_text.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String text;
  final Function? onTap;
  final bool enabled;
  final IconData? icon;

  const AppButton({this.text = '', this.onTap, this.enabled = true, this.icon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    if(icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black.withOpacity(enabled ? 1 : 0.6)),
          const SizedBox(width: 8,),
          BoldText(text.toUpperCase(),
            fontSize: 20,
            color: Colors.black.withOpacity(enabled ? 1 : 0.6),),
        ],
      );
    }else{
      child = BoldText(text.toUpperCase(),
        fontSize: 20,
        color: Colors.black.withOpacity(enabled ? 1 : 0.6),);
    }
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.black,
        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
        onTap: enabled && onTap != null ? () => onTap!() : null,
        child: Container(
          alignment: Alignment.center,
          height: 42,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(enabled ? 1 : 0.2),
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.black, width: 0.1),
          ),
          child: child,
        ),
      ),
    );
  }
}
