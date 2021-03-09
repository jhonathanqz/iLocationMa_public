import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:ilocationma/mapas/mapa_posto.dart';
import 'package:ilocationma/splash/model_Splash.dart';

void main() => runApp(SplashPosto());

class SplashPosto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPostoss(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashPostoss extends StatefulWidget {
  @override
  _SplashPostossState createState() => _SplashPostossState();
}

class _SplashPostossState extends State<SplashPostoss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SplashModel(
          tituloSplash: 'Posto de Combustível',
          localFlare: 'flare/Fuel.flr',
          animationFlare: 'run',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MapaPosto()));
    });
  }
}
