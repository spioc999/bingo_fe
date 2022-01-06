import 'package:enum_to_string/enum_to_string.dart';

class WinnerMessageSocket {
  String? userNickname;
  int? cardId;
  WinTypeEnum? winType;

  WinnerMessageSocket({this.userNickname, this.cardId, this.winType});

  WinnerMessageSocket.fromJson(Map<String, dynamic> json) {
    userNickname = json['user_nickname'];
    winType = EnumToString.fromString(WinTypeEnum.values, json['win_type'] ?? 'NONE');
    cardId = int.tryParse(json['card_id']);
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