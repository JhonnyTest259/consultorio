import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class getState extends StatefulWidget {
  @override
  State<getState> createState() => _getStateState();
}

class _getStateState extends State<getState> {
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
