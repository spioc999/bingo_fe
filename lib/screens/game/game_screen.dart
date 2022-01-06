import 'package:bingo_fe/base/base_widget.dart';
import 'package:bingo_fe/screens/game/game_notifier.dart';
import 'package:bingo_fe/widget/buttons/app_button.dart';
import 'package:bingo_fe/widget/buttons/app_outlined_button.dart';
import 'package:bingo_fe/widget/card_widget.dart';
import 'package:bingo_fe/widget/common/scrolling_expanded_widget.dart';
import 'package:bingo_fe/widget/host_paper_widget.dart';
import 'package:bingo_fe/widget/texts/bold_text.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<GameNotifier>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameNotifier>(
      builder: (_, notifier, __) => BaseWidget(
        overlayStyle: SystemUiOverlayStyle.dark,
        safeAreaBottom: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade400,
          onPressed: () => notifier.leaveGame(),
          child: const Icon(
            Icons.exit_to_app_outlined,
            color: Colors.black,
            size: 25,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        child: _buildChild(context, notifier),
      )
    );
  }

  _buildChild(BuildContext context, GameNotifier notifier) {
    return Column(
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
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(25.0)),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10 + MediaQuery.of(context).viewPadding.top,),
              BoldText(notifier.roomName, fontSize: 26),
              const SizedBox(height: 8,),
              BoldText('Room code: ${notifier.roomCode}', fontSize: 14),
              const SizedBox(height: 15,),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.account_circle_outlined, color: Colors.grey,),
              const SizedBox(width: 10,),
              RomanText('${notifier.nickname}${notifier.isHost ? ' (HOST)' : ''}', color: Colors.black87,),
              const Spacer(),
              Visibility(
                  visible: notifier.isHost,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RomanText(notifier.numberUsersConnected.toString(), color: Colors.black87,),
                      const SizedBox(width: 5,),
                      Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle, //TODO
                          )
                      ),
                      const SizedBox(width: 5,),
                    ],
                  )
              )
            ],
          ),
        ),
        const SizedBox(height: 30,),
        ScrollingExpandedWidget(
            child: notifier.isHost ? _buildHostPaper(notifier) : _buildPlayerCards(notifier)
        ),
      ],
    );
  }

  _buildHostPaper(GameNotifier notifier) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: notifier.lastExtractedNumber != null ? Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const RomanText('Last extracted number: ', fontSize: 15,),
              BoldText(notifier.lastExtractedNumber.toString(), fontSize: 17,),
              const SizedBox(width: 30,),
              Expanded(child: AppButton(text: 'EXTRACT', onTap: () => notifier.onTapExtractNumber(), isLoading: notifier.isLoading,))
            ],
          ) : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AppButton(icon: Icons.play_circle_outline,text: 'START GAME', onTap: () => notifier.onTapExtractNumber(), isLoading: notifier.isLoading,),
          ),
        ),
        const SizedBox(height: 40,),
        const BoldText('BANK PAPER', fontSize: 16,),
        const SizedBox(height: 10,),
        HostPaperWidget(hostCards: notifier.cards, color: notifier.cards.first.color,),
        const SizedBox(height: 40,),
      ],
    );
  }

  _buildPlayerCards(GameNotifier notifier) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: notifier.lastExtractedNumber != null ? Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const RomanText('Last extracted number: ', fontSize: 15,),
              BoldText(notifier.lastExtractedNumber.toString(), fontSize: 17,)
            ],
          ) : const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: RomanText('Awaiting for host to start the game!', fontSize: 13, color: Colors.black87,),
          ),
        ),
        const SizedBox(height: 30,),
        const BoldText('Player\'s cards', fontSize: 16,),
        const SizedBox(height: 10,),
        _buildCards(notifier)
      ],
    );
  }

  _buildCards(GameNotifier notifier) {
    if(notifier.cards.isEmpty){
      return const IgnorePointer();
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) {
        final card = notifier.cards[index];
        return CardWidget(
          cardModel: card,
        );
      },
      itemCount: notifier.cards.length,
    );
  }
}
