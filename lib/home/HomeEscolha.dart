
import 'package:flutter/material.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/CadUser.dart';
import 'package:ilocationma/LoginScreen.dart';
import 'package:ilocationma/home/HomePrincipal.dart';


class HomeEscolha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/light-1.png')
                              )
                          ),
                        )),
                      ),

                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.5, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/clock.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        child: FadeAnimation(1.6, Container(
                          margin: EdgeInsets.only(top: 300),
                          child: Center(
                            child: Text("", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[

                      SizedBox(height: 16,),
                      FadeAnimation(1.8, Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              ),

                            ]
                        ),
                      )),

                      SizedBox(height: 20,),

                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MyLoginScreen()));
                        },
                        child: FadeAnimation(2, Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.blue[900],
                                  Colors.blue[600],
                                ],
                              )
                          ),
                          child: Center(
                            child: Text("Entre", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),),
                          ),
                        )),
                      ),
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("ou", style: TextStyle(fontSize: 16, color: Colors.blue[800], fontWeight: FontWeight.bold),)
                        ],
                      ),
                      SizedBox(height: 25,),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => MyCadUser()));
                        },
                        child: FadeAnimation(2, Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Colors.blue[900],
                                  Colors.blue[600],
                                ],
                              )
                          ),
                          child: Center(
                            child: Text("Cadastre-se", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 14),),
                          ),
                        )),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}