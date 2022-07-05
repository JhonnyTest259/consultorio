import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../models/user.dart';
import '../pages/status_page.dart';

class getState extends StatefulWidget {
  @override
  State<getState> createState() => _getStateState();
}

class _getStateState extends State<getState> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsIOS;
  var initializationSettings;
  void _showNotification() async {
    await _demoNotification();
  }

  Future<void> _demoNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Hola,',
        'El estado de tu solicitud se ha actualizado', platformChannelSpecifics,
        payload: 'test payload');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String? payload) async {
    if (payload != null) {
      print('Notification payload: $payload');
    }
    await Navigator.push(
        context, new MaterialPageRoute(builder: (context) => StatusPage()));
  }

  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? playload) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('ok'),
            isDefaultAction: true,
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StatusPage()));
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    try {
      if (user?.uid != null) {
        final Stream<QuerySnapshot> _stateStream = FirebaseFirestore.instance
            .collection('solicitudes')
            .where('uid', isEqualTo: user!.uid)
            .snapshots();

        return StreamBuilder<QuerySnapshot>(
          stream: _stateStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text(
                'Algo fue mal',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                "Enviando...",
                style: TextStyle(
                  fontSize: 45.0,
                  color: Colors.white,
                ),
              );
            }
            return Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                String _textoEnviado = 'Enviado';
                if (_textoEnviado != data['estado']) {
                  _showNotification();
                  _textoEnviado = data['estado'];
                }
                return ListTile(
                  title: Center(
                    child: Text(
                      "${data['estado']}",
                      style: const TextStyle(
                        fontSize: 45.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        );
      } else {
        return const Text(
          'Sesion cerrada',
          style: TextStyle(
            fontSize: 45.0,
            color: Colors.white,
          ),
        );
      }
    } catch (e) {
      print("Error estado:" + e.toString());
      return const Text('Error');
    }
  }
}
