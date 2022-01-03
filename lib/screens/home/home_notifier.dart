import 'package:bingo_fe/base/base_notifier.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends BaseNotifier {
  String nickname = '';
  String room = '';

  TextEditingController nicknameController = TextEditingController();
  TextEditingController roomController = TextEditingController();

  HomeNotifier();

  init() async{}

  onNicknameChanged(String value) {
    nickname = value;
    notifyListeners();
  }

  onRoomChanged(String value) {
    room = value;
    notifyListeners();
  }

  bool get canContinue => nickname.isNotEmpty;
  bool get canConnectToRoom => room.isNotEmpty && room.length == 5;
}