import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/models/card_model.dart';

class GameNotifier extends BaseNotifier with ServiceMixin{
  int? _lastExtractedNumber;
  bool _isHost = false;
  String? _nickname;
  String? _roomName;
  String? _roomCode;
  List<CardModel> cards = [];

  init() async{
    _isHost = (await isHostUser()).result ?? false;
    _nickname = (await getNickname()).result;
    final roomAndPaperResponse = await getRoomCreatedAndPaper();
    if (roomAndPaperResponse.hasError){
      showMessage('Error', isError: true);
      return;
    }
    _roomName = roomAndPaperResponse.result?.roomName;
    _roomCode = roomAndPaperResponse.result?.roomCode;
    cards = roomAndPaperResponse.result?.bingoPaper?.cards?.map((c) => CardModel.fromBingoCard(c)).toList() ?? [];
    notifyListeners();
  }

  onTapExtractNumber() async{
    showLoading();
    await Future.delayed(Duration(seconds: 1), (){});
    _lastExtractedNumber = 90;
    hideLoading();
  }

  bool get isHost => _isHost;
  String get roomName => _roomName ?? '';
  String get roomCode => _roomCode ?? '';
  String get nickname => _nickname ?? '';
  int? get lastExtractedNumber => _lastExtractedNumber;
  int get numberUsersConnected => 3;
}