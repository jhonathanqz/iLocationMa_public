import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:scoped_model/scoped_model.dart';
import 'Animation/FadeAnimation.dart';
import 'model/Usuario.dart';
import 'modelsfunc/user_model.dart';

class MyLoginScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        home: LoginScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerSenha = TextEditingController();
  String _mensagemErro = "";
  bool isLoading = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();


  _validarCampos(){

    //Recupera dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if( email.isNotEmpty && email.contains("@") ){

      if( senha.isNotEmpty ){

        setState(() {
          _mensagemErro = "";
        });

        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        _logarUsuario( usuario );


      }else{
        setState(() {
          _onFail("Preencha a senha!");
        });
      }

    }else{
      setState(() {
        _onFail("Preencha o campo E-mail por favor!");
      });
    }

  }

  _logarUsuario( Usuario usuario ){

    FirebaseAuth auth = FirebaseAuth.instance;

    isLoading = true;

    auth.signInWithEmailAndPassword(
        email: usuario.email,
        password: usuario.senha
    ).then((firebaseUser){


      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePrincipal()
      ));

      setState(() {
        _onShowAlert();
      });

    }).catchError((error){

      setState(() {
        _onFail("Erro ao autenticar usuário, verifique e-mail e senha e tente novamente!");
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
            child: ScopedModelDescendant<UserModel>(
              builder: (context, child, model){
                return Column(
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
                                Text("Login", style: TextStyle(fontSize: 20, color: Colors.blue[600], fontWeight: FontWeight.bold),)
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
                                    obscureText: true,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Senha",
                                        hintStyle: TextStyle(color: Colors.grey[400])
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FlatButton(onPressed: () {
                              if(_controllerEmail.text == '') {
                                setState(() {
                                  _onFail("Insira seu email para recuperação por favor");
                                });
                              }
                              else {
                                setState(() {
                                  model.recoverPass(_controllerEmail.text);
                                  _onSuccess("Um link para redefinição da senha foi enviado em seu email");
                                });
                              }
                            },
                              child: FadeAnimation(1.5, Text("Esqueceu a senha?", style: TextStyle(color: Colors.blue),)),),
                          ),
                          SizedBox(height: 20,),
                          FlatButton(
                            onPressed: () {
                              _validarCampos();
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
                                child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            )),
                          ),


                        ],
                      ),
                    )
                  ],
                );

              },
            ),
          ),
        )
    );
  }
  void _onShowAlert(){
    _scaffoldKey.currentState.setState(() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            backgroundColor: Colors.grey[200],
            title: Text("Seja Bem Vindo(a)!!!", style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25
            ),),
            content: Text("Seja Bem Vindo(a) ao iLocationMa. \n\n Aplicativo desenvolvido para lhe ajudar encontrar pontos e referências da cidade de Monte Alto - SP",
              style: TextStyle(
                  fontSize: 18
              ),),

            actions: <Widget> [

              IconButton(
                icon: Icon(FontAwesomeIcons.thumbsUp),
                iconSize: 30,
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

            ],
          )
      );
    });
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
  void _onSuccess(String _text){
    _scaffoldKey.currentState.showSnackBar(

      SnackBar(content: Text(_text, style: TextStyle(
          color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold
      ),),

        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }
  void recoverPass(String email){
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path= new Path();
    path.lineTo(0, size.height-80);
    var controllPoint=Offset(30, size.height);
    var endPoint=Offset(size.width/2, size.height);
    path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
