class AssignCardsRequest{
  List<int> cards;

  AssignCardsRequest({required this.cards});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['cards'] = cards;
    return data;
  }
}