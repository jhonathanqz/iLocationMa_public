import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import '../mapa_turismo.dart';
import '../mapa_turismo_ecoturismo.dart';
import '../mapa_turismo_religioso.dart';


void main() => runApp(MyHomeMapTur());

class MyHomeMapTur extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeMapTur(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeMapTur extends StatefulWidget {
  @override
  _HomeMapTurState createState() => _HomeMapTurState();
}

class _HomeMapTurState extends State<HomeMapTur> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyHomePrincipal()
                    ));
                  },
                ),

              ],
            ),
          ),
          SizedBox(height: 25.0),
          FadeAnimation(1,
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[
                  Text('iLocationMA' ,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0)),

                ],
              ),

            ),),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Column(
                  children: [
                    FadeAnimation(1, Container(
                        width: MediaQuery.of(context).size.width,

                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              "Selecione abaixo, qual opção de turismo você procura.",style: TextStyle(
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                            textAlign: TextAlign.justify,
                          ),
                        )),),

                    SizedBox(height: 25,),


                    _flatButton(FontAwesomeIcons.mapMarker, "Turismo Local", MapaTurismo()),

                    SizedBox(height: 20,),

                    _flatButton(FontAwesomeIcons.prayingHands, "Turismo Religioso", MapaTurismoReligioso()),

                    SizedBox(height: 20,),

                    _flatButton(FontAwesomeIcons.pagelines, "Ecoturismo", MapaTurismoEcoturismo()),

                    FadeAnimation(2, Container(
                      margin: EdgeInsets.only(top: 50, bottom: 50),
                      height: 300,
                      width: 400,
                      child: PageView(
                        children: <Widget>[
                          _img("assets/dinossauro5.jpg"),
                        ],
                      ),
                    ),),
                  ],
                )

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _flatButton(FontAwesomeIcons, _text, controller) {
    return FadeAnimation(2, FlatButton(
        child: Container(
          margin: EdgeInsets.all(0),
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: <Color>[
                Colors.blue[900],
                Colors.blue[600],
              ])),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 20,
              ),
              Icon(
                FontAwesomeIcons,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                _text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => controller
          ));

        }

    ),);
  }

  _img(String img) {
    return Image.asset(
      img,
      fit: BoxFit.fill,
    );
  }


}
