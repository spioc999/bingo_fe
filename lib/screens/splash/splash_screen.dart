import 'package:bingo_fe/base/base_widget.dart';
import 'package:bingo_fe/helpers/image_helper.dart';
import 'package:bingo_fe/screens/splash/splash_notifier.dart';
import 'package:bingo_fe/widget/texts/bold_text.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageHelper.getPng(
                    'logo_free',
                    height: MediaQuery.of(context).size.height / 2.75,
                    fit: BoxFit.fitHeight
                ),
                const SizedBox(height: 30,),
                const BoldText('Bingo FE', color: Colors.red, fontSize: 28,),
                const SizedBox(height: 10,),
                const RomanText('by SPC & PR', color: Colors.grey, fontSize: 12,),
                const SizedBox(height: 30,),
                SizedBox(
                  height: 3,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: notifier.isLoading ?
                    const LinearProgressIndicator() : const IgnorePointer(),
                )
              ],
            )
          ),
        )
    );
  }
}
