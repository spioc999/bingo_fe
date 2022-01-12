import 'package:bingo_fe/services/models/bingo_card.dart';
import 'package:flutter/material.dart';

class CardModel{
  int? id;
  List<ColumnCard>? columns;
  Color color = Colors.red;

  CardModel(this.columns);

  /// [CardModel.fromBingoCard] is a converting method which from [BingoCard], response of service,
  /// creates a [CardModel] object. The last one is oriented to visualization,
  /// transforming rows of numbers in columns of numbers.

  CardModel.fromBingoCard(BingoCard card){
    id = card.id;
    if(card.cardNumbers != null && card.cardNumbers!.isNotEmpty){
      columns = List.generate(
        card.cardNumbers![0].numbersAndExtracted?.length ?? 0,
        (index) => ColumnCard()
      );
      for (var row in card.cardNumbers!){
        if(row.numbersAndExtracted != null){
          for(var i = 0; i < row.numbersAndExtracted!.length; i++){
            columns![i].numbers = List.from(columns![i].numbers)..add(row.numbersAndExtracted![i]);
          }
        }
      }
    }
    color = HexColor(card.color ?? '#F44336');
  }
}

class ColumnCard {
  List<Map<String, bool>> numbers;

  ColumnCard({this.numbers = const []});
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}