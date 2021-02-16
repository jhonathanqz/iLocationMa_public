import 'package:flutter/material.dart';
import 'package:ilocationma/mapas/homemap/HomeMapTur.dart';
import 'package:ilocationma/mapas/mapa_turismo.dart';
import 'package:flare_flutter/flare_actor.dart';

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            gradient: LinearGradient(colors: <Color>[
              Colors.blue[900],
              Colors.blue[500],
            ])
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("Turismo", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
              ),
              Center(
                child:Container(
                  margin: EdgeInsets.only(top: 50, bottom: 8, right: 5),
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      gradient: LinearGradient(colors: <Color>[
                        Colors.blue[900],
                        Colors.blue[500],
                      ])
                  ),
                  child: FlareActor("flare/FlareLocation.flr", animation: "Untitled",),
                ),
              ),
              CircularProgressIndicator(backgroundColor: Colors.white,),






            ],



          ),




        ),
      ),

    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeMapTur())
      );
    });
  }


}









