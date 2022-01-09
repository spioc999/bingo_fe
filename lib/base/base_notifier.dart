import 'package:bingo_fe/navigation/mixin_route.dart';
import 'package:bingo_fe/widget/texts/bold_text.dart';
import 'package:bingo_fe/widget/texts/roman_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BaseNotifier extends ChangeNotifier{
  CancelToken cancelToken = CancelToken();
  bool isLoading = false;
  bool _isDisposed = false;

  showLoading(){
    isLoading = true;
    notifyListeners();
  }

  hideLoading(){
    isLoading = false;
    notifyListeners();
  }

  showMessage(String message, {MessageTypeEnum messageType = MessageTypeEnum.info, int durationSec = 2, bool isBold = false}) {
    Color color;
    switch(messageType){

      case MessageTypeEnum.info:
        color = Colors.grey.shade100;
        break;
      case MessageTypeEnum.error:
        color = Colors.red.shade300;
        break;
      case MessageTypeEnum.win:
        color = Colors.green.shade300;
        break;
    }
    ScaffoldMessenger.of(RouteMixin.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: isBold ? BoldText(message, maxLines: 4,) : RomanText(message, maxLines: 4,),
        backgroundColor: color,
        duration: Duration(seconds: durationSec),
      )
    );
  }

  @override
  void dispose() {
    cancelToken.cancel();
    _isDisposed = true;
    super.dispose();
  }

  @override
  void notifyListeners() {
    if(!_isDisposed){
      super.notifyListeners();
    }
  }

  @protected bool get isDisposed => _isDisposed;
}

enum MessageTypeEnum{
  info,
  error,
  win
}