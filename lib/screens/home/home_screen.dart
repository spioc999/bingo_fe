import 'package:bingo_fe/base/base_widget.dart';
import 'package:bingo_fe/helpers/image_helper.dart';
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
  final FocusNode _roomCodeNode = FocusNode();
  final FocusNode _roomNameNode = FocusNode();

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
      overlayStyle: SystemUiOverlayStyle.dark,
      resizeToAvoidBottomInset: true,
      child: _buildChild(),
    );
  }

  _buildChild(){
    return Consumer<HomeNotifier>(
        builder: (_, notifier, __) => Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.red.withOpacity(0.8)
                  ]
                ),
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(25.0)),
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10 + MediaQuery.of(context).viewPadding.top,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageHelper.getPng('logo', height: 40, fit: BoxFit.fitHeight),
                      const SizedBox(width: 10,),
                      const BoldText('BINGO', fontSize: 26),
                    ],
                  ),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            ScrollingExpandedWidget(
              child: SizedBox(
                width: MediaQuery.of(context).size.width > 750 ? 750 : MediaQuery.of(context).size.width,
                child: _buildForm(notifier)
              )
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
          AppFormFieldWidget(
            controller: notifier.nicknameController,
            focusNode: _nicknameNode,
            prefixIcon: Icons.account_circle_outlined,
            hintText: 'Nickname*',
            onChanged: (value) => notifier.onNicknameChanged(value),
          ),
          const SizedBox(height: 50,),
          const BoldText('CREATE ROOM', color: Colors.black87, fontSize: 18,),
          const SizedBox(height: 10,),
          AppFormFieldWidget(
            controller: notifier.roomNameController,
            focusNode: _roomNameNode,
            prefixIcon: Icons.drive_file_rename_outline,
            hintText: 'Room name',
            onChanged: (value) => notifier.onRoomNameChanged(value),
          ),
          const SizedBox(height: 10,),
          AppButton(
            text: 'Start new room',
            enabled: notifier.canStartNewRoom,
            onTap: () {FocusScope.of(context).requestFocus(FocusNode()); notifier.onTapStartNewRoom();},
            isLoading: notifier.startRoomLoading,
          ),
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
                Expanded(
                  child: Divider(
                    color: Colors.grey
                  )
                )
              ],
            ),
          ),
          const SizedBox(height: 30,),
          const BoldText('JOIN ROOM', color: Colors.black87, fontSize: 18,),
          const SizedBox(height: 10,),
          AppFormFieldWidget(
            controller: notifier.roomCodeController,
            focusNode: _roomCodeNode,
            prefixIcon: Icons.supervised_user_circle_outlined,
            textCapitalization: TextCapitalization.characters,
            hintText: 'Room code',
            maxLength: 5,
            onChanged: (value) => notifier.onRoomCodeChanged(value),
          ),
          const SizedBox(height: 10,),
          AppButton(text: 'Connect',
            enabled: notifier.canConnectToRoom,
            onTap: () {FocusScope.of(context).requestFocus(FocusNode()); notifier.onTapConnectRoom();},
            isLoading: notifier.connectToRoomLoading,
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
