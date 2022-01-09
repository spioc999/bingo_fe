import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';
import 'package:bingo_fe/screens/bottom_sheets/players_online_bottom_sheet.dart';
import 'package:bingo_fe/screens/bottom_sheets/winners_bottom_sheet.dart';
import 'package:bingo_fe/services/models/extract_number_message_socket.dart';
import 'package:bingo_fe/services/models/message_socket.dart';
import 'package:bingo_fe/services/models/update_user_message_socket.dart';
import 'package:bingo_fe/services/models/winner_message_socket.dart';
import 'package:bingo_fe/services/socket/socket_helper.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameNotifier extends BaseNotifier with ServiceMixin, RouteMixin{
  int? _lastExtractedNumber;
  bool _isHost = false;
  String? _nickname;
  String? _roomName;
  String? _roomCode;
  String? _hostUniqueCode;
  List<CardModel> cards = [];
  IO.Socket? socket;
  int? _numberOfUserConnected;
  Map<WinTypeEnum, List<String>> winners = {};
  bool _hasTappedExtract = false;
  bool _tombolaWon = false;
  bool _hasRetriedToJoin = false;
  bool showRoomMessage = true;
  List<int> cardsWithExtractedNumber = [];
  List<String> _onlinePlayersNicknames = [];

  GameNotifier(this.cards);

  init() async{
    showLoading();
    _isHost = (await isHostUser(isSilent: true)).result ?? false;
    _nickname = (await getNickname(isSilent: true)).result;
    final roomInfoResponse = await getRoomInfo(isSilent: true);
    _roomCode = roomInfoResponse.result?.roomCode;
    _roomName = roomInfoResponse.result?.roomName;
    _hostUniqueCode = roomInfoResponse.result?.hostUniqueCode;
    notifyListeners();
    _addListenersSocketAndJoin();
    await _getLastExtractedNumber();
    await _getWinnersOfRoom();
    hideLoading();
  }

  onTapExtractNumber() async{
    if(_isHost && _roomCode != null && _hostUniqueCode != null && !_tombolaWon){
      _hasTappedExtract = true;
      showLoading();
      final response = await extractNumber(_roomCode!, _hostUniqueCode!, isSilent: true);

      if(response.hasError && !_tombolaWon){
        _hasTappedExtract = false;
        hideLoading();
        showMessage(response.error!.errorMessage, messageType: MessageTypeEnum.error);
        return;
      }

      _lastExtractedNumber = int.tryParse(response.result ?? '');
      await _refreshCards();
      _hasTappedExtract = false;
      hideLoading();
    }
  }

  Future<void> _getLastExtractedNumber() async {
    final lastExtractedByRoomResponse = await getLastExtractedNumber(roomCode, isSilent: true);
    if(lastExtractedByRoomResponse.result != null && lastExtractedByRoomResponse.result! > 0){
      _lastExtractedNumber = lastExtractedByRoomResponse.result;
      notifyListeners();
    }
  }

  Future<void> _refreshCards() async{
    final response = await getUserCards(roomCode, nickname, isSilent: true);
    if(response.hasError && !_tombolaWon){
      hideLoading();
      showMessage(response.error!.errorMessage, messageType: MessageTypeEnum.error);
      return;
    }
    cards = response.result?.cards?.map((c) => CardModel.fromBingoCard(c)).toList() ?? [];
  }

  void _addListenersSocketAndJoin() {
    socket = SocketHelper.createSocket(apiService.client.basePath);
    SocketHelper.addListenersOnSocket(socket,
      onErrorMessage: _onErrorMessageSocket,
      onRoomServiceMessages: _onRoomServiceMessages,
      onExtractedNumber: _onExtractedNumber,
      onWinnerEvent: _onWinnerEvent,
      onUpdatedCard: _onUpdatedCard
    );
    connectAndJoinRoomSocket();
  }

  void _onErrorMessageSocket(dynamic data) {
    try{
      final message = MessageSocket.fromJson(data);
      showMessage(message.msg ?? '', messageType: MessageTypeEnum.error);
      // error sent only to involved user, so leave and retry to connect to room
      if(!_hasRetriedToJoin){
        leaveRoomAndDisconnectSocket();
        connectAndJoinRoomSocket();
        _hasRetriedToJoin = true;
      }
    }catch(_){}
  }

  void _onRoomServiceMessages(dynamic data){
    try{
      final message = MessageSocket.fromJson(data);
      if(showRoomMessage){
        showMessage(message.msg ?? '');
      }
      _updateNumberUserConnected();
    }catch(_){}
  }

  void _updateNumberUserConnected() async{
    final response = await getOnlinePlayersRoom(_roomCode ?? '', isSilent: true);
    if(!response.hasError){
      _numberOfUserConnected = response.result?.onlinePlayersNumber;
      _onlinePlayersNicknames = response.result?.onlinePlayersNicknames ?? [];
      notifyListeners();
    }
  }

  void _onExtractedNumber(dynamic data){
    try{
      final message = ExtractNumberMessageSocket.fromJson(data);
      if(!_isHost){
        _lastExtractedNumber = int.tryParse(message.number ?? '');
        notifyListeners();
      }
    }catch(_){}
  }

  void _onWinnerEvent(dynamic data){
    try{
      final message = WinnerMessageSocket.fromJson(data);
      String messageString = '';
      bool containsCurrentUser = false;
      for (var winner in message.winners ?? <WinnerElement>[]){
        messageString += '${winner.userNickname == _nickname ? 'You' : winner.userNickname} (card ${winner.cardId}), ';
        if (!containsCurrentUser){
          containsCurrentUser = winner.userNickname == _nickname;
        }
      }

      if(messageString.isNotEmpty){
        showMessage(
            '${messageString.substring(0, messageString.length - 2)} won ${message.winType?.toString().split('.')[1]}!',
            messageType: MessageTypeEnum.win,
            isBold: containsCurrentUser
        );
      }

      if(message.winType == WinTypeEnum.TOMBOLA){
        _tombolaWon = true;
        navigateTo(RouteEnum.summary, shouldClearAll: true);
      }else{
        _getWinnersOfRoom();
      }

    }catch(_){}

  }

  void _onUpdatedCard(dynamic data) async{
    try{
      cardsWithExtractedNumber = [];
      final message = UpdateUserMessageSocket.fromJson(data);
      final updateCardsOfUser = message.updatedCards?.where((card) => card.userNickname == _nickname).toList();
      if(!_isHost && updateCardsOfUser != null && updateCardsOfUser.isNotEmpty){
        cardsWithExtractedNumber = updateCardsOfUser.map((card) => card.cardId ?? 0).toList();
        await _refreshCards();
      }
      notifyListeners();
    }catch(_){}
  }

  void openWinners(){
    navigateToBottomSheet(WinnersBottomSheet(winners: winners, userNickname: nickname,));
  }

  void openPlayers() {
    if(_onlinePlayersNicknames.isNotEmpty){
      navigateToBottomSheet(PlayersOnlineBottomSheet(players: _onlinePlayersNicknames, userNickname: nickname,));
    }
  }

  Future<void> _getWinnersOfRoom() async {
    final response = await getWinnersOfRoom(roomCode, isSilent: true);
    if(!response.hasError){
      winners = response.result?.winners ?? {};
      notifyListeners();
    }
  }

  void leaveGame() {
    leaveRoomAndDisconnectSocket();
    saveRoomInfo(null, isSilent: true);
    saveIsHost(false, isSilent: true);
    navigateTo(RouteEnum.home, shouldClearAll: true);
  }

  leaveRoomAndDisconnectSocket(){
    showRoomMessage = false;
    SocketHelper.leaveRoomSocket(socket);
    socket?.disconnect();
  }

  connectAndJoinRoomSocket(){
    showRoomMessage = true;
    socket?.connect();
    SocketHelper.joinRoomSocket(socket, _roomCode, _nickname);
  }

  @override
  void dispose() {
    leaveRoomAndDisconnectSocket();
    socket?.dispose();
    super.dispose();
  }

  bool get isHost => _isHost;
  String get roomName => _roomName ?? '';
  String get roomCode => _roomCode ?? '';
  String get nickname => _nickname ?? '';
  int? get lastExtractedNumber => _lastExtractedNumber;
  int get numberUsersConnected => _numberOfUserConnected ?? 0;
  bool get isLoadingExtract => isLoading && _hasTappedExtract;
  String get cardsWithExtractedNumberString {
    String cardsWithNumber = '';
    for (var card in cardsWithExtractedNumber){
      cardsWithNumber += '$card, ';
    }
    if(cardsWithNumber.isNotEmpty){
      cardsWithNumber = cardsWithNumber.substring(0, cardsWithNumber.length - 2);
    }
    return cardsWithNumber;
  }
}