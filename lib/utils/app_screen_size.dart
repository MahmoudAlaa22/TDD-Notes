import 'package:flutter/cupertino.dart';

class AppSizeScreen {
  static double width=0.0;
  static double height=0.0;
  static getSize(BuildContext context) {
    final size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;
  }
}
