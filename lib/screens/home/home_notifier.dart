import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends BaseNotifier with RouteMixin{
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
    await Future.delayed(Duration(seconds: 2), (){});
    hideLoading();
    navigateTo(RouteEnum.game, shouldReplace: true);
    _hasTappedStart = false;
  }

  bool get canConnectToRoom => nickname.isNotEmpty && roomCode.isNotEmpty && roomCode.length == 5;
  bool get canStartNewRoom => nickname.isNotEmpty && roomName.isNotEmpty;
  bool get connectToRoomLoading => isLoading && _hasTappedConnect;
  bool get startRoomLoading => isLoading && _hasTappedStart;
}