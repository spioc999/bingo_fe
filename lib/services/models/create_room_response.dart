import 'dart:convert';

import 'package:bingo_fe/services/models/bingo_paper.dart';

class CreateRoomResponse{
  BingoPaper? bingoPaper;
  String? roomCode;
  String? roomName;

  CreateRoomResponse({this.bingoPaper, this.roomCode, this.roomName});

  CreateRoomResponse.fromJson(Map<String, dynamic> json) {
    if(json['bingo_paper_dto'] != null){
      if(json['bingo_paper_dto'] is String){
        bingoPaper = BingoPaper.fromJson(jsonDecode(json['bingo_paper_dto'].replaceAll('\n', '')));
      } else if (json['bingo_paper_dto'] is Map){
        bingoPaper = BingoPaper.fromJson(json['bingo_paper_dto']);
      }
    }
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