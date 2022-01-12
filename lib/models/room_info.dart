/// [RoomInfo] is wrapper class that permits to save all the information
/// received for room in one object stored in cache (thanks to fromJson and toJson methods)

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