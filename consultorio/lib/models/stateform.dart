import 'package:flutter/material.dart';

class StateForm with ChangeNotifier {
  bool _estado = false;

  bool get Estado => _estado;

  void onChange(valor) {
    _estado = valor;
    notifyListeners();
  }
}
