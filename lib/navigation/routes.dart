import 'package:bingo_fe/models/card_model.dart';
import 'package:bingo_fe/screens/game/game_notifier.dart';
import 'package:bingo_fe/screens/game/game_screen.dart';
import 'package:bingo_fe/screens/home/home_notifier.dart';
import 'package:bingo_fe/screens/home/home_screen.dart';
import 'package:bingo_fe/screens/select_cards/select_cards_notifier.dart';
import 'package:bingo_fe/screens/select_cards/select_cards_screen.dart';
import 'package:bingo_fe/screens/splash/splash_notifier.dart';
import 'package:bingo_fe/screens/splash/splash_screen.dart';
import 'package:bingo_fe/screens/summary/summary_notifier.dart';
import 'package:bingo_fe/screens/summary/summary_screen.dart';
import 'package:bingo_fe/services/models/bingo_paper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// [Routes] is the class which has the [routes] map, useful to register all routes at the app startup.
/// To avoid errors in WEB APP, if nothing is passed during navigation (use case: refresh web page or go in
/// specific screen using url bar) the app redirect to [SplashScreen] which is able to retrieve a previous game
/// if still in progress.

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

    RouteEnum.game.name! : (context) {
      List<CardModel> cards = [];
      if(ModalRoute.of(context)?.settings.arguments is List<CardModel>){
        cards = ModalRoute.of(context)?.settings.arguments as List<CardModel>;
      }
      if(cards.isNotEmpty){
        return ChangeNotifierProvider(
          create: (_) => GameNotifier(cards),
          child: const GameScreen(),
        );

      }else{
        return ChangeNotifierProvider(
          create: (_) => SplashNotifier(),
          child: const SplashScreen(),
        );
      }
    },

    RouteEnum.selectCards.name! : (context) {
      BingoPaper? bingoPaper;
      if(ModalRoute.of(context)?.settings.arguments is BingoPaper){
        bingoPaper = ModalRoute.of(context)?.settings.arguments as BingoPaper;
      }

      if(bingoPaper != null){
        return ChangeNotifierProvider(
          create: (_) => SelectCardsNotifier(bingoPaper),
          child: const SelectCardsScreen(),
        );
      }else{
        return ChangeNotifierProvider(
          create: (_) => SplashNotifier(),
          child: const SplashScreen(),
        );
      }
    },

    RouteEnum.summary.name! : (context) {
      bool fromGameCorrectly = false;
      if(ModalRoute.of(context)?.settings.arguments is bool){
        fromGameCorrectly = ModalRoute.of(context)?.settings.arguments as bool;
      }
      if(fromGameCorrectly){
        return ChangeNotifierProvider(
          create: (_) => SummaryNotifier(),
          child: const SummaryScreen(),
        );
      }else{
        return ChangeNotifierProvider(
          create: (_) => SplashNotifier(),
          child: const SplashScreen(),
        );
      }
    },
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