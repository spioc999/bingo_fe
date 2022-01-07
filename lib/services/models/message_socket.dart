class MessageSocket{
  String? msg;

  MessageSocket({this.msg});

  MessageSocket.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
  }
}