import 'package:cloud_firestore/cloud_firestore.dart';
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
      //con esto podemos ver si ya se envio el formulario
      try {
        //intenta buscar en la base de datos si hay una solicitud con el id proporcionado, para luego
        //obtener el campo estado
        FirebaseFirestore.instance
            .collection('solicitudes')
            .where('uid', isEqualTo: user.uid)
            .get()
            .then((QuerySnapshot querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if (doc['estado'] == 'Enviado') {
              estadoForm.existeForm = 'holi';
            } else {
              estadoForm.existeForm = 'no';
            }
          });
        });
      } catch (e) {
        print('CHALE NO FUNCIONA' + e.toString());
      }

      print('funcionaaaaaaaaa  plis ${estadoForm.existeForm}');
      //(estadoForm.existeForm == 'holi') ? print('SI HAY') : print('NONAS NO');

      if (estadoForm.estadoForm || estadoForm.existeForm == 'holi') {
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
