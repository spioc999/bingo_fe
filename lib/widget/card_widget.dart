import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  //TODO remove that
  CardModel cardModel = CardModel([
    ColumnCard([
      {1: true}, {0: false}, {9: true}
    ]),
    ColumnCard([
      {11: false}, {0: false}, {19: false}
    ]),
    ColumnCard([
      {0: false}, {20: true}, {0: false}
    ]),
    ColumnCard([
      {30: false}, {32: true}, {0: false}
    ]),
    ColumnCard([
      {0: false}, {42: true}, {0: false}
    ]),
    ColumnCard([
      {0: false}, {50: true}, {0: false}
    ]),
    ColumnCard([
      {61: true}, {68: true}, {0: false}
    ]),
    ColumnCard([
      {0: false}, {79: true}, {70: false}
    ]),
    ColumnCard([
      {0: false}, {88: true}, {90: true}
    ])
  ]);

  CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RomanText('Card 1'),
          const SizedBox(height: 5,),
          const Divider(),
          const SizedBox(height: 5,),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(cardModel.columns.length,
              (i) {
                final column = cardModel.columns[i];
                return Column(
                  children: List.generate(column.numbers.length,
                    (j) {
                      final mapNumber = column.numbers[j];
                      final number = mapNumber.keys.toList()[0];
                      final extracted = mapNumber.values.toList()[0];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: number < 10 ? 6 : 2
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.5,
                            horizontal: number < 10 ? 5 : 3.5
                          ),
                          decoration: BoxDecoration(
                            color: extracted ? Colors.green : Colors.white,
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
    );
  }
}
