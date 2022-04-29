import 'package:consultorio/routes/navegate.dart';
import 'package:consultorio/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _appBar(),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF4EA), Color(0xFFBCB8B5)],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _EntryCircle(),
              MaterialButton(
                color: Color(0xFF72828E),
                elevation: 14.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'Ingresar',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      contentPadding: EdgeInsets.only(left: 25, right: 25),
                      title: Center(child: Text("Términos y condiciones")),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      content: Container(
                        height: 500,
                        width: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Text('Tratamiento de datos:'),
                              Text(
                                'Decreto 1377 de 2013:',
                              ),
                              Text(
                                '* Articulo ${1}' * 40,
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    states.contains(MaterialState.pressed)
                                        ? Color(0xFF72828E)
                                        : Color(0xFF72828E)),
                          ),
                          child: Text(
                            'Acepto',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: () async {
                            dynamic result = await _auth.SignInAnon();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Bienvenido, ingrese su consulta'),
                            ));
                            if (result == null) {
                              print('Error signing in');
                            } else {
                              print('signed in');
                              print(result.uid);
                            }
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    states.contains(MaterialState.pressed)
                                        ? Color(0xFF72828E)
                                        : Color(0xFF72828E)),
                          ),
                          child: Text(
                            'No Acepto',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ),
                  );

                  /*      */
                  //Navigate.goToform(context);
                },
              ),
              MaterialButton(
                elevation: 14.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  'ayuda',
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Colors.brown,
                  ),
                ),
                onPressed: () {
                  Navigate.goToHelp(context);
                },
              ),
              Text(
                'Al ingresar, ha aceptado términos y condiciones.',
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.brown,
                ),
                textAlign: TextAlign.center,
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
        Container(
          height: 286,
          width: 286,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 20.0,
                offset: Offset(0.0, 9.0),
                spreadRadius: 5.0,
              ),
            ],
          ),
          child: ClipOval(
            child: Material(
              color: Color(0xFF72828E),
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: SizedBox(
                        width: 254,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Consultorios',
                                style: TextStyle(
                                  fontSize: 45.0,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: 'jurídicos',
                                style: TextStyle(
                                  fontSize: 45.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
      backgroundColor: Color(0xFF515463),
      title: const Text(
        'BIENVENIDO',
        style: TextStyle(fontSize: 35.0),
      ),
    );
  }
}
