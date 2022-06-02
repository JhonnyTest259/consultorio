import 'package:consultorio/pages/home/terminos.dart';
import 'package:consultorio/routes/navegate.dart';
import 'package:consultorio/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  bool valueT = false;
  bool isLoading = false;
  bool isButtonActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _appBar(),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 32.0)),
              _EntryCircle(),
              const Padding(padding: EdgeInsets.only(top: 100.0)),
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
                child: FlatButton(
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: isButtonActive
                      ? () async {
                          if (valueT) {
                            setState(() {
                              isButtonActive = false;
                              isLoading = true;
                            });
                            dynamic result = await _auth.SignInAnon();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Bienvenido, ingrese su consulta'),
                              backgroundColor: Color(0xFF7A0C29),
                            ));
                            if (result == null) {
                              print('Error signing in');
                            } else {
                              print('signed in');
                              print(result.uid);
                            }
                          } else {
                            setState(() => isButtonActive = false);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text('Debes aceptar términos y condiciones.'),
                              backgroundColor: Color(0xFF7A0C29),
                            ));
                            await Future.delayed(const Duration(seconds: 5));
                            setState(() => isButtonActive = true);
                          }
                        }
                      : null,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    activeColor: Color(0xFF7A0C29),
                    value: valueT,
                    onChanged: (bool? value) {
                      setState(() {
                        valueT = value!;
                      });
                    },
                  ),
                  MaterialButton(
                    elevation: 14.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Aceptar',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFF3F3F3F),
                            ),
                          ),
                          TextSpan(
                            text: ' términos y condiciones',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 112, 6, 0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          contentPadding:
                              const EdgeInsets.only(left: 25, right: 25),
                          title: const Center(
                              child: Text("Términos y condiciones")),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          content: Container(
                            height: 500,
                            width: 300,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  terminos(),
                                ],
                              ),
                            ),
                          ),
                          actions: <Widget>[
                            Container(
                              alignment: Alignment.centerRight,
                              child: MaterialButton(
                                elevation: 14.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: const Text(
                                  'volver',
                                  style: TextStyle(
                                    fontSize: 19.0,
                                    color: Color(0xFF3F3F3F),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 50.0)),
              (isLoading)
                  ? const SizedBox(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 112, 6, 0),
                      ),
                    )
                  : const Text(''),
              MaterialButton(
                elevation: 14.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: const Text(
                  'Ayuda',
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Colors.brown,
                  ),
                ),
                onPressed: () async {
                  Navigate.goToHelp(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EntryCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SvgPicture.asset(
          'assets/svg/Icono.svg',
          height: 250,
          width: 250,
        ),
      ],
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
      backgroundColor: Color.fromARGB(255, 112, 6, 0),
      title: const Text(
        'BIENVENIDO',
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
