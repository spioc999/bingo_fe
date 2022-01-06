import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';

class HostPaperWidget extends StatelessWidget {

  final List<CardModel> hostCards;
  final Color color;

  const HostPaperWidget({Key? key, required this.hostCards, this.color = Colors.red}) : super(key: key);

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

  _buildHostCard(List<ColumnCard>? columns){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        columns?.length ?? 0,
        (cIndex) {
          final column = columns![cIndex];
          return Column(
            children: List.generate(
              column.numbers.length,
              (index) {
                final mapNumber = column.numbers[index];
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
                      color: extracted ? color.withOpacity(0.7) : Colors.white,
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
  }
}
