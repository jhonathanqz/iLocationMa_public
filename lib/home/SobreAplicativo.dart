import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/model/FAQ_Model.dart';
import 'HomePrincipal.dart';


void main() => runApp(MySobreApp());

class MySobreApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SobreApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SobreApp extends StatefulWidget {
  @override
  _SobreAppState createState() => _SobreAppState();
}

class _SobreAppState extends State<SobreApp> {


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
          SizedBox(height: 10,),
          FadeAnimation(1,
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[
                  Text('Sobre o Aplicativo',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 20.0))
                ],
              ),

            ),),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(35.0), topRight: Radius.circular(35)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.all(10),
              children: <Widget>[

                Padding(padding: EdgeInsets.only(top: 10,bottom: 30,left: 5, right: 5),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 35,),
                    FadeAnimation(1, Container(
                        width: MediaQuery.of(context).size.width,

                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "       O aplicativo iLocationMa foi desenvolvido por Jhonathan C. Queiroz como projeto de trabalho para apresentação de TCC no curso de Ciência da Computação," " e também com o intuito de poder ajudar a administração de turismo na cidade de Monte Alto - SP."

                                "\n\n       Aos leitores, gostaria de deixar minha profunda gratidão há todos os envolvidos que me auxiliaram e me apoiaram no desenvolvimento do aplicativo.",
                            style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                            textAlign: TextAlign.justify,
                          ),
                        )),),
                    SizedBox(height: 20,),
                    Center(
                      child: Text("iLocationMa v1.0.0",style: TextStyle(
                          fontSize: 17
                      ),),
                    ),




                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: 500,
                      width: 300,
                      child: PageView(
                        children: <Widget>[
                          _img("assets/Logo_black.png"),
                        ],
                      ),
                    ),
                  ],
                ),),

              ],
            ),
          )
        ],
      ),
    );
  }
  _img(String img) {
    return Image.asset(
      img,
      fit: BoxFit.cover,
    );
  }

}
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height - 50);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}