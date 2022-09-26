import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../core/theme/colors.dart';

enum ToastType {
  ERROR,
  SUCCESS,
}

class ToastWidget {
  static show({
    required String message,
    required ToastType toastType,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: _colorToast(toastType),
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  static Color _colorToast(ToastType toastType) {
    switch (toastType) {
      case ToastType.SUCCESS:
        return AppColors.success;
      case ToastType.ERROR:
        return AppColors.error;
    }
  }
}
