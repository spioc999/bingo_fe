import 'package:flutter/material.dart';

class CardsColorHelper{
  static Color getColorCardByPaperId(int id){
    final div = (id - 1) % 5;

    switch(div){
      case 0:
        return Colors.red;
      case 1:
        return Colors.green;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.yellow;
      case 4:
        return Colors.pink;
      default:
        return Colors.red;
    }
  }
}