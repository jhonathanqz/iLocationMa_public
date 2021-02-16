import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/model/FAQ_Model.dart';
import 'HomePrincipal.dart';


void main() => runApp(MyFAQ2());

class MyFAQ2 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FAQ2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FAQ2 extends StatefulWidget {
  @override
  _FAQ2State createState() => _FAQ2State();
}

class _FAQ2State extends State<FAQ2> {

  TextEditingController _controllerNome = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _validarCampos() {
    //Recupera dados dos campos
    String nome = _controllerNome.text;


    FAQmodel loc = FAQmodel();
    loc.nome = nome;


    _cadastrarLoc(loc);


    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(16)),
          elevation: 2,
          backgroundColor: Colors.grey[200],
          title: Text(
            "Enviado com Sucesso!!!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          content: Text(
            "Muito obrigado pela sua contribuição. Estamos trabalhando para melhorar cada vez mais! :)",
            style: TextStyle(fontSize: 17),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.thumbsUp),
              iconSize: 45,
              color: Colors.blue,
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyHomePrincipal()));
              },
            ),
          ],
        ));


  }

  _cadastrarLoc(FAQmodel loc) {
    var db = FirebaseFirestore.instance;
    db.collection("FAQ").add({
      "nome": loc.nome,

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  Text('FAQ',
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
              borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.all(16),
              children: <Widget>[

                Padding(padding: EdgeInsets.only(top: 10,bottom: 30,left: 35),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(1, Container(
                        width: MediaQuery.of(context).size.width,

                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "\n         Por favor, digite logo abaixo sua Sugestão/Reclamação/Elogio, para que possamos melhorar cada vez mais. \n\n Obrigado!",
                            style: TextStyle(
                                fontSize: 17,
                                fontStyle: FontStyle.italic,
                                color: Colors.black),
                            textAlign: TextAlign.justify,
                          ),
                        )),),

                    SizedBox(height: 20,),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                      child: FadeAnimation(1, Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[100]))
                        ),
                        child: TextField(
                          controller: _controllerNome,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(

                              prefixIcon: Icon(
                                FontAwesomeIcons.edit,
                                color: Colors.blue[900],
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),),
                              hintText: "Sugestão, Reclamação ou Elogio",
                              labelText: ("Sugestão, Reclamação ou Elogio"),
                              hintStyle: TextStyle(color: Colors.grey[400])
                          ),
                        ),
                      ),),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FlatButton(
                      onPressed: () {
                        if (_controllerNome.text != ''){
                          setState(() {
                            _validarCampos();
                          });
                        }else {
                            _onFail("Existe campos em branco!");
                        }
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
                          child: Text("Enviar", style: TextStyle(color: Colors.white,
                              fontWeight: FontWeight.bold, fontSize: 17),),
                        ),
                      )),
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

  void _onFail(String _text){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(_text, style: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold
      ),),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
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