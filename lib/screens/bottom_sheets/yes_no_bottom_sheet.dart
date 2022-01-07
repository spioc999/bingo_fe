import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/widget/buttons/app_button.dart';
import 'package:bingo_fe/widget/buttons/app_outlined_button.dart';
import 'package:bingo_fe/widget/common/top_rounded_container.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';

class YesNoBottomSheet extends StatelessWidget with RouteMixin{

  final YesNoBottomSheetEnum yesNoType;
  final String? roomName;
  final bool isDismissible;

  const YesNoBottomSheet({required this.yesNoType, this.roomName, this.isDismissible = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title;

    switch(yesNoType) {
      case YesNoBottomSheetEnum.connectToLastRoom:
        title = 'Do you want to continue the previous Bingo game?\nRoom: $roomName';
        break;
    }

    return _buildChild(title, context);
  }

  _buildChild(String title, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width > 750 ? 750 : MediaQuery.of(context).size.width,
      child: TopRoundedContainer(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: MediaQuery.of(context).size.height / 25,
              bottom: MediaQuery.of(context).size.height / 25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RomanText(
                  title, textAlign: TextAlign.center, fontSize: 16, maxLines: 6,
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: AppOutlinedButton(
                        text: 'no',
                        onTap: () {
                          pop(false);
                        },
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width / 22,),
                    Flexible(
                      child: AppButton(
                        text: 'yes',
                        onTap: () {
                          pop(true);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}

enum YesNoBottomSheetEnum {
  connectToLastRoom
}