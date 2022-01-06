import 'package:bingo_fe/base/base_notifier.dart';
import 'package:bingo_fe/mixins/mixin_service.dart';
import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';

class SummaryNotifier extends BaseNotifier with RouteMixin, ServiceMixin{

  goToHome() async{
    await saveRoomInfo(null);
    await saveIsHost(false);
    navigateTo(RouteEnum.home, shouldClearAll: true);
  }

  void init() async {

  }
}