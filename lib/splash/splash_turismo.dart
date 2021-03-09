import 'package:flutter/material.dart';
import 'package:ilocationma/mapas/homemap/HomeMapTur.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:ilocationma/splash/model_Splash.dart';

void main() => runApp(SplashTurismo());

class SplashTurismo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashTurismoo(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashTurismoo extends StatefulWidget {
  @override
  _SplashTurismooState createState() => _SplashTurismooState();
}

class _SplashTurismooState extends State<SplashTurismoo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SplashModel(
          tituloSplash: 'Turismo',
          localFlare: 'flare/FlareLocation.flr',
          animationFlare: 'Untitled',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeMapTur()));
    });
  }
}
