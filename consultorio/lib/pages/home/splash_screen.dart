// ignore_for_file: unnecessary_new

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consultorio/pages/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/stateform.dart';
import '../../models/user.dart';

class TemporalPage extends StatefulWidget {
  @override
  State<TemporalPage> createState() => _TemporalPageState();
}

class _TemporalPageState extends State<TemporalPage>
    with AfterLayoutMixin<TemporalPage> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Timer(const Duration(seconds: 5), () {
        Navigator.of(context)
            // ignore: unnecessary_new
            .pushReplacement(new MaterialPageRoute(builder: (context) {
          final user = Provider.of<MyUser?>(context);
          final estadoForm = Provider.of<StateForm>(context);
          if (user != null) {
            while (estadoForm.estadoForm) {
              FirebaseFirestore.instance
                  .collection('solicitudes')
                  .where('uid', isEqualTo: user.uid)
                  .get()
                  .then((QuerySnapshot querySnapchot) {
                querySnapchot.docs.forEach((doc) {
                  if (doc['estado'] != '') {
                    estadoForm.stateForm = 'si';
                  } else {
                    estadoForm.stateForm = 'no';
                  }
                });
              });

              estadoForm.estadoForm = false;
            }
          } else {
            print('no hay aun');
          }
          return Wrapper();
        }));

        //GetStatus(user);
      });
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new Wrapper()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/Icono.svg',
                height: 250,
                width: 250,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40.0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              CircularProgressIndicator(
                color: Color.fromARGB(255, 112, 6, 0),
              ),
              Text(
                'From',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 1),
              Text(
                'Jhonatan Alejandro Mejia',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 40.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
