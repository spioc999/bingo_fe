import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/widget/common/scrolling_flexible_loose_widget.dart';
import 'package:bingo_fe/widget/common/top_rounded_container.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';

class PlayersOnlineBottomSheet extends StatelessWidget with RouteMixin{

  final List<String> players;
  final String userNickname;

  const PlayersOnlineBottomSheet({Key? key, required this.players, required this.userNickname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TopRoundedContainer(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: MediaQuery.of(context).size.height / 25,
            bottom: MediaQuery.of(context).size.height / 20,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width > 750 ? 750 : MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(width: 40,),
                    const RomanText(
                      'PLAYERS', textAlign: TextAlign.center, fontSize: 16, maxLines: 6,
                    ),
                    SizedBox(
                      width: 40,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0,),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () => pop(),
                          child: const Icon(Icons.close),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                ScrollingFlexibleLooseWidget(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: RomanText(players[index] == userNickname ? 'YOU' : players[index]),
                      );
                    },
                    itemCount: players.length,
                  )
                )
              ],
            ),
          ),
        )
    );
  }
}