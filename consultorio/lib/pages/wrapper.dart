import 'package:consultorio/models/user.dart';
import 'package:consultorio/pages/forms/form_page.dart';
import 'package:consultorio/pages/home/home_page.dart';
import 'package:consultorio/pages/status_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/stateform.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Con esto podemos obtener al usuario si inicio o cerro sesion
    final user = Provider.of<MyUser?>(context);
    //con esto podemos ver si ya se envio el formulario
    final estadoForm = Provider.of<StateForm>(context);

    //return either home or Authenticate widget
    if (user != null) {
      print('DESDE EL WRAPPER ${estadoForm.stateForm}');
      //con esto podemos ver si ya se envio el formulario
      if (estadoForm.stateForm == 'si') {
        return StatusPage();
      } else {
        print('Hay una sesion');
        return FormPage();
      }
    } else {
      return HomePage();
    }
  }
}
