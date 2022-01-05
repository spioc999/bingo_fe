import 'package:bingo_fe/services/models/bingo_card.dart';

class UserCards{
  List<BingoCard>? cards;

  UserCards({this.cards = const []});

  UserCards.fromJson(Map<String, dynamic> json) {
    if(json['cardDTOs'] != null){
      cards = [];
      json['cardDTOs'].forEach((v) {
        cards?.add(BingoCard.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if(cards != null){
      data['cardDTOs'] = cards!.map((c) => c.toJson()).toList();
    }
    return data;
  }

}