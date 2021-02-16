import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Animation/FadeAnimation.dart';
import 'LoginScreen.dart';
import 'model/CadUsuario.dart';
import 'model/Usuario.dart';
import 'modelsfunc/user_model.dart';

class MyCadUser extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        home: CadUser(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class CadUser extends StatefulWidget {
  @override
  _CadUserState createState() => _CadUserState();
}

class _CadUserState extends State<CadUser> {

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

    _cadastrarUser( usuario );


  }

  _cadastrarUser(CadUsuario usuario) {
    var db = FirebaseFirestore.instance;
    db.collection("usuarios").add({
      "nomeCadastro": usuario.nome,
      "emailCadastro": usuario.email,
      "senhaCadastro": usuario.senha,

    });
  }


  _validarCampos(){

    //Recupera dados dos campos
    String nome = _controllerNome.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;


    if( nome.isNotEmpty || _controllerNome.text != '' ){

      if( email.isNotEmpty && email.contains("@") ){

        if( senha.isNotEmpty && senha.length > 6 ){

          setState(() {
            _onSuccess("Usuário Criado com Sucesso!");
          });

          Usuario usuario = Usuario();
          usuario.nome = nome;
          usuario.email = email;
          usuario.senha = senha;


          _cadastrarUsuario( usuario );

          _validarCamposUsuario();


        }else{
          setState(() {
            _mensagemErro = "Preencha a senha! digite mais de 6 caracteres";
          });
        }

      }else{
        setState(() {
          _onFail("Digite um email válido utilizando @ por favor");
        });
      }

    }else{
      setState(() {
        _onFail("Preencha o campo nome por favor");
      });
    }

  }

  _cadastrarUsuario( Usuario usuario ){

    FirebaseAuth auth = FirebaseAuth.instance;


    auth.createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,

    ).then((firebaseUser){

      setState(() {
        _onSuccess("Usuário Criado com Sucesso!");
      });

      //Salvar dados do usuário
      // ignore: deprecated_member_use


      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),

        ),
      );

      _onSuccess("Usuário Criado com Sucesso!");

    }).catchError((error){
      print("erro app: " + error.toString() );
      setState(() {
        _onFail("Já existe uma conta para o email informado!!");
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(1, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/light-1.png')
                              )
                          ),
                        )),
                      ),

                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(1.5, Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/clock.png')
                              )
                          ),
                        )),
                      ),
                      Positioned(
                        child: FadeAnimation(1.6, Container(
                          margin: EdgeInsets.only(top: 300),
                          child: Center(
                            child: Text("", style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      )
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Cadastro", style: TextStyle(fontSize: 20, color: Colors.blue[600], fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                      FadeAnimation(1.8, Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10)
                              ),

                            ]
                        ),

                        child: Column(
                          children: <Widget>[

                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextField(
                                controller: _controllerNome,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Nome",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),

                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[100]))
                              ),
                              child: TextField(
                                controller: _controllerEmail,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controllerSenha,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Senha",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _controllerSenha2,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Repita a Senha",
                                    hintStyle: TextStyle(color: Colors.grey[400])
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                      SizedBox(height: 20,),
                      FlatButton(
                        onPressed: () {
                          if (_controllerSenha.text == _controllerSenha2.text && _controllerSenha2.text.length > 6 && _controllerSenha.text.length >6
                              && _controllerEmail.text.contains("@") && _controllerNome.text != ''){
                            setState(() {

                              _validarCampos();
                            });
                          }else if (_controllerNome.text == ''){
                            setState(() {
                              _onFail("Preencha o campo nome por favor");
                            });
                          }else if (_controllerSenha.text != _controllerSenha2.text){
                            setState(() {
                              _onFail("As senhas não coincidem!");
                            });
                          }else if (_controllerSenha.text.length <= 6){
                            setState(() {
                              _onFail("Digite uma senha com mais de 6 caracteres");
                            });
                          }else if (_controllerSenha2.text.length <=6){
                            setState(() {
                              _onFail("Digite uma senha com mais de 6 caracteres");
                            });
                          }else if (_controllerEmail.text.isNotEmpty){
                            setState(() {
                              _onFail("Digite um email válido utilizando @ por favor");
                            });
                          }else if (_controllerEmail.text.isEmpty){
                            setState(() {
                              _onFail("Já existe uma conta para o email informado!!");
                            });
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
                            child: Text("Cadastrar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          ),
                        )),
                      ),
                      SizedBox(height: 50,),


                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
  void _onSuccess(String _text){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(_text, style: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold
      ),),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 4),
      ),
    );
  }
  void _onFail(String _text){
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(_text, style: TextStyle(
          color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold
      ),),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 4),
      ),
    );
  }
}
