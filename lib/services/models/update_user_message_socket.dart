class UpdateUserMessageSocket{
  List<UpdatedCardElement>? updatedCards;

  UpdateUserMessageSocket({this.updatedCards});

  UpdateUserMessageSocket.fromJson(Map<String, dynamic> json) {
    if(json['updated_cards'] != null){
      updatedCards = [];
      json['updated_cards'].forEach((v) {
        updatedCards?.add(UpdatedCardElement.fromJson(v));
      });
    }
  }
}

class UpdatedCardElement{
  String? userNickname;
  int? cardId;

  UpdatedCardElement({this.userNickname, this.cardId});

  UpdatedCardElement.fromJson(Map<String, dynamic> json) {
    userNickname = json['user_nickname'];
    cardId = json['card_id'];
  }
}