import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:permission_handler/permission_handler.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              gradient: LinearGradient(colors: <Color>[
                Colors.blue[900],
                Colors.blue[500],
              ])),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: <Color>[
                          Colors.blue[900],
                          Colors.blue[500],
                        ])),
                    margin: EdgeInsets.only(top: 0, bottom: 8, right: 5),
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: FlareActor(
                      'flare/Location.flr',
                      animation: 'spin',
                    ),
                  ),
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      auth.authStateChanges().listen((User user) {
        if (user == null) {
          grantPermissions();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyHomePrincipal()));
        } else {
          grantPermissions();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MyHomePrincipal()));
        }
      });
    });
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
    if (await Permission.locationWhenInUse.isUndetermined ||
        await Permission.locationWhenInUse.isDenied) {
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.camera.isUndetermined ||
        await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
    if (await Permission.storage.isUndetermined ||
        await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }
}
