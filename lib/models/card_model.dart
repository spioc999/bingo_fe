class CardModel{
  List<ColumnCard> columns;

  CardModel(this.columns);
}

class ColumnCard {
  List<Map<int, bool>> numbers;

  ColumnCard(this.numbers);
}