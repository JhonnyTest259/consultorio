import 'package:consultorio/models/stateform.dart';
import 'package:consultorio/pages/wrapper.dart';
import 'package:consultorio/routes/navegate.dart';
import 'package:consultorio/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:consultorio/models/stateform.dart';

import '../../models/user.dart';

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _nombre = '';
  String _identificacion = '';
  String _salario = '';
  String _edad = '';
  String _estadoCivil = '';
  String _barrioResidencia = '';
  String _direccionCasa = '';
  String _telefonoCasa = '';
  String _direccionTrabajo = '';
  String _email = '';
  String _descripcionConsulta = '';
  String _estado = 'Enviado';

  bool sendForm = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    final estadoFrom = Provider.of<StateForm>(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _appBar(),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF4EA), Color(0xFFBCB8B5)],
            ),
          ),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                child: Column(
                  children: [
                    _crearNombre(),
                    Divider(),
                    _crearIdentificacion(),
                    Divider(),
                    _crearSalario(),
                    Divider(),
                    _crearEdad(),
                    Divider(),
                    _crearEstadoCivil(),
                    Divider(),
                    _crearBarrio(),
                    Divider(),
                    _crearDireccionCasa(),
                    Divider(),
                    _crearTelefono(),
                    Divider(),
                    _crearDireccionTrabajo(),
                    Divider(),
                    _crearEmail(),
                    Divider(),
                    _crearDescripcion(),
                    Divider(),
                    MaterialButton(
                      color: Color(0xFF72828E),
                      elevation: 14.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      onPressed: () async {
                        await DatabaseService(uid: user!.uid).insertDataUser(
                            user.uid.toString(),
                            _nombre,
                            _identificacion,
                            _salario,
                            _edad,
                            _estadoCivil,
                            _barrioResidencia,
                            _direccionCasa,
                            _telefonoCasa,
                            _direccionTrabajo,
                            _email,
                            _descripcionConsulta,
                            _estado);

                        estadoFrom.estadoForm = true;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _crearNombre() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Nombre completo',
      ),
      onChanged: (valor) => setState(() {
        _nombre = valor;
      }),
    );
  }

  _crearIdentificacion() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Identificacion',
      ),
      onChanged: (valor) => setState(() {
        _identificacion = valor;
      }),
    );
  }

  _crearSalario() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Salario',
      ),
      onChanged: (valor) => setState(() {
        _salario = valor;
      }),
    );
  }

  _crearEdad() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Edad',
      ),
      onChanged: (valor) => setState(() {
        _edad = valor;
      }),
    );
  }

  _crearEstadoCivil() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Estado Civil',
      ),
      onChanged: (valor) => setState(() {
        _estadoCivil = valor;
      }),
    );
  }

  _crearBarrio() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Barrio de residencia',
      ),
      onChanged: (valor) => setState(() {
        _barrioResidencia = valor;
      }),
    );
  }

  _crearDireccionCasa() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Direccion casa',
      ),
      onChanged: (valor) => setState(() {
        _direccionCasa = valor;
      }),
    );
  }

  _crearTelefono() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Telefono casa',
      ),
      onChanged: (valor) => setState(() {
        _telefonoCasa = valor;
      }),
    );
  }

  _crearDireccionTrabajo() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Direccion trabajo',
      ),
      onChanged: (valor) => setState(() {
        _direccionTrabajo = valor;
      }),
    );
  }

  _crearEmail() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Correo electronico',
      ),
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  _crearDescripcion() {
    return TextField(
      maxLines: 8,
      decoration: InputDecoration(
        hintText: 'Descripcion de la consulta',
      ),
      onChanged: (valor) => setState(() {
        _descripcionConsulta = valor;
      }),
    );
  }
}

class _appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80.0,
      centerTitle: true,
      elevation: 14.0,
      backgroundColor: Color(0xFF515463),
      title: const Text(
        'Ingrese su solicitud',
        style: TextStyle(fontSize: 35.0),
      ),
    );
  }
}
