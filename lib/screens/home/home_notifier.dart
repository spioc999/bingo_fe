import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/models/room_info.dart';
import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends BaseNotifier with RouteMixin, ServiceMixin{
  String nickname = '';
  String roomCode = '';
  String roomName = '';
  bool _hasTappedConnect = false;
  bool _hasTappedStart = false;

  TextEditingController nicknameController = TextEditingController();
  TextEditingController roomCodeController = TextEditingController();
  TextEditingController roomNameController = TextEditingController();

  HomeNotifier();

  init() async{
    final nicknameInCache = await getNickname();
    if(!nicknameInCache.hasError){
      nickname = nicknameInCache.result ?? '';
      nicknameController.text = nickname;
      notifyListeners();
    }
  }

  onNicknameChanged(String value) {
    nickname = value;
    notifyListeners();
  }

  onRoomCodeChanged(String value) {
    roomCode = value;
    notifyListeners();
  }

  onRoomNameChanged(String value) {
    roomName = value;
    notifyListeners();
  }

  onTapConnectRoom() async{
    _hasTappedConnect = true;
    showLoading();
    final response = await joinRoom(roomCode, nickname, isSilent: true);
    if(response.hasError){
      _hasTappedConnect = false;
      hideLoading();
      showMessage(response.error!.errorMessage, isError: true);
      return;
    }
    await saveIsHost(false);
    await saveNickname(nickname);
    await saveRoomInfo(RoomInfo(roomCode: roomCode, roomName: response.result?.roomName));
    _hasTappedConnect = false;
    hideLoading();
    navigateTo(RouteEnum.selectCards, shouldReplace: true, arguments: response.result?.bingoPaper);
  }

  onTapStartNewRoom() async{
    _hasTappedStart = true;
    showLoading();
    final response = await createNewRoom(roomName, nickname, isSilent: true);
    if(response.hasError){
      _hasTappedStart = false;
      hideLoading();
      showMessage(response.error!.errorMessage, isError: true);
      return;
    }
    await saveIsHost(response.result?.hostUniqueCode != null);
    await saveRoomInfo(RoomInfo(
      roomCode: response.result?.roomCode,
      roomName: response.result?.roomName,
      hostUniqueCode: response.result?.hostUniqueCode
    ));
    await saveNickname(nickname);
    var cards = response.result?.bingoPaper?.cards?.map((c) => CardModel.fromBingoCard(c)).toList() ?? [];
    _hasTappedStart = false;
    hideLoading();
    navigateTo(RouteEnum.game, shouldReplace: true, arguments: cards);
  }

  bool get canConnectToRoom => nickname.isNotEmpty && roomCode.isNotEmpty && roomCode.length == 5;
  bool get canStartNewRoom => nickname.isNotEmpty && roomName.isNotEmpty;
  bool get connectToRoomLoading => isLoading && _hasTappedConnect;
  bool get startRoomLoading => isLoading && _hasTappedStart;
}