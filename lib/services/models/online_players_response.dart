class OnlinePlayersResponse{
  int? onlinePlayersNumber;
  List<String>? onlinePlayersNicknames;

  OnlinePlayersResponse({this.onlinePlayersNicknames, this.onlinePlayersNumber});
  
  OnlinePlayersResponse.fromJson(Map<String, dynamic> json){
    onlinePlayersNumber = json['online_players_number'] != null ? int.tryParse(json['online_players_number']) : 0;
    if(json['online_players_nicknames'] != null){
      onlinePlayersNicknames = [];
      json['online_players_nicknames'].forEach((v) {
        onlinePlayersNicknames?.add(v);
      });
    }
  }
}