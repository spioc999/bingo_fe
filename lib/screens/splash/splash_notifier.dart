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

    //TODO add check for previous game
    if (false) {

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
      navigateTo(RouteEnum.home, shouldReplace: true);
    }else{
      //TODO
    }
  }
}