import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/stateform.dart';
import '../services/getState.dart';

class StatusPage extends StatefulWidget {
  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  bool _visible = true;
  @override
  Widget build(BuildContext context) {
    final estadoForm = Provider.of<StateForm>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _AppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _EntryCircle(),
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: Duration(microseconds: 500),
              child: Container(
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
                    'Cerrar sesion',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    //Navigate.goToWelcome(context);
                    setState(() {
                      _visible = !_visible;
                    });
                    estadoForm.stateForm = 'no';
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove("enviado");
                    //Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80.0,
      centerTitle: true,
      elevation: 14.0,
      backgroundColor: Color.fromARGB(255, 112, 6, 0),
      title: const Text(
        'ESTADO SOLICITUD',
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

class _EntryCircle extends StatelessWidget {
  String _estado = 'Enviado';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 250,
          width: 250,
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
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(125.0)),
              gradient: LinearGradient(
                colors: [Color(0xFFD10934), Color(0xFF7A0C29)],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
              ),
            ),
            child: ClipOval(
              child: Material(
                color: Color.fromARGB(0, 112, 6, 0),
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: getState(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
