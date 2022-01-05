import 'package:bingo_fe/services/models/bingo_paper.dart';

class JoinedRoomResponse{
  BingoPaper? bingoPaper;
  String? roomName;

  JoinedRoomResponse({this.bingoPaper, this.roomName});

  JoinedRoomResponse.fromJson(Map<String, dynamic> json) {
    bingoPaper = json['bingo_paper_dto'] != null ? BingoPaper.fromJson(json['bingo_paper_dto']) : null;
    roomName = json['room_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if(bingoPaper != null){
      data['bingo_paper_dto'] = bingoPaper!.toJson();
    }
    data['room_name'] = roomName;
    return data;
  }
}