import 'package:consultorio/models/stateform.dart';
import 'package:consultorio/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';

class FormPage extends StatefulWidget {
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String _nombre = '';
  String _identificacion = '';
  String _edad = '';
  String _barrioResidencia = '';
  String _direccionCasa = '';
  String _telefonoCasa = '';
  String _direccionTrabajo = '';
  String _email = '';
  String _descripcionConsulta = '';
  final String _estado = 'Enviado';
  final List<String> _estadoCivil = [
    'Seleccion',
    'Casado',
    'Soltero',
    'Viudo',
  ];
  final List<String> _salario = [
    'Seleccion',
    '0 a 1 SMLV',
    '2 a 3 SMLV',
    '4 o más SMLV',
  ];

  String _opcionSeleccionada = 'Seleccion';
  String _opcionSeleccionadaSalario = 'Seleccion';

  final _formKey = GlobalKey<FormState>();

  bool sendForm = false;
  bool isLoading = false;
  bool isButtonActive = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    final estadoForm = Provider.of<StateForm>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: _appBar(),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: ListView(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 32.0, right: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _crearNombre(),
                      const Divider(),
                      _crearIdentificacion(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Salario:',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF3F3F3F),
                            ),
                          ),
                          const SizedBox(width: 25.0),
                          _crearSalario(),
                          const Divider(),
                        ],
                      ),
                      const Divider(),
                      _crearEdad(),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          const Text(
                            'Estado civil:',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xFF3F3F3F),
                            ),
                          ),
                          const SizedBox(width: 25.0),
                          _crearEstadoCivil(),
                          const Divider(),
                        ],
                      ),
                      _crearBarrio(),
                      const Divider(),
                      _crearDireccionCasa(),
                      const Divider(),
                      _crearTelefono(),
                      const Divider(),
                      _crearDireccionTrabajo(),
                      const Divider(),
                      _crearEmail(),
                      const Divider(),
                      _crearDescripcion(),
                      const Divider(),
                      Container(
                        width: 250,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          gradient: LinearGradient(
                            colors: [Color(0xFFD10934), Color(0xFF7A0C29)],
                            begin: FractionalOffset.topCenter,
                            end: FractionalOffset.bottomCenter,
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            primary: Colors.transparent,
                          ),
                          onPressed: isButtonActive
                              ? () async {
                                  setState(() {
                                    isLoading = true;
                                    isButtonActive = false;
                                  });
                                  await Future.delayed(
                                      const Duration(seconds: 3));
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    guardarEstado('si');
                                    await DatabaseService(uid: user!.uid)
                                        .insertDataUser(
                                            user.uid.toString(),
                                            _nombre,
                                            _identificacion,
                                            _opcionSeleccionadaSalario,
                                            _edad,
                                            _opcionSeleccionada,
                                            _barrioResidencia,
                                            _direccionCasa,
                                            _telefonoCasa,
                                            _direccionTrabajo,
                                            _email,
                                            _descripcionConsulta,
                                            _estado);

                                    estadoForm.stateForm = 'si';
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          'Algunos campos necesitan revisión'),
                                      backgroundColor: Color(0xFF7A0C29),
                                    ));
                                  }
                                }
                              : null,
                          child: (isLoading)
                              ? const SizedBox(
                                  child: CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : const Text(
                                  'Enviar',
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> guardarEstado(estado) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString("enviado", estado);
  }

  _crearNombre() {
    return TextFormField(
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Debes introducir tu nombre';
        }
      },
      decoration: InputDecoration(
        hintText: 'Nombre completo',
      ),
      textInputAction: TextInputAction.next,
      onChanged: (valor) => setState(() {
        _nombre = valor;
      }),
    );
  }

  _crearIdentificacion() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Debes introducir tu identificación';
        }
      },
      decoration: InputDecoration(
        hintText: 'Identificacion',
      ),
      textInputAction: TextInputAction.next,
      onChanged: (valor) => setState(() {
        _identificacion = valor;
      }),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDownSalario() {
    List<DropdownMenuItem<String>> lista = [];

    _salario.forEach((estado) {
      lista.add(DropdownMenuItem(
        child: Text(estado),
        value: estado,
      ));
    });

    return lista;
  }

  _crearSalario() {
    return Row(
      children: [
        DropdownButton(
          borderRadius: BorderRadius.circular(15.0),
          style: TextStyle(fontSize: 18.0, color: Color(0xFF3F3F3F)),
          value: _opcionSeleccionadaSalario,
          items: getOpcionesDropDownSalario(),
          onChanged: (optS) {
            setState(() {
              _opcionSeleccionadaSalario = optS.toString();
            });
          },
        ),
      ],
    );
  }

  _crearEdad() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Debes introducir tu edad';
        }
      },
      decoration: InputDecoration(
        hintText: 'Edad',
      ),
      textInputAction: TextInputAction.next,
      onChanged: (valor) => setState(() {
        _edad = valor;
      }),
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown() {
    List<DropdownMenuItem<String>> lista = [];

    _estadoCivil.forEach((estado) {
      lista.add(DropdownMenuItem(
        child: Text(estado),
        value: estado,
      ));
    });

    return lista;
  }

  _crearEstadoCivil() {
    return Row(
      children: [
        DropdownButton(
          borderRadius: BorderRadius.circular(15.0),
          style: TextStyle(fontSize: 18.0, color: Color(0xFF3F3F3F)),
          value: _opcionSeleccionada,
          items: getOpcionesDropDown(),
          onChanged: (opt) {
            setState(() {
              _opcionSeleccionada = opt.toString();
            });
          },
        ),
      ],
    );
  }

  _crearBarrio() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Debes introducir tu barrio';
        }
      },
      decoration: InputDecoration(
        hintText: 'Barrio de residencia',
      ),
      textInputAction: TextInputAction.next,
      onChanged: (valor) => setState(() {
        _barrioResidencia = valor;
      }),
    );
  }

  _crearDireccionCasa() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Debes introducir tu direccion';
        }
      },
      decoration: InputDecoration(
        hintText: 'Direccion casa',
      ),
      textInputAction: TextInputAction.next,
      onChanged: (valor) => setState(() {
        _direccionCasa = valor;
      }),
    );
  }

  _crearTelefono() {
    return TextFormField(
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Debes introducir tu telefono';
        }
      },
      decoration: InputDecoration(
        hintText: 'Telefono casa',
      ),
      textInputAction: TextInputAction.next,
      onChanged: (valor) => setState(() {
        _telefonoCasa = valor;
      }),
    );
  }

  _crearDireccionTrabajo() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Debes introducir tu direccion del trabajo';
        }
      },
      decoration: InputDecoration(
        hintText: 'Direccion trabajo',
      ),
      textInputAction: TextInputAction.next,
      onChanged: (valor) => setState(() {
        _direccionTrabajo = valor;
      }),
    );
  }

  _crearEmail() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Debes introducir tu correo';
        }
      },
      decoration: InputDecoration(
        hintText: 'Correo electronico',
      ),
      textInputAction: TextInputAction.next,
      onChanged: (valor) => setState(() {
        _email = valor;
      }),
    );
  }

  _crearDescripcion() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Debes ingresar tu consulta';
        }
      },
      maxLines: 8,
      decoration: InputDecoration(
        hintText: 'Descripcion de la consulta',
      ),
      textInputAction: TextInputAction.done,
      onChanged: (valor) => setState(() {
        _descripcionConsulta = valor;
      }),
    );
  }
}

// ignore: camel_case_types
class _appBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80.0,
      centerTitle: true,
      elevation: 14.0,
      backgroundColor: Color.fromARGB(255, 112, 6, 0),
      title: const Text(
        'Ingrese su solicitud',
        style: TextStyle(fontSize: 35.0),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Color(0xFFD10934), Color(0xFF7A0C29)]),
        ),
      ),
    );
  }
}
