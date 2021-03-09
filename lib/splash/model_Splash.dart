import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class SplashModel extends StatelessWidget {

  SplashModel({
    this.tituloSplash,
    this.localFlare,
    this.animationFlare,
  });

  String tituloSplash;
  String localFlare;
  String animationFlare;

  @override
  Widget build(BuildContext context) =>
    Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            gradient: LinearGradient(colors: <Color>[
              Colors.blue[900],
              Colors.blue[500],
            ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  tituloSplash,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 50, bottom: 8, right: 5),
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      gradient: LinearGradient(colors: <Color>[
                        Colors.blue[900],
                        Colors.blue[500],
                      ])),
                  child: FlareActor(
                    localFlare,
                    animation: animationFlare,
                  ),
                ),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      );
  
}