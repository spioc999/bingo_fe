import 'package:bingo_fe/services/models/bingo_card.dart';
import 'package:flutter/material.dart';

class CardModel{
  int? id;
  List<ColumnCard>? columns;
  Color color = Colors.red;

  CardModel(this.columns);

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
    color = Colors.red; //TODO convert color
  }
}

class ColumnCard {
  List<Map<String, bool>> numbers;

  ColumnCard({this.numbers = const []});
}