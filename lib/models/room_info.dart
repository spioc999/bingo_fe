class RoomInfo{
  String? roomCode;
  String? roomName;
  String? hostUniqueCode;

  RoomInfo({this.roomCode, this.roomName, this.hostUniqueCode});

  RoomInfo.fromJson(Map<String, dynamic> json) {
    roomCode = json['room_code'];
    roomName = json['room_name'];
    hostUniqueCode = json['host_unique_code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['room_code'] = roomCode;
    data['room_name'] = roomName;
    data['host_unique_code'] = hostUniqueCode;
    return data;
  }
}