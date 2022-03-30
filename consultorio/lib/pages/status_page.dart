import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final estadoFrom = Provider.of<StateForm>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _AppBar(),
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFFFF4EA), Color(0xFFBCB8B5)],
            ),
          ),
          child: Column(
            children: [
              _EntryCircle(),
              SizedBox(
                height: 56,
              ),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(microseconds: 500),
                child: MaterialButton(
                  color: Color(0xFF72828E),
                  elevation: 14.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Text(
                    'Cerrar sesion',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    //Navigate.goToWelcome(context);
                    setState(() {
                      _visible = !_visible;
                    });
                    estadoFrom.estadoForm = false;
                    //Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
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
      backgroundColor: Color(0xFF515463),
      title: const Text(
        'ESTADO SOLICITUD',
        style: TextStyle(fontSize: 35.0),
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
        Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Container(
            height: 320,
            width: 320,
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
