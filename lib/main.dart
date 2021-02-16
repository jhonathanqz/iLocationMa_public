import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilocationma/LoginScreen.dart';
import 'package:ilocationma/home/HomeEscolha.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:ilocationma/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp()
  );

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

      home: MyHomePrincipal()
    );

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
              tileMode: TileMode.clamp
          )
      ),
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
              tileMode: TileMode.clamp
          )
      ),
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
              tileMode: TileMode.clamp
          )
      ),
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
              tileMode: TileMode.clamp
          )
      ),
    );
  }
}


