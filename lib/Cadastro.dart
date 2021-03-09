import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ilocationma/LoginScreen.dart';

import 'package:ilocationma/model/CadUsuario.dart';
import 'model/Usuario.dart';

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  //Controladores
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  TextEditingController _controllerSenha2 = TextEditingController();
  String _mensagemErro = "";

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _validarCamposUsuario() {
    //Recupera dados dos campos
    String nomeCad = _controllerNome.text;
    String emailCad = _controllerEmail.text;
    String senhaCad = _controllerSenha.text;

    CadUsuario usuario = CadUsuario();
    usuario.nome = nomeCad;
    usuario.email = emailCad;
    usuario.senha = senhaCad;

    _cadastrarUser(usuario);
  }

  _cadastrarUser(CadUsuario usuario) {
    var db = FirebaseFirestore.instance;
    db.collection("usuarios").add({
      "nomeCadastro": usuario.nome,
      "emailCadastro": usuario.email,
      "senhaCadastro": usuario.senha,
    });
  }

  _validarCampos() {
    //Recupera dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (nome.isNotEmpty || _controllerNome.text != '') {
      if (email.isNotEmpty && email.contains("@")) {
        if (senha.isNotEmpty && senha.length > 6) {
          setState(() {
            _onSuccess("Usuário Criado com Sucesso!");
          });

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;

          _cadastrarUsuario(usuario);

          _validarCamposUsuario();
        } else {
          setState(() {
            _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
          });
        }
      } else {
        setState(() {
          _onFail("Digite um email válido utilizando @ por favor");
        });
      }
    } else {
      setState(() {
        _onFail("Preencha o campo nome por favor");
      });
    }
  }

  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    )
        .then((firebaseUser) {
      setState(() {
        _onSuccess("Usuário Criado com Sucesso!");
      });

      //Salvar dados do usuário
      // ignore: deprecated_member_use

      Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );

      _onSuccess("Usuário Criado com Sucesso!");
    }).catchError((error) {
      print("erro app: " + error.toString());
      setState(() {
        _onFail("Já existe uma conta para o email informado!!");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Cadastro"),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background2.jpg'),
                fit: BoxFit.fitHeight)),
        padding: EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Image.asset(
                    "assets/loginlocation2.png",
                    height: MediaQuery.of(context).size.height / 7,
                    width: MediaQuery.of(context).size.width / 2,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    controller: _controllerNome,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Nome",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "E-mail",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                    controller: _controllerSenha,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                    controller: _controllerSenha2,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Repita a Senha",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      child: Text(
                        "Cadastrar",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      color: Colors.blue[500],
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onPressed: () {
                        if (_controllerSenha.text == _controllerSenha2.text &&
                            _controllerSenha2.text.length > 6 &&
                            _controllerSenha.text.length > 6 &&
                            _controllerEmail.text.contains("@") &&
                            _controllerNome.text != '') {
                          setState(() {
                            _validarCampos();
                          });
                        } else if (_controllerNome.text == '') {
                          setState(() {
                            _onFail("Preencha o campo nome por favor");
                          });
                        } else if (_controllerSenha.text !=
                            _controllerSenha2.text) {
                          setState(() {
                            _onFail("As senhas não coincidem!");
                          });
                        } else if (_controllerSenha.text.length <= 6) {
                          setState(() {
                            _onFail(
                                "Digite uma senha com mais de 6 caracteres");
                          });
                        } else if (_controllerSenha2.text.length <= 6) {
                          setState(() {
                            _onFail(
                                "Digite uma senha com mais de 6 caracteres");
                          });
                        } else if (_controllerEmail.text.isNotEmpty) {
                          setState(() {
                            _onFail(
                                "Digite um email válido utilizando @ por favor");
                          });
                        } else if (_controllerEmail.text.isEmpty) {
                          setState(() {
                            _onFail(
                                "Já existe uma conta para o email informado!!");
                          });
                        }
                      }),
                ),
                Center(
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSuccess(String _text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          _text,
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 5),
      ),
    );
  }

  void _onFail(String _text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          _text,
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 5),
      ),
    );
  }
}
