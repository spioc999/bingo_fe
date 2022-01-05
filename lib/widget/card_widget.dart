import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {

  final CardModel cardModel;

  const CardWidget({required this.cardModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Card(
        shadowColor: cardModel.color,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RomanText('Card ${cardModel.id}'),
              const SizedBox(height: 5,),
              Divider(color: cardModel.color,),
              const SizedBox(height: 5,),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(cardModel.columns?.length ?? 0,
                  (i) {
                    final column = cardModel.columns![i];
                    return Column(
                      children: List.generate(column.numbers.length,
                        (j) {
                          final mapNumber = column.numbers[j];
                          final number = int.tryParse(mapNumber.keys.toList()[0]);
                          final extracted = mapNumber.values.toList()[0];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: (number ?? 0) < 10 ? 6 : 2
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 3.5,
                                horizontal: (number ?? 0) < 10 ? 5 : 3.5
                              ),
                              decoration: BoxDecoration(
                                color: extracted ? cardModel.color : Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: RomanText(
                                '$number',
                                fontSize: 18,
                                color: number == 0 ? Colors.white : Colors.black,
                              ),
                            ),
                          );
                        }
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
