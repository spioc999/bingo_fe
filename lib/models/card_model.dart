import 'package:bingo_fe/services/models/bingo_card.dart';

class CardModel{
  String? id;
  List<ColumnCard>? columns;

  CardModel(this.columns);

  CardModel.fromBingoCard(BingoCard card){
    id = 'Card ${card.id}';
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
  }
}

class ColumnCard {
  List<Map<String, bool>> numbers;

  ColumnCard({this.numbers = const []});
}