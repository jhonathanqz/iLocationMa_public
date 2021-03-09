import 'package:flutter/material.dart';
import 'package:ilocationma/mapas/mapa_bancos.dart';
import 'package:ilocationma/splash/model_Splash.dart';

void main() => runApp(SplashBancos());

class SplashBancos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashBancoss(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashBancoss extends StatefulWidget {
  @override
  _SplashBancossState createState() => _SplashBancossState();
}

class _SplashBancossState extends State<SplashBancoss> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: SplashModel(
              tituloSplash: 'Bancos',
              localFlare: 'flare/FlareMoneyy.flr',
              animationFlare: 'Untitled',
      )),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MapaBancos()));
    });
  }
}
