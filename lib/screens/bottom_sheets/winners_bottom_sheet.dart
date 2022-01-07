import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/services/models/winner_message_socket.dart';
import 'package:bingo_fe/widget/common/top_rounded_container.dart';
import 'package:bingo_fe/widget/texts/bold_text.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';

class WinnersBottomSheet extends StatelessWidget with RouteMixin{

  final Map<WinTypeEnum, List<String>> winners;
  final String userNickname;

  const WinnersBottomSheet({Key? key, required this.winners, required this.userNickname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sortedKeys = winners.keys.toList()..sort((a, b) => a.number.compareTo(b.number));
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
                    const SizedBox(width: 30,),
                    const RomanText(
                      'WINNERS', textAlign: TextAlign.center, fontSize: 16, maxLines: 6,
                    ),
                    SizedBox(
                      width: 30,
                      height: 20,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
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
                ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    final key = sortedKeys[index];
                    var users = '';
                    winners[key]?.forEach((username) {
                      users += '${username == userNickname ? 'YOU' : username}, ';
                    });
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          BoldText(key.name),
                          RomanText(': ${users.substring(0, users.length - 2)}'),
                        ],
                      ),
                    );
                  },
                  itemCount: sortedKeys.length,
                )
              ],
            ),
          ),
        )
    );
  }
}
