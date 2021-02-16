import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/QRCode/scan.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'HomeQRCode.dart';
import 'generate.dart';


void main() => runApp(MyGerarQRCode());

class MyGerarQRCode extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GerarQRCode(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GerarQRCode extends StatefulWidget {
  @override
  _GerarQRCodeState createState() => _GerarQRCodeState();
}

class _GerarQRCodeState extends State<GerarQRCode> {

  String qrData =
      "https://www.google.com";

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
                        builder: (context) => MyHomeQR()
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
                  Text('Gerador de QRCode',
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
                      QrImage(
                        //plce where the QR Image will be shown
                        data: qrData,
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Text(
                        "Digite o Link para gerar QR Code",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      TextField(
                        controller: qrdataFeed,
                        decoration: InputDecoration(
                          hintText: "Insira seu link aqui",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
                        child: FlatButton(
                          padding: EdgeInsets.all(15.0),
                          onPressed: () async {

                            if (qrdataFeed.text.isEmpty) {        //a little validation for the textfield
                              setState(() {
                                qrData = "";
                              });
                            } else {
                              setState(() {
                                qrData = qrdataFeed.text;
                              });
                            }

                          },
                          child: Text(
                            "Gerar QR Code",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.blue, width: 3.0),
                              borderRadius: BorderRadius.circular(20.0)),
                        ),
                      )
                    ],
                  ),),

              ],
            ),
          )
        ],
      ),
    );
  }
  final qrdataFeed = TextEditingController();

}
