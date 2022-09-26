import 'package:flutter/cupertino.dart';

class Go {
  static toName({
    required BuildContext context,
    required String routeName,
    Object? arguments,
  }) {
    return Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static toReplacementNamed({
    required BuildContext context,
    required String routeName,
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(context, routeName,
        arguments: arguments);
  }

  static back({required BuildContext context}) {
    return Navigator.pop(context);
  }
}
