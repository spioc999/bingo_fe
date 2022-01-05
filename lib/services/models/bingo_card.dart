import 'package:flutter/material.dart';

class BingoCard{
  List<CardRow>? cardNumbers;
  int? id;
  String? color;

  BingoCard({this.cardNumbers, this.id});

  BingoCard.fromJson(Map<String, dynamic> json) {
    if (json['card_numbers'] != null) {
      cardNumbers = [];
      json['card_numbers'].forEach((v) {
        cardNumbers?.add(CardRow.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if(cardNumbers != null){
      data['card_numbers'] = cardNumbers!.map((c) => c.numbersAndExtracted).toList();
    }
    data['id'] = id;
    return data;
  }
}

class CardRow{
  List<Map<String, bool>>? numbersAndExtracted;

  CardRow({this.numbersAndExtracted});

  CardRow.fromJson(List json) {
    if (json.isNotEmpty) {
      numbersAndExtracted = [];
      for (var v in json) {
        numbersAndExtracted?.add(v.cast<String, bool>());
      }
    }
  }
}