import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference soliCollection =
      FirebaseFirestore.instance.collection('solicitudes');

  Future insertDataUser(
      String uid,
      String nombre,
      String identificacion,
      String salario,
      String edad,
      String estadoCivil,
      String barrio,
      String direccionCasa,
      String telefono,
      String direccionTrabajo,
      String email,
      String descripcion,
      String estado) async {
    return await soliCollection.doc(uid).set({
      'uid': uid,
      'nombre': nombre,
      'identificacion': identificacion,
      'salario': salario,
      'edad': edad,
      'estado civil': estadoCivil,
      'barrio': barrio,
      'direccion de casa': direccionCasa,
      'telefono': telefono,
      'direccion de trabajo': direccionTrabajo,
      'email': email,
      'descripcion': descripcion,
      'estado': estado,
    });
  }
}
