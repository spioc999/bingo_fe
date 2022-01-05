import 'package:bingo_fe/helpers/cards_color_helper.dart';

import 'bingo_card.dart';

class BingoPaper{
  String? bingoPaperId;
  List<BingoCard>? cards;
  int? numberOfCards;

  BingoPaper({this.bingoPaperId, this.cards, this.numberOfCards});

  BingoPaper.fromJson(Map<String, dynamic> json) {
    bingoPaperId = json['bingo_paper_id'];
    if (json['cardDTOs'] != null) {
      cards = [];
      json['cardDTOs'].forEach((v) {
        cards?.add(BingoCard.fromJson(v));
      });
      cards?.forEach(
        (c) => c.color = CardsColorHelper.getColorCardByPaperId(int.tryParse(bingoPaperId ?? '') ?? 1));
    }
    numberOfCards = json['number_of_cards'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bingo_paper_id'] = bingoPaperId;
    if(cards != null){
      data['cardDTOs'] = cards!.map((c) => c.toJson()).toList();
    }
    data['number_of_cards'] = numberOfCards;
    return data;
  }
}