import 'dart:convert';

import 'package:bingo_fe/services/models/bingo_paper.dart';

class CreateRoomResponse{
  BingoPaper? bingoPaper;
  String? roomCode;
  String? roomName;

  CreateRoomResponse({this.bingoPaper, this.roomCode, this.roomName});

  CreateRoomResponse.fromJson(Map<String, dynamic> json) {
    bingoPaper = json['bingo_paper_dto'] != null ? BingoPaper.fromJson(json['bingo_paper_dto']) : null;
    roomCode = json['room_code'];
    roomName = json['room_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if(bingoPaper != null){
      data['bingo_paper_dto'] = bingoPaper!.toJson();
    }
    data['room_code'] = roomCode;
    data['room_name'] = roomName;
    return data;
  }
}