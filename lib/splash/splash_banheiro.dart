import 'package:flutter/material.dart';
import 'package:ilocationma/mapas/mapa_banheiro.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:ilocationma/splash/model_Splash.dart';

void main() => runApp(SplashBan());

class SplashBan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashBanheiro(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashBanheiro extends StatefulWidget {
  @override
  _SplashBanheiroState createState() => _SplashBanheiroState();
}

class _SplashBanheiroState extends State<SplashBanheiro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SplashModel(
          tituloSplash: 'Banheiros',
          localFlare: 'flare/Banheiro.flr',
          animationFlare: 'spin',
        )
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MapaBanheiro()));
    });
  }
}
