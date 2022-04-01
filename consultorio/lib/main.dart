import 'package:consultorio/models/stateform.dart';
import 'package:consultorio/models/user.dart';
import 'package:consultorio/pages/forms/form_page.dart';
import 'package:consultorio/pages/info/help_page.dart';
import 'package:consultorio/pages/home/temporal_page.dart';
import 'package:consultorio/pages/status_page.dart';
import 'package:consultorio/pages/home/home_page.dart';
import 'package:consultorio/pages/wrapper.dart';
import 'package:consultorio/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<MyUser?>.value(
          initialData: null,
          value: AuthService().user,
        ),
        ChangeNotifierProvider(
          create: (_) => StateForm(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ConsultorioJuridico',
        theme: ThemeData(
          fontFamily: 'Javanese Text',
        ),
        home: TemporalPage(), //TemporalhPage(),
        routes: routes,
      ),
    );
  }
}

final routes = <String, WidgetBuilder>{
  "/welcome": (BuildContext context) => HomePage(),
  "/form": (BuildContext context) => FormPage(),
  "/help": (BuildContext context) => HelpPage(),
  "/state": (BuildContext context) => StatusPage(),
  "/wrapper": (BuildContext context) => Wrapper(),
};
