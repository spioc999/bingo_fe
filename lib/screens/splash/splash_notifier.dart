import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/helpers/extensions.dart';
import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';
import 'package:bingo_fe/screens/bottom_sheets/yes_no_bottom_sheet.dart';

class SplashNotifier extends BaseNotifier with ServiceMixin, RouteMixin{

  SplashNotifier();

  init() async{
    showLoading();
    await Future.delayed(const Duration(milliseconds: 1500), (){});

    bool goToHome = true;

    // Check if there is any pending match in cache
    final lastRoomName = await getLastRoomName(isSilent: true);
    final lastWebSocket = await getLastRoomWebSocket(isSilent: true);


    if (!lastRoomName.hasError && !lastWebSocket.hasError
        && lastRoomName.result.isNotNullAndNotEmpty
        && lastWebSocket.result.isNotNullAndNotEmpty) {

      hideLoading();
      final continueLastRoom = await navigateToBottomSheet(
          const YesNoBottomSheet(yesNoType: YesNoBottomSheetEnum.connectToLastRoom),
          isDismissible: false
      );
      if(continueLastRoom != null && continueLastRoom is bool){
        goToHome = !continueLastRoom;
      }
    }
    hideLoading();

    if(goToHome){
      await saveLastRoomName(null);
      await saveLastRoomWebSocket(null);
      navigateTo(RouteEnum.home, shouldReplace: true);
    }else{
      //TODO
    }
  }
}