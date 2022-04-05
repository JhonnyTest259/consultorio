import 'package:flutter/material.dart';

class StateForm with ChangeNotifier {
  bool _estado = true;

  bool get estadoForm => _estado;

  set estadoForm(valor) {
    _estado = valor;
  }

  String _state = '';

  String get stateForm => _state;

  set stateForm(String valor) {
    _state = valor;
    notifyListeners();
  }
}
