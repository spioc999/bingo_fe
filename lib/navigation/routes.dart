import 'package:bingo_fe/screens/game/game_notifier.dart';
import 'package:bingo_fe/screens/game/game_screen.dart';
import 'package:bingo_fe/screens/home/home_notifier.dart';
import 'package:bingo_fe/screens/home/home_screen.dart';
import 'package:bingo_fe/screens/select_cards/select_cards_notifier.dart';
import 'package:bingo_fe/screens/select_cards/select_cards_screen.dart';
import 'package:bingo_fe/screens/splash/splash_notifier.dart';
import 'package:bingo_fe/screens/splash/splash_screen.dart';
import 'package:bingo_fe/services/models/bingo_paper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Routes {

  static String get initial => RouteEnum.splash.name!;

  static Map<String, WidgetBuilder> get routes => {

    RouteEnum.splash.name! : (_) => ChangeNotifierProvider(
      create: (_) => SplashNotifier(),
      child: const SplashScreen(),
    ),

    RouteEnum.home.name! : (_) => ChangeNotifierProvider(
      create: (_) => HomeNotifier(),
      child: const HomeScreen(),
    ),

    RouteEnum.game.name! : (_) => ChangeNotifierProvider(
      create: (_) => GameNotifier(),
      child: const GameScreen(),
    ),

    RouteEnum.selectCards.name! : (context) {
      BingoPaper? bingoPaper;
      if(ModalRoute.of(context)?.settings.arguments is BingoPaper){
        bingoPaper = ModalRoute.of(context)?.settings.arguments as BingoPaper;
      }
      return ChangeNotifierProvider(
        create: (_) => SelectCardsNotifier(bingoPaper),
        child: const SelectCardsScreen(),
      );
    },

    //TODO summary

  };
}

enum RouteEnum {
  splash,
  home,
  game,
  selectCards,
  summary
}

extension RouteNameExtension on RouteEnum {
  String? get name => {
    RouteEnum.splash : "/splash",
    RouteEnum.home : "/home",
    RouteEnum.game : "/game",
    RouteEnum.selectCards : "/select_cards",
    RouteEnum.summary : "/summary"
  }[this];
}