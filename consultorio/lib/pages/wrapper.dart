import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultorio/models/user.dart';
import 'package:consultorio/pages/forms/form_page.dart';
import 'package:consultorio/pages/home/home_page.dart';
import 'package:consultorio/pages/status_page.dart';
import 'package:consultorio/routes/navegate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Con esto podemos obtener al usuario si inicio o cerro sesion
    final user = Provider.of<MyUser?>(context);

    //return either home or Authenticate widget
    if (user != null) {
      print(user);
      return FormPage();
    } else {
      return HomePage();
    }
  }
}
