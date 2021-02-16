import 'package:flutter/material.dart';
import 'package:ilocationma/mapas/mapa_bancos.dart';
import 'package:flare_flutter/flare_actor.dart';

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
                child: Text("Bancos", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                  child: FlareActor("flare/FlareMoneyy.flr", animation: "Untitled",),
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
          MaterialPageRoute(builder: (context) => MapaBancos())
      );
    });
  }


}









