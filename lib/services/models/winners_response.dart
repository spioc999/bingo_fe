import 'package:bingo_fe/services/models/winner_message_socket.dart';
import 'package:enum_to_string/enum_to_string.dart';

class WinnersResponse{
  Map<WinTypeEnum, List<String>>? winners;

  WinnersResponse({this.winners});

  WinnersResponse.fromJson(Map<String, dynamic> json) {
    winners = {for (var key in json.keys) EnumToString.fromString(WinTypeEnum.values, key) ?? WinTypeEnum.NONE: _getUserNicknamesList(json[key])};
  }

  List<String> _getUserNicknamesList(List usersDynamic){
    final users = <String>[];
    usersDynamic.forEach((element) {
      users.add(element.toString());
    });
    return users;
  }
}