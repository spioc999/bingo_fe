import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';
import 'package:bingo_fe/screens/bottom_sheets/yes_no_bottom_sheet.dart';
import 'package:bingo_fe/services/models/winner_message_socket.dart';

class SplashNotifier extends BaseNotifier with ServiceMixin, RouteMixin{

  SplashNotifier();

  /// [init] method is called after page has been initialized.
  /// It checks if roomInfo and nickname are saved in app. If so, it could be possible
  /// to retrieve an ongoing game session. So after that, if [getUserCards] returns not empty
  /// list of cards assigned to user for that room and [getWinnersOfRoom] has not tombola
  /// winners (in this case the game is finished), so the confirmation [YesNoBottomSheet] is
  /// shown and the user can select if continue the previous game or not.
  /// Otherwise the app follows the normal flow, going to [RouteEnum.home]

  init() async{
    showLoading();
    await Future.delayed(const Duration(milliseconds: 500), (){});

    final roomInfoResponse = await getRoomInfo(isSilent: true);
    final nicknameResponse = await getNickname(isSilent: true);

    if (!roomInfoResponse.hasError && !nicknameResponse.hasError) {

      final userCards = await getUserCards(roomInfoResponse.result?.roomCode ?? '', nicknameResponse.result ?? '', isSilent: true);
      final winnersResponse = await getWinnersOfRoom(roomInfoResponse.result?.roomCode ?? '', isSilent: true);

      if (!userCards.hasError
          && (userCards.result?.cards?.isNotEmpty ?? false)
          && (winnersResponse.result?.winners?[WinTypeEnum.TOMBOLA]?.isEmpty ?? true)){
        hideLoading();
        final continueLastRoom = await navigateToBottomSheet(
            YesNoBottomSheet(
              yesNoType: YesNoBottomSheetEnum.connectToLastRoom,
              roomName: roomInfoResponse.result?.roomName ?? '',
              isDismissible: false,
            ),
            isDismissible: false
        );

        if(continueLastRoom != null && continueLastRoom is bool && continueLastRoom){
          var cards = userCards.result?.cards?.map((c) => CardModel.fromBingoCard(c)).toList() ?? [];
          navigateTo(RouteEnum.game, shouldReplace: true, arguments: cards);
          return;
        }else if (continueLastRoom != null && continueLastRoom is bool && !continueLastRoom){
          await saveRoomInfo(null, isSilent: true);
          await saveIsHost(false, isSilent: true);
        }
      }
    }
    hideLoading();

    navigateTo(RouteEnum.home, shouldReplace: true);
  }
}