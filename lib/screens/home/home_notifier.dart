import 'package:bingo_fe/base/base_notifier.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends BaseNotifier {
  String nickname = '';
  String roomCode = '';
  String roomName = '';

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

  bool get canConnectToRoom => nickname.isNotEmpty && roomCode.isNotEmpty && roomCode.length == 5;
  bool get canStartNewRoom => nickname.isNotEmpty && roomName.isNotEmpty;
}