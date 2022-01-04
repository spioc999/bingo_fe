import 'package:bingo_fe/base/base_notifier.dart';

class GameNotifier extends BaseNotifier{
  int? _lastExtractedNumber;

  init() async{}

  onTapExtractNumber() async{
    showLoading();
    await Future.delayed(Duration(seconds: 1), (){});
    _lastExtractedNumber = 90;
    hideLoading();
  }

  bool get isHost => false; //TODO
  String get roomName => 'Rooom';
  String get roomCode => 'FERDS';
  String get nickname => 'spioc_999';
  int? get lastExtractedNumber => _lastExtractedNumber;
  int get numberUsersConnected => 3;
}