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