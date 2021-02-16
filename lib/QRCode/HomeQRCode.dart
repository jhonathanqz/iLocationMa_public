import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/QRCode/scan.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'generate.dart';


void main() => runApp(MyHomeQR());

class MyHomeQR extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeQrCode(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeQrCode extends StatefulWidget {
  @override
  _HomeQrCodeState createState() => _HomeQrCodeState();
}

class _HomeQrCodeState extends State<HomeQrCode> {

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
                  Text('QRCode',
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
                      Image.network(
                        "https://images.vexels.com/media/users/3/158120/isolated/preview/bff830206408c36b53b196b155747b02-qr-code-on-smartphone-by-vexels.png",
                        loadingBuilder: (context, child, progress) {
                          return progress == null ? child: LinearProgressIndicator(backgroundColor: Colors.black87,);
                        },
                      ),
                      SizedBox(height: 20.0,),
                      FadeAnimation(1, flatButton("Scanner QR CODE", MyScanQRCode()),),
                      SizedBox(height: 20.0,),
                      FadeAnimation(2, flatButton("Gerar QR CODE", MyGerarQRCode()),),
                    ],
                  ),),

              ],
            ),
          )
        ],
      ),
    );
  }
  Widget flatButton(String text, Widget widget) {
    return FlatButton(
      padding: EdgeInsets.all(15.0),
      onPressed: () async {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => widget));
      },
      child: Text(
        text,
        style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue,width: 3.0),
          borderRadius: BorderRadius.circular(20.0)),
    );
  }

}
