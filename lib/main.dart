import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/navigation/routes.dart';
import 'package:bingo_fe/services/get_it.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'configure_not_web.dart' if (dart.library.html) 'configure_web.dart'; //conditional import

/// [main] is the entry point of the app.
/// By calling [WidgetsFlutterBinding.ensureInitialized], the app waits until the
/// Flutter engine has been bound to framework.
/// [SystemChrome] permits to set visual behaviour of global app.
/// [configureApp], for only Web, sets the url strategy without # in path.

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  //hide debug print when is in release
  if(kReleaseMode){
    debugPrint = (String? text, {int? wrapWidth}) {};
  }

  registerServices();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  configureApp();

  runApp(const BingoFeApp());
}

/// [BingoFeApp] is the actual app, a [StatelessWidget].
/// As it's a [Widget], the method [build] is called when the widget
/// is inserted into the tree of the [BuildContext].
/// It's made by a [MaterialApp], which gives API to define routes,
/// theme, title and navigator of the entire app.

class BingoFeApp extends StatelessWidget{

  const BingoFeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bingo - PR & SPC',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      routes: Routes.routes,
      initialRoute: Routes.initial,
      navigatorKey: RouteMixin.navigatorKey,
    );
  }

}