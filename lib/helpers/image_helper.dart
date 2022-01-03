import 'package:flutter/material.dart';

class ImageHelper {

  static Widget getPng (String img,
      {double? width, double? height, BoxFit? fit, }) {

    final String path = "assets/img/$img.png";

    return Image.asset(path, width: width, height: height, fit: fit,);
  }

  static Widget getJpg (String img,
      {double? width, double? height, BoxFit? fit, }) {

    final String path = "assets/img/$img.jpg";

    return Image.asset(path, width: width, height: height, fit: fit,);
  }
}