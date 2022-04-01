import 'dart:ffi';

import 'package:flutter/material.dart';

class StateForm with ChangeNotifier {
  bool _estado = false;

  String existeFormulario = '';

  bool get estadoForm => _estado;

  set estadoForm(valor) {
    _estado = valor;
    notifyListeners();
  }

  String get existeForm => existeFormulario;

  set existeForm(String valor) {
    existeFormulario = valor;
  }
}
