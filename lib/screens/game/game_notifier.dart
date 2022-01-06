import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';
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

  GameNotifier(this.cards);

  init() async{
    _isHost = (await isHostUser()).result ?? false;
    _nickname = (await getNickname()).result;
    final roomInfoResponse = await getRoomInfo();
    _roomCode = roomInfoResponse.result?.roomCode;
    _roomName = roomInfoResponse.result?.roomName;
    _hostUniqueCode = roomInfoResponse.result?.hostUniqueCode;
    _getLastExtractedNumber();
    _getWinnersOfRoom();
    _addListenersSocketAndJoin();
    notifyListeners();
  }

  onTapExtractNumber() async{
    if(_isHost && _roomCode != null && _hostUniqueCode != null){
      showLoading();
      final response = await extractNumber(_roomCode!, _hostUniqueCode!, isSilent: true);

      if(response.hasError){
        hideLoading();
        showMessage(response.error!.errorMessage, messageType: MessageTypeEnum.error);
        return;
      }

      _lastExtractedNumber = int.tryParse(response.result ?? '');
      await _refreshCards();
      hideLoading();
    }
  }

  _getLastExtractedNumber() async {
    final lastExtractedByRoomResponse = await getLastExtractedNumber(roomCode, isSilent: true);
    if(lastExtractedByRoomResponse.result != null && lastExtractedByRoomResponse.result! > 0){
      _lastExtractedNumber = lastExtractedByRoomResponse.result;
      notifyListeners();
    }
  }

  Future<void> _refreshCards() async{
    final response = await getUserCards(roomCode, nickname, isSilent: true);
    if(response.hasError){
      hideLoading();
      showMessage(response.error!.errorMessage, messageType: MessageTypeEnum.error);
      return;
    }
    cards = response.result?.cards?.map((c) => CardModel.fromBingoCard(c)).toList() ?? [];
  }

  void _addListenersSocketAndJoin() {
    socket = SocketHelper.createAndConnectSocket(apiService.client.basePath);
    SocketHelper.addListenersOnSocket(socket,
      onErrorMessage: _onErrorMessageSocket,
      onRoomServiceMessages: _onRoomServiceMessages,
      onExtractedNumber: _onExtractedNumber,
      onWinnerEvent: _onWinnerEvent,
      onUpdatedCard: _onUpdatedCard
    );
    SocketHelper.joinRoomSocket(socket, _roomCode, _nickname);
  }

  void _onErrorMessageSocket(dynamic data) {
    final message = MessageSocket.fromJson(data);
    showMessage(message.msg ?? '', messageType: MessageTypeEnum.error);
  }

  void _onRoomServiceMessages(dynamic data){
    final message = MessageSocket.fromJson(data);
    showMessage(message.msg ?? '');
    _updateNumberUserConnected();
  }

  void _updateNumberUserConnected() async{
    _numberOfUserConnected = (await getOnlinePlayersRoom(_roomCode ?? '', isSilent: true)).result;
    notifyListeners();
  }

  void _onExtractedNumber(dynamic data){
    final message = ExtractNumberMessageSocket.fromJson(data);
    if(!_isHost){
      _lastExtractedNumber = message.number;
      notifyListeners();
    }
  }

  void _onWinnerEvent(dynamic data){
    final message = WinnerMessageSocket.fromJson(data);
    showMessage(
      '${message.userNickname == _nickname ? 'You' : message.userNickname} won ${message.winType?.toString().split('.')[1]} with card ${message.cardId}!',
      messageType: MessageTypeEnum.win,
      isBold: message.userNickname == _nickname
    );
    if(message.winType == WinTypeEnum.TOMBOLA){
      navigateTo(RouteEnum.summary, shouldClearAll: true);
    }else{
      _getWinnersOfRoom();
    }
  }

  void _onUpdatedCard(dynamic data) async{
    final message = UpdateUserMessageSocket.fromJson(data);
    if(!_isHost && message.userNickname == _nickname){
      await _refreshCards();
      notifyListeners();
    }
  }

  void openWinners(){
    navigateToBottomSheet(WinnersBottomSheet(winners: winners));
  }

  void _getWinnersOfRoom() async {
    final response = await getWinnersOfRoom(roomCode, isSilent: true);
    if(!response.hasError){
      winners = response.result?.winners ?? {};
      notifyListeners();
    }
  }

  void leaveGame() {
    leaveRoomSocket();
    saveRoomInfo(null, isSilent: true);
    saveIsHost(false);
    navigateTo(RouteEnum.home, shouldClearAll: true);
  }

  leaveRoomSocket(){
    SocketHelper.leaveRoomSocket(socket);
  }

  @override
  void dispose() {
    leaveRoomSocket();
    socket?.dispose();
    super.dispose();
  }

  bool get isHost => _isHost;
  String get roomName => _roomName ?? '';
  String get roomCode => _roomCode ?? '';
  String get nickname => _nickname ?? '';
  int? get lastExtractedNumber => _lastExtractedNumber;
  int get numberUsersConnected => _numberOfUserConnected ?? 0;
}