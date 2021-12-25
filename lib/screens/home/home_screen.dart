import 'package:bingo_fe/base/base_widget.dart';
import 'package:bingo_fe/screens/home/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<HomeNotifier>(context, listen: false).init();
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
    return Consumer<HomeNotifier>(
        builder: (_, notifier, __) => SizedBox.expand(
          child: Center(
              child: Container()
          ),
        )
    );
  }
}
