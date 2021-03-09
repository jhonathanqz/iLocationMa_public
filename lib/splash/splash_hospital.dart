import 'package:flutter/material.dart';
import 'package:ilocationma/mapas/mapa_hospital.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:ilocationma/splash/model_Splash.dart';

void main() => runApp(SplashHosp());

class SplashHosp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashHospital(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashHospital extends StatefulWidget {
  @override
  _SplashHospitalState createState() => _SplashHospitalState();
}

class _SplashHospitalState extends State<SplashHospital> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SplashModel(
            tituloSplash: 'Hospitais' ,
            localFlare: 'flare/Hopsital.flr',
            animationFlare: 'spin',
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MapaHospital()));
    });
  }
}
