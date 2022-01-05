import 'package:badges/badges.dart';
import 'package:bingo_fe/base/base_widget.dart';
import 'package:bingo_fe/screens/select_cards/select_cards_notifier.dart';
import 'package:bingo_fe/widget/buttons/app_outlined_button.dart';
import 'package:bingo_fe/widget/card_widget.dart';
import 'package:bingo_fe/widget/common/scrolling_expanded_widget.dart';
import 'package:bingo_fe/widget/texts/bold_text.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SelectCardsScreen extends StatefulWidget {
  const SelectCardsScreen({Key? key}) : super(key: key);

  @override
  _SelectCardsScreenState createState() => _SelectCardsScreenState();
}

class _SelectCardsScreenState extends State<SelectCardsScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<SelectCardsNotifier>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectCardsNotifier>(
      builder: (_, notifier, __) => BaseWidget(
        overlayStyle: SystemUiOverlayStyle.dark,
        safeAreaBottom: true,
        floatingActionButton: Badge(
          badgeColor: Colors.black,
          badgeContent: RomanText('${notifier.selectedCards.length}', fontSize: 14, color: Colors.white,),
          showBadge: true,
          position: BadgePosition.topEnd(top: -1, end: -1),
          child: FloatingActionButton(
            backgroundColor: notifier.selectedCards.isNotEmpty ? Colors.red : Colors.red.shade200,
            onPressed: notifier.selectedCards.isNotEmpty && !notifier.nextLoading ? () => notifier.onTapNext() : () {},
            child: notifier.nextLoading ? const SizedBox(
              height: 26,
              width: 26,
              child: CircularProgressIndicator(color: Colors.black,),
            ) : Icon(
              Icons.navigate_next_outlined,
              color: notifier.selectedCards.isNotEmpty ? Colors.black : Colors.black45,
              size: 35,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        child: _buildChild(notifier),
      )
    );
  }

  _buildChild(SelectCardsNotifier notifier) {
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
              const BoldText('Select cards', fontSize: 26),
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
              RomanText(notifier.nickname, color: Colors.black87,),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Expanded(child: RomanText('Select the cards you prefer and then press on NEXT button.', color: Colors.black87, maxLines: 4,)),
            ],
          ),
        ),
        const SizedBox(height: 20,),
        ScrollingExpandedWidget(
            child: _buildCards(notifier)
        ),
        const SizedBox(height: 40,),
      ],
    );
  }

  _buildCards(SelectCardsNotifier notifier) {
    if(notifier.cards.isEmpty){
      return const IgnorePointer();
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (_, index) {
        final card = notifier.cards[index];
        final isSelected = notifier.selectedCards.contains(card.id);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Badge(
              badgeColor: Colors.black,
              badgeContent: const Icon(Icons.check, color: Colors.white, size: 20,),
              showBadge: isSelected,
              position: BadgePosition.topEnd(top: 5, end: 10),
              child: InkWell(
                onTap: () => notifier.onTapCard(card.id ?? -1),
                child: CardWidget(
                  cardModel: card,
                ),
              ),
            ),
            Visibility(
              visible: index == notifier.cards.length - 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 100),
                child: AppOutlinedButton(
                  text: 'Load more',
                  onTap: () => notifier.loadNewBingoPaper(),
                  isLoading: notifier.loadMoreLoading,
                ),
              )
            )
          ],
        );
      },
      itemCount: notifier.cards.length,
    );
  }
}
