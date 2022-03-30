import 'package:flutter/material.dart';

class StateForm with ChangeNotifier {
  bool _estado = false;

  bool get estadoForm => _estado;

  set estadoForm(valor) {
    _estado = valor;
    notifyListeners();
  }
}
