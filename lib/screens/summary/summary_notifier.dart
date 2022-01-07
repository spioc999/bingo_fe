import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';
import 'package:bingo_fe/services/models/winner_message_socket.dart';

class SummaryNotifier extends BaseNotifier with RouteMixin, ServiceMixin{

  bool _isHost = false;
  String? _nickname;
  String? _roomName;
  String? _roomCode;
  Map<WinTypeEnum, List<String>> winners = {};

  goToHome() async{
    await saveRoomInfo(null);
    await saveIsHost(false);
    navigateTo(RouteEnum.home, shouldClearAll: true);
  }

  init() async{
    showLoading();
    _isHost = (await isHostUser(isSilent: true)).result ?? false;
    _nickname = (await getNickname(isSilent: true)).result;
    final roomInfoResponse = await getRoomInfo(isSilent: true);
    _roomCode = roomInfoResponse.result?.roomCode;
    _roomName = roomInfoResponse.result?.roomName;
    notifyListeners();
    await _getWinnersOfRoom();
    hideLoading();
  }

  Future<void> _getWinnersOfRoom() async {
    final response = await getWinnersOfRoom(roomCode, isSilent: true);
    if(!response.hasError){
      winners = response.result?.winners ?? {};
      notifyListeners();
    }
  }

  bool get isHost => _isHost;
  String get roomName => _roomName ?? '';
  String get roomCode => _roomCode ?? '';
  String get nickname => _nickname ?? '';
  String? get tombolaWinners {
    var winnersList = List.from(winners[WinTypeEnum.TOMBOLA] ?? []);
    if(winnersList.isNotEmpty){
      if(winnersList.contains(nickname)){
        winnersList.remove(nickname);
        winnersList = [...winnersList, 'YOU'];
      }

      var winnersString = '';
      for (var w in winnersList) {
        winnersString += '$w, ';
      }
      return winnersString.substring(0, winnersString.length - 2);
    }
  }
  List<WinTypeEnum> get winTypeEnumListWithoutTombolaSorted => winners.keys.toList()..remove(WinTypeEnum.TOMBOLA)..sort((a, b) => a.number.compareTo(b.number));
}