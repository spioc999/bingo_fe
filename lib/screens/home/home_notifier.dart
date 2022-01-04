import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
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

  init() async{}

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

  onTapConnectRoom(){
    _hasTappedConnect = true;
    navigateTo(RouteEnum.game, shouldReplace: true);
    _hasTappedConnect = false;
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
    await saveIsHost(true);
    await saveRoomCreatedAndPaper(response.result);
    await saveNickname(nickname);
    _hasTappedStart = false;
    hideLoading();
    navigateTo(RouteEnum.game, shouldReplace: true);
  }

  bool get canConnectToRoom => nickname.isNotEmpty && roomCode.isNotEmpty && roomCode.length == 5;
  bool get canStartNewRoom => nickname.isNotEmpty && roomName.isNotEmpty;
  bool get connectToRoomLoading => isLoading && _hasTappedConnect;
  bool get startRoomLoading => isLoading && _hasTappedStart;
}