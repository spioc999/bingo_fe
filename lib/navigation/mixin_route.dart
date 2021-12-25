import 'package:flutter/material.dart';
import 'package:bingo_fe/navigation/routes.dart';

mixin RouteMixin {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get navigatorState => navigatorKey.currentState!;

  Future navigateTo(
      RouteEnum routeName, {
        Object? arguments,
        bool shouldReplace = false,
        bool shouldClearAll = false
      }) async {

    if (shouldReplace) {
      return await navigatorState.pushReplacementNamed(
        routeName.name!,
        arguments: arguments,
      );
    }

    if(shouldClearAll){
      return await navigatorState.pushNamedAndRemoveUntil(
          routeName.name!, (route) => false,
          arguments: arguments
      );
    }

    return await navigatorState.pushNamed(
      routeName.name!,
      arguments: arguments,
    );
  }

  navigateToLoginForUnauthorized() {
    navigateTo(RouteEnum.home, shouldClearAll: true, arguments: true); //TODO check arguments
  }

  void pop([dynamic result]) {
    return navigatorState.pop(result);
  }

  Future<T?> navigateToBottomSheet<T>(Widget widget, {bool isDismissible = true}) async{
    return await showModalBottomSheet<T>(
        enableDrag: isDismissible,
        isDismissible: isDismissible,
        backgroundColor: Colors.transparent,
        useRootNavigator: true,
        context: navigatorState.context,
        builder: (context) => widget);
  }

  bool isCurrent(RouteEnum routeEnum) {
    bool isCurrent = false;
    navigatorState.popUntil((route) {
      if (route.settings.name == routeEnum.name) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }

}