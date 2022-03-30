import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:consultorio/pages/wrapper.dart';
import 'package:consultorio/routes/navegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new Wrapper()));
        print('Mostrado una vez');
      });
    } else {
      await prefs.setBool('seen', true);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*  Timer(Duration(seconds: 3), () {
      Navigate.goToWrapper(context);
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF4EA), Color(0xFFBCB8B5)],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                'assets/svg/logo1.svg',
                height: 250,
                width: 250,
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              CircularProgressIndicator(
                color: Colors.white,
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
