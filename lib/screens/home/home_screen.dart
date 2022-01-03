import 'package:bingo_fe/base/base_widget.dart';
import 'package:bingo_fe/screens/home/home_notifier.dart';
import 'package:bingo_fe/widget/buttons/app_button.dart';
import 'package:bingo_fe/widget/common/app_form_field.dart';
import 'package:bingo_fe/widget/common/scrolling_expanded_widget.dart';
import 'package:bingo_fe/widget/texts/bold_text.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _nicknameNode = FocusNode();
  final FocusNode _roomNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<HomeNotifier>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      safeAreaTop: true,
      overlayStyle: SystemUiOverlayStyle.dark,
      child: _buildChild(),
    );
  }

  _buildChild(){
    return Consumer<HomeNotifier>(
        builder: (_, notifier, __) => Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(height: 20,),
            const BoldText('Bingo FE', fontSize: 26, color: Colors.red,),
            const SizedBox(height: 50,),
            ScrollingExpandedWidget(
              child: _buildForm(notifier)
            )
          ],
        )
    );
  }

  _buildForm(HomeNotifier notifier){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const RomanText('Insert a nickname to identify you!'),
          const SizedBox(height: 10,),
          AppFormFieldWidget(
            controller: notifier.nicknameController,
            focusNode: _nicknameNode,
            prefixIcon: Icons.account_circle_outlined,
            hintText: 'Nickname',
            onChanged: (value) => notifier.onNicknameChanged(value),
          ),
          const SizedBox(height: 5,),
          const RomanText('This field is mandatory.', fontSize: 12, color: Colors.grey,),
          const SizedBox(height: 50,),
          const RomanText('Insert the room\'s code'),
          const SizedBox(height: 10,),
          AppFormFieldWidget(
            controller: notifier.roomController,
            focusNode: _roomNode,
            prefixIcon: Icons.play_circle_outline,
            hintText: 'Room',
            maxLength: 5,
            onChanged: (value) => notifier.onRoomChanged(value),
          ),
          const SizedBox(height: 10,),
          AppButton(text: 'Connect', enabled: notifier.canContinue && notifier.canConnectToRoom,),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(child: Divider(
                  color: Colors.grey,
                )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: RomanText('or', fontSize: 12, color: Colors.grey,),
                ),
                Expanded(child: Divider(
                    color: Colors.grey
                ))
              ],
            ),
          ),
          const SizedBox(height: 30,),
          AppButton(text: 'Start new room', enabled: notifier.canContinue,),
          const SizedBox(height: 10,),
          const RomanText('You will be the host of the room', color: Colors.grey,),
        ],
      ),
    );
  }
}
