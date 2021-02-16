import 'package:flutter/material.dart';
import 'package:ilocationma/mapas/mapa_banheiro.dart';

import 'package:flare_flutter/flare_actor.dart';

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
                child: Text("Banheiros", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
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
                  child: FlareActor("flare/Banheiro.flr", animation: "spin",),
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

    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MapaBanheiro())
      );
    });
  }


}









