import 'package:bingo_fe/base/base_widget.dart';
import 'package:bingo_fe/screens/splash/splash_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<SplashNotifier>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      safeAreaTop: true,
      overlayStyle: SystemUiOverlayStyle.dark,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context){
    return Consumer<SplashNotifier>(
        builder: (_, notifier, __) => SizedBox.expand(
          child: Center(
            child: Container()
          ),
        )
    );
  }
}
