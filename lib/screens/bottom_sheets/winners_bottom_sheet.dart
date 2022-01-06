import 'package:bingo_fe/services/models/winner_message_socket.dart';
import 'package:bingo_fe/widget/common/top_rounded_container.dart';
import 'package:bingo_fe/widget/texts/bold_text.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';

class WinnersBottomSheet extends StatelessWidget {

  final Map<WinTypeEnum, List<String>> winners;

  const WinnersBottomSheet({Key? key, required this.winners}) : super(key: key);

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const RomanText(
                'WINNERS', textAlign: TextAlign.center, fontSize: 16, maxLines: 6,
              ),
              const SizedBox(height: 20,),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  final key = winners.keys.toList()[index];
                  var users = '';
                  winners[key]?.forEach((username) {
                    users += '$username, ';
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
                itemCount: winners.length,
              )
            ],
          ),
        )
    );
  }
}
