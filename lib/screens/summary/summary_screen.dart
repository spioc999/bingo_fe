import 'package:bingo_fe/base/base_widget.dart';
import 'package:bingo_fe/screens/summary/summary_notifier.dart';
import 'package:bingo_fe/widget/common/scrolling_expanded_widget.dart';
import 'package:bingo_fe/widget/texts/bold_text.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: FloatingActionButton(
            backgroundColor: Colors.grey.shade400,
            onPressed: () => notifier.goToHome(),
            child: const Icon(
              Icons.home_outlined,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        child: _buildChild(context, notifier),
      )
    );
  }

  _buildChild(BuildContext context, SummaryNotifier notifier) {
    Widget child = Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.red,
                  Colors.red.withOpacity(0.8)
                ]
            ),
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(25.0)),
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10 + MediaQuery.of(context).viewPadding.top,),
              const BoldText('Summary', fontSize: 26),
              const SizedBox(height: 8,),
              BoldText('Room code: ${notifier.roomCode}', fontSize: 14, maxLines: 1,),
              const SizedBox(height: 8,),
              BoldText('Room name: ${notifier.roomName}', fontSize: 14, maxLines: 1,),
              const SizedBox(height: 15,),
            ],
          ),
        ),
        const SizedBox(height: 50,),
        notifier.isLoading ? const CircularProgressIndicator() :
        ScrollingExpandedWidget(
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 750 ? 750 : MediaQuery.of(context).size.width,
              child: _buildSummary(notifier),
            )
        ),
      ],
    );

    if(!notifier.isLoading){
      return Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Lottie.asset('assets/fireworks.json'),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0.85),
          ),
          child
        ],
      );
    }

    return child;
  }

  _buildSummary(SummaryNotifier notifier) {
    return Column(
      children: [
        BoldText('${notifier.tombolaWinners} won TOMBOLA!', fontSize: 22, decoration: TextDecoration.underline, maxLines: 10,),
        const SizedBox(height: 50,),
        const BoldText('Other prizes', fontSize: 17,),
        const SizedBox(height: 20,),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) {
            final key = notifier.winTypeEnumListWithoutTombolaSorted[index];
            var users = '';
            notifier.winners[key]?.forEach((username) {
              users += '${username == notifier.nickname ? 'YOU' : username}, ';
            });
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoldText(key.name, fontSize: 16,),
                  RomanText(users.substring(0, users.length - 2), fontSize: 15,),
                ],
              ),
            );
          },
          itemCount: notifier.winTypeEnumListWithoutTombolaSorted.length,
        )
      ],
    );
  }
}
