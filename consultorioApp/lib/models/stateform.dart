import 'package:flutter/material.dart';

class StateForm with ChangeNotifier {
  String _state = '';

  String get stateForm => _state;

  set stateForm(String valor) {
    _state = valor;
    notifyListeners();
  }
}
