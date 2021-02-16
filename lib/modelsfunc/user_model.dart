import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/helpers/open-util/open-util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ilocationma/home/HomeEscolha.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:ilocationma/mapas/mapa_bancos.dart';
import 'package:ilocationma/model/AddPaginas.dart';
import 'package:ilocationma/model/Usuario.dart';
import 'package:scoped_model/scoped_model.dart';




class UserModel extends Model {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";
  bool isLoading = false;
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerLocal = TextEditingController();
  TextEditingController _controllerEnd = TextEditingController();
  TextEditingController _controllerObs = TextEditingController();
  bool checkBoxValue1 = false;
  bool checkBoxValue2 = false;
  bool checkBoxValue3 = false;
  bool checkBoxAvalia1 = false;
  bool checkBoxAvalia2 = false;
  bool checkBoxAvalia3 = false;
  bool checkBoxAvalia4 = false;
  bool checkBoxAvalia5 = false;
  var _currencies = [
    '7h às 21h',
    '7h às 22h',
    '8h às 21h',
    '9h às 18h',
    '10h às 22h',
    '24h',
    'Sem informação sobre o horário'
  ];
  var _currentItemSelected = 'Sem informação sobre o horário';


  //**************************************************************************************************************************
  //signOut do usuário (encerrar sessão de Login
  void signOut(context) async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeEscolha()
    ));
    await FirebaseAuth.instance.signOut();

  }

  //**************************************************************************************************************************
  //Redefinir senha do usuário
  void recoverPass(String email) async{
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);

  }

  //**************************************************************************************************************************
  //SignOut do usuário (encerrar sessão de login
  void SairApp(context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(16)),
          elevation: 2,
          backgroundColor: Colors.grey[200],
          title: Text(
            "Sair do Aplicativo",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          content: Text(
            "Deseja realmente sair do aplicativo ?",
            style: TextStyle(fontSize: 17),
          ),
          actions: <Widget>[
            FlatButton(onPressed: () {
              Navigator.pop(context);
            },
                child: Text("NÃO", style: TextStyle(
                    fontSize: 17, color: Colors.blue, fontWeight: FontWeight.bold
                ),)),
            FlatButton(onPressed: () {

                auth.authStateChanges()
                    .listen((User user) async {
                  if (user == null) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeEscolha())
                    );
                  } else {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeEscolha())
                    );
                    await FirebaseAuth.instance.signOut();

                  }});


            },
                child: Text("SIM", style: TextStyle(
                    fontSize: 17, color: Colors.redAccent, fontWeight: FontWeight.bold
                ),))
          ],
        ));
  }

  //**************************************************************************************************************************
  //validar login do usuario
  void validarLogin({context, @required VoidCallback onShowAlert, @required VoidCallback onFail, }) async {


    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;
    FirebaseAuth auth = FirebaseAuth.instance;

    if( email.isNotEmpty && email.contains("@") ){

      if( senha.isNotEmpty ){


        _mensagemErro = "";


        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        auth.signInWithEmailAndPassword(
            email: usuario.email,
            password: usuario.senha
        ).then((firebaseUser){


          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => MyHomePrincipal()
          ));


          onShowAlert();


        }).catchError((error){


          onFail();


        });


      }else{

        onFail();

      }

    }else{
      onFail();
    }
  }

  //**************************************************************************************************
  //HomePrincipal -> icone para redirecionar usuario a tela de login

  void verOnlineHome(context,{ @required VoidCallback onSuccess}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges()
        .listen((User user) {
      if (user != null) {

        onSuccess();
        notifyListeners();
      }
      if (user == null) {
        notifyListeners();
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(16)),
              elevation: 2,
              backgroundColor: Colors.grey[200],
              title: Text(
                "Faça Login ou Cadastre-se",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              content: Text(
                "Deseja prosseguir para a página de \nLogin/Cadastro.",
                style: TextStyle(fontSize: 17),
              ),
              actions: <Widget>[
                FlatButton(onPressed: () {
                  Navigator.pop(context);
                },
                    child: Text("Não", style: TextStyle(
                        fontSize: 17, color: Colors.blue, fontWeight: FontWeight.bold
                    ),)),
                FlatButton(onPressed: () {

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeEscolha()
                  ));

                },
                    child: Text("Sim!", style: TextStyle(
                        fontSize: 17, color: Colors.redAccent, fontWeight: FontWeight.bold
                    ),))
              ],
            ));
      }else {

      }
    });
  }

  //**************************************************************************************************
  //verifica se usuario está logado, para abrir novas funções do aplicativo

  void verificaLoginMapa(context, _controller) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges()
        .listen((User user) {
      if (user != null) {

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => _controller)
        );
        notifyListeners();
      }
      if (user == null) {
        notifyListeners();
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(16)),
              elevation: 2,
              backgroundColor: Colors.grey[200],
              title: Text(
                "Faça Login ou Cadastre-se",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              content: Text(
                "Para utilizar a função desejada, por favor, faça Login ou Cadastre-se.",
                style: TextStyle(fontSize: 17),
              ),
              actions: <Widget>[
                FlatButton(onPressed: () {
                  Navigator.pop(context);
                },
                    child: Text("Voltar", style: TextStyle(
                        fontSize: 17, color: Colors.blue, fontWeight: FontWeight.bold
                    ),)),
                FlatButton(onPressed: () {

                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeEscolha()
                  ));

                },
                    child: Text("Login", style: TextStyle(
                        fontSize: 17, color: Colors.redAccent, fontWeight: FontWeight.bold
                    ),))
              ],
            ));
      }
    });
  }

  void   NovaLocalizacao (context, _controller) {
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
            "Localização enviada com sucesso!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          content: Text(
            "Após análise de nossa equipe, sua localização será incluída em nosso mapa.",
            style: TextStyle(fontSize: 18),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.thumbsUp),
              iconSize: 30,
              color: Colors.blue,
              onPressed: () {

                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => _controller
                ));


              },
            ),
          ],
        ));
    notifyListeners();
  }




}


