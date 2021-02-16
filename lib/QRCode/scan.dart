import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/QRCode/HomeQRCode.dart';
import 'package:ilocationma/QRCode/scan.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:url_launcher/url_launcher.dart';
import 'generate.dart';


void main() => runApp(MyScanQRCode());

class MyScanQRCode extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScanQRCode(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ScanQRCode extends StatefulWidget {
  @override
  _ScanQRCodeState createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String qrCodeResult = "Não há nada Scaneado!";

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
                  Text('Scanner QrCode',
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
                      Text(
                        "Resultado",
                        style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 15,),
                      FlatButton(onPressed: () {
                        if (qrCodeResult.contains("http")){
                          launch("$qrCodeResult");
                        }else{

                        }
                      },
                        child: Text(
                          qrCodeResult,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),


                      FlatButton(
                        padding: EdgeInsets.all(15.0),
                        onPressed: () async {

                          String codeSanner = await BarcodeScanner.scan();    //barcode scnner
                          setState(() {
                            qrCodeResult = codeSanner;
                          });

                        },
                        child: Text(
                          "Abrir Scanner",
                          style:
                          TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue, width: 3.0),
                            borderRadius: BorderRadius.circular(20.0)),
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

}
