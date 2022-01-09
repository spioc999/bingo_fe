import 'package:enum_to_string/enum_to_string.dart';

class WinnerMessageSocket {
  List<WinnerElement>? winners;
  WinTypeEnum? winType;

  WinnerMessageSocket({this.winners, this.winType});

  WinnerMessageSocket.fromJson(Map<String, dynamic> json) {
    if(json['winners'] != null){
      winners = [];
      json['winners'].forEach((v) {
        winners?.add(WinnerElement.fromJson(v));
      });
    }
    winType = EnumToString.fromString(WinTypeEnum.values, json['win_type'] ?? 'NONE');
  }
}

class WinnerElement{
  String? userNickname;
  int? cardId;

  WinnerElement({this.userNickname, this.cardId});

  WinnerElement.fromJson(Map<String, dynamic> json) {
    userNickname = json['user_nickname'];
    cardId = json['card_id'];
  }
}

enum WinTypeEnum{
  AMBO,
  TERNA,
  QUATERNA,
  CINQUINA,
  TOMBOLA,
  NONE
}

extension WinTypeEnumExtension on WinTypeEnum {
  int get number {
    switch(this){
      case WinTypeEnum.AMBO:
        return 2;
      case WinTypeEnum.TERNA:
        return 3;
      case WinTypeEnum.QUATERNA:
        return 4;
      case WinTypeEnum.CINQUINA:
        return 5;
      case WinTypeEnum.TOMBOLA:
        return 15;
      case WinTypeEnum.NONE:
        return 0;
    }
  }
}