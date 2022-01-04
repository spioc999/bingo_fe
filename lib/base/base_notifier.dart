import 'package:bingo_fe/navigation/mixin_route.dart';
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

  showMessage(String message, {bool isError = false, int durationSec = 2}) {
    ScaffoldMessenger.of(RouteMixin.navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: RomanText(message),
        backgroundColor: isError ? Colors.red.shade300 : Colors.grey.shade100,
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