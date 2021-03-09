import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _emailUsuario = "";

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // ignore: deprecated_member_use
    FirebaseUser usuarioLogado = auth.currentUser;

    setState(() {
      _emailUsuario = usuarioLogado.email;
    });
  }

  @override
  void initState() {
    _recuperarDadosUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
      ),
      body: Container(
        child: Text(_emailUsuario),
      ),
    );
  }
}
