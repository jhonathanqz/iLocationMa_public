import 'package:flutter/material.dart';
import 'package:ilocationma/home/HomeEscolha.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:ilocationma/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'iLocationMa Flutter',
        home: MyHomePrincipal());
  }
}
Future<void> grantPermissions() async {
  if (await Permission.location.isUndetermined ||
      await Permission.location.isDenied) {
    await Permission.location.request();
  }
  if (await Permission.locationAlways.isUndetermined ||
      await Permission.locationAlways.isDenied) {
    await Permission.locationAlways.request();
  }
}

class MyApp2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iLocationMa Flutter',
      home: HomeEscolha(),
    );
  }
}

class AppBarGradient1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue[900],
                Colors.blue[600],
              ],
              tileMode: TileMode.clamp)),
    );
  }
}

class AppBarGradient2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue[900],
                Colors.blue[600],
              ],
              tileMode: TileMode.clamp)),
    );
  }
}

class AppBarGradient3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue[900],
                Colors.blue[600],
              ],
              tileMode: TileMode.clamp)),
    );
  }
}

class AppBarGradient4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue[900],
                Colors.blue[600],
              ],
              tileMode: TileMode.clamp)),
    );
  }
}
