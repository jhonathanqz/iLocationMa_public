import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:ilocationma/mapas/mapa_posto.dart';

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
        child:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text("Posto de Combustível", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                  child: FlareActor("flare/Fuel.flr", animation: "run",),
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
          MaterialPageRoute(builder: (context) => MapaPosto())
      );
    });
  }


}









