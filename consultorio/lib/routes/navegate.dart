import 'package:flutter/cupertino.dart';

class Navigate {
  static void goToWelcome(BuildContext context) {
    Navigator.pushNamed(context, '/welcome');
  }

  static void goToform(BuildContext context) {
    Navigator.pushNamed(context, '/form');
  }

  static void goToform2(BuildContext context) {
    Navigator.pushNamed(context, '/form2');
  }

  static void goToHelp(BuildContext context) {
    Navigator.pushNamed(context, '/help');
  }

  static void goToState(BuildContext context) {
    Navigator.pushNamed(context, '/state');
  }

  static void goToWrapper(BuildContext context) {
    Navigator.pushNamed(context, '/wrapper');
  }
}
