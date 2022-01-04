import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';

class HostPaperWidget extends StatelessWidget {

  List<CardModel> hostCards = [
    CardModel([
      ColumnCard([
        {1: true}, {11: false}, {21: true}
      ]),
      ColumnCard([
        {2: false}, {12: false}, {22: false}
      ]),
      ColumnCard([
        {3: false}, {13: true}, {23: false}
      ]),
      ColumnCard([
        {4: false}, {14: true}, {24: false}
      ]),
      ColumnCard([
        {5: false}, {15: true}, {25: false}
      ])
    ]),
    CardModel([
      ColumnCard([
        {1: true}, {11: false}, {21: true}
      ]),
      ColumnCard([
        {2: false}, {12: false}, {22: false}
      ]),
      ColumnCard([
        {3: false}, {13: true}, {23: false}
      ]),
      ColumnCard([
        {4: false}, {14: true}, {24: false}
      ]),
      ColumnCard([
        {5: false}, {15: true}, {25: false}
      ])
    ]),
    CardModel([
      ColumnCard([
        {1: true}, {11: false}, {21: true}
      ]),
      ColumnCard([
        {2: false}, {12: false}, {22: false}
      ]),
      ColumnCard([
        {3: false}, {13: true}, {23: false}
      ]),
      ColumnCard([
        {4: false}, {14: true}, {24: false}
      ]),
      ColumnCard([
        {5: false}, {15: true}, {25: false}
      ])
    ]),
    CardModel([
      ColumnCard([
        {1: true}, {11: false}, {21: true}
      ]),
      ColumnCard([
        {2: false}, {12: false}, {22: false}
      ]),
      ColumnCard([
        {3: false}, {13: true}, {23: false}
      ]),
      ColumnCard([
        {4: false}, {14: true}, {24: false}
      ]),
      ColumnCard([
        {5: false}, {15: true}, {25: false}
      ])
    ]),
    CardModel([
      ColumnCard([
        {1: true}, {11: false}, {21: true}
      ]),
      ColumnCard([
        {2: false}, {12: false}, {22: false}
      ]),
      ColumnCard([
        {3: false}, {13: true}, {23: false}
      ]),
      ColumnCard([
        {4: false}, {14: true}, {24: false}
      ]),
      ColumnCard([
        {5: false}, {15: true}, {25: false}
      ])
    ]),
    CardModel([
      ColumnCard([
        {1: true}, {11: false}, {21: true}
      ]),
      ColumnCard([
        {2: false}, {12: false}, {22: false}
      ]),
      ColumnCard([
        {3: false}, {13: true}, {23: false}
      ]),
      ColumnCard([
        {4: false}, {14: true}, {24: false}
      ]),
      ColumnCard([
        {5: false}, {15: true}, {25: false}
      ])
    ])
  ];

  HostPaperWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(hostCards.length != 6){
      return const IgnorePointer();
    }
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHostCard(hostCards[0].columns),
              const SizedBox(height: 80, child: VerticalDivider()),
              _buildHostCard(hostCards[1].columns)
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), child: Divider(),),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHostCard(hostCards[2].columns),
              const SizedBox(height: 80, child: VerticalDivider()),
              _buildHostCard(hostCards[3].columns)
            ],
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), child: Divider(),),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildHostCard(hostCards[4].columns),
              const SizedBox(height: 80, child: VerticalDivider()),
              _buildHostCard(hostCards[5].columns)
            ],
          )
        ],
      ),
    );
  }

  _buildHostCard(List<ColumnCard> columns){
    //TODO
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        columns.length,
        (cIndex) {
          final column = columns[cIndex];
          return Column(
            children: List.generate(
              column.numbers.length,
              (index) {
                final mapNumber = column.numbers[index];
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
                      color: extracted ? Colors.red : Colors.white,
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
    );
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: List.generate(3,
            (j) {
                //TODO
                final number = 10*j;
                final isExtracted = j % 2 == 0;
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: number < 10 ? 6 : 2
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(3.5),
                    decoration: BoxDecoration(
                      color: isExtracted ? Colors.red : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: RomanText(
                      number.toString(),
                      fontSize: 18,
                    ),
                  ),
                );
              }
          )
        ),
        Column(
            children: List.generate(3,
                    (j) {
                  //TODO
                  final number = 10*j;
                  final isExtracted = j % 2 == 0;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: number < 10 ? 6 : 2
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(3.5),
                      decoration: BoxDecoration(
                        color: isExtracted ? Colors.red : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: RomanText(
                        number.toString(),
                        fontSize: 18,
                      ),
                    ),
                  );
                }
            )
        ),
        Column(
            children: List.generate(3,
                    (j) {
                  //TODO
                  final number = 10*j;
                  final isExtracted = j % 2 == 0;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: number < 10 ? 6 : 2
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(3.5),
                      decoration: BoxDecoration(
                        color: isExtracted ? Colors.red : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: RomanText(
                        number.toString(),
                        fontSize: 18,
                      ),
                    ),
                  );
                }
            )
        ),
        Column(
            children: List.generate(3,
                    (j) {
                  //TODO
                  final number = 10*j;
                  final isExtracted = j % 2 == 0;
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: number < 10 ? 6 : 2
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(3.5),
                      decoration: BoxDecoration(
                        color: isExtracted ? Colors.red : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: RomanText(
                        number.toString(),
                        fontSize: 18,
                      ),
                    ),
                  );
                }
            )
        ),
        Column(
            children: List.generate(3,
                    (j) {
                  //TODO
                  final number = 10*j;
                  final isExtracted = j % 2 == 0;
                  return Padding(
                    padding: EdgeInsets.all(1.5),
                    child: Container(
                      padding: const EdgeInsets.all(3.5),
                      decoration: BoxDecoration(
                        color: isExtracted ? Colors.red : Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: RomanText(
                        number.toString(),
                        fontSize: 18,
                      ),
                    ),
                  );
                }
            )
        )
      ],
    );
  }
}
