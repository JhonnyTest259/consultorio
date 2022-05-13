import 'package:consultorio/models/user.dart';
import 'package:consultorio/pages/forms/form_page.dart';
import 'package:consultorio/pages/home/home_page.dart';
import 'package:consultorio/pages/status_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/stateform.dart';

class Wrapper extends StatelessWidget {
  String? localFormState;
  @override
  Widget build(BuildContext context) {
    //Con esto podemos obtener al usuario si inicio o cerro sesion
    final user = Provider.of<MyUser?>(context);
    //con esto podemos ver si ya se envio el formulario
    final estadoForm = Provider.of<StateForm>(context);
    //guarda el valor de la variable almacenada localmente
    mostrarDatos();
    //return either home or Authenticate widget
    if (user != null) {
      //con esto podemos ver si ya se envio el formulario
      if (estadoForm.stateForm == 'si' || localFormState == 'si') {
        return StatusPage();
      } else {
        print('Hay una sesion');
        return FormPage();
      }
    } else {
      return HomePage();
    }
  }

  Future<void> mostrarDatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    localFormState = await prefs.getString("enviado");
  }
}
