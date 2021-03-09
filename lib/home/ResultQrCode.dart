import 'package:flutter/material.dart';

class ResultQrCode extends StatelessWidget {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resultado do QrCode"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              code,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
