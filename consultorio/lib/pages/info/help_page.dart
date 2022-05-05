import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          toolbarHeight: 80.0,
          centerTitle: true,
          elevation: 14.0,
          backgroundColor: Color.fromARGB(255, 112, 6, 0),
          title: const Text(
            'CONSULTORIO',
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
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("DUDAS PARA RESOLVER"),
            ],
          ),
        ],
      ),
    );
  }
}
