import 'package:bingo_fe/base/base_widget.dart';
import 'package:bingo_fe/screens/summary/summary_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<SummaryNotifier>(context, listen: false).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SummaryNotifier>(
      builder: (_, notifier, __) => BaseWidget(
        overlayStyle: SystemUiOverlayStyle.dark,
        safeAreaBottom: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey.shade400,
          onPressed: () => notifier.goToHome(),
          child: const Icon(
            Icons.home_outlined,
            color: Colors.black,
            size: 25,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        child: _buildChild(context, notifier),
      )
    );
  }

  _buildChild(BuildContext context, SummaryNotifier notifier) {
    return Container();
  }
}
