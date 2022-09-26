
import 'package:flutter/cupertino.dart';

import '../../core/enum/text_form_typ_enum.dart';
import 'validate_messages.dart';

class Validators {
  static bool validateTextIsNotEmpty(String text) => text.isNotEmpty;
  static bool validateTextShortLength(String text) => text.trim().length >= 2;
  static bool validatePasswordLength(String text) => text.trim().length >= 8;
  static bool validateUsername(String text) {
    if (text.trim().length < 2) return false;

    return true;
  }

  //  => email pattern

  static String _emailPattern =
      r"^^[a-zA-Z0-9.!#$%&*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";

  static bool emailIsValid(String email) {
    RegExp emailRegularExpression = RegExp(_emailPattern);
    return emailRegularExpression.hasMatch(email.trim());
  }

  static bool passwordValid(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static String? validMessage(
      {required TextFormTypEnum enumInputType,
      required String text,
      required BuildContext context}) {
    switch (enumInputType) {
      case TextFormTypEnum.NAME:
        return validateUsername(text) ? null : ValidateMessages.userName;
      case TextFormTypEnum.EMAIL:
        return emailIsValid(text) ? null : ValidateMessages.email;
      case TextFormTypEnum.PASSWORD:
        return passwordValid(text) && validatePasswordLength(text)
            ? null
            : ValidateMessages.password;
    }
  }
}
