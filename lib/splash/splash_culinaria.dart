import 'package:flutter/material.dart';
import 'package:ilocationma/mapas/mapa_culinaria.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:ilocationma/splash/model_Splash.dart';

void main() => runApp(SplashCulinaria());

class SplashCulinaria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashCulinariaa(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashCulinariaa extends StatefulWidget {
  @override
  _SplashCulinariaaState createState() => _SplashCulinariaaState();
}

class _SplashCulinariaaState extends State<SplashCulinariaa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SplashModel(
          tituloSplash: 'Alimentação',
          localFlare: 'flare/FlareCulinaria.flr',
          animationFlare: 'spin',
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MapaCulinaria()));
    });
  }
}
