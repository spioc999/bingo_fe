class UpdateUserMessageSocket{
  String? userNickname;
  int? cardId;

  UpdateUserMessageSocket({this.userNickname, this.cardId});

  UpdateUserMessageSocket.fromJson(Map<String, dynamic> json) {
    userNickname = json['user_nickname'];
    cardId = int.tryParse(json['card_id']);
  }
}