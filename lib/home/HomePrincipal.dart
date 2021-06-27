import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/QRCode/HomeQRCode.dart';
import 'package:ilocationma/home/FAQ2.dart';
import 'package:ilocationma/home/SobreAplicativo.dart';
import 'package:ilocationma/modelsfunc/user_model.dart';
import 'package:ilocationma/splash/splash_bancos.dart';
import 'package:ilocationma/splash/splash_banheiro.dart';
import 'package:ilocationma/splash/splash_culinaria.dart';
import 'package:ilocationma/splash/splash_farmacia.dart';
import 'package:ilocationma/splash/splash_hospital.dart';
import 'package:ilocationma/splash/splash_posto.dart';
import 'package:ilocationma/splash/splash_turismo.dart';
import 'package:ilocationma/widgets/platform_alert_dialog.dart';
import 'package:ilocationma/widgets/platform_dialog_button_action.dart';
import 'package:scoped_model/scoped_model.dart';
import 'SobreMonteAlto.dart';
import 'package:connectivity/connectivity.dart';

class MyHomePrincipal extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        home: HomePrincipal(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class HomePrincipal extends StatefulWidget {
  @override
  _HomePrincipalState createState() => _HomePrincipalState();
}

class _HomePrincipalState extends State<HomePrincipal> {
  var connected;

  FirebaseAuth auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _checkInternetConnection() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      connected = '2';
    } else if (result == ConnectivityResult.mobile) {
      connected = '1';
    } else if (result == ConnectivityResult.wifi) {
      connected = '1';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
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
                      setState(() {
                        model.sairApp(context);
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(FontAwesomeIcons.user),
                          color: Colors.white,
                          iconSize: 20,
                          onPressed: () {
                            model.verOnlineHome(context, onSuccess: _onSuccess);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(FontAwesomeIcons.info),
                          color: Colors.white,
                          iconSize: 20,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MySobreApp()));
                          },
                        )
                      ],
                    )),
                  )
                ],
              ),
            ),
            SizedBox(height: 25.0),
            FadeAnimation(
              1,
              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Row(
                  children: <Widget>[
                    Text('iLocationMA',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FadeAnimation(
              1,
              Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('      Seu guia virtual!',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            color: Colors.white,
                            fontSize: 20.0)),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MySobreCidade())),
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/mont3.png'))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 45.0),
                      child: Container(
                          height: MediaQuery.of(context).size.height - 300.0,
                          child: ListView(children: [
                            _buildHomeItem('assets/hospital1.png', 'Hospital',
                                SplashHosp()),
                            SizedBox(
                              height: 15,
                            ),
                            _buildHomeItem('assets/farmacia1.png', 'Farmácia',
                                SplashFarm()),
                            SizedBox(
                              height: 15,
                            ),
                            _buildHomeItem(
                                'assets/banco3.png', 'Bancos', SplashBancos()),
                            SizedBox(
                              height: 15,
                            ),
                            _buildHomeItem('assets/culinaria1.png',
                                'Alimentação', SplashCulinaria()),
                            SizedBox(
                              height: 15,
                            ),
                            _buildHomeItem('assets/turismo3.png', 'Turismo',
                                SplashTurismo()),
                            SizedBox(
                              height: 15,
                            ),
                            _buildHomeItem('assets/posto1.png',
                                'Posto de Combustível', SplashPosto()),
                            SizedBox(
                              height: 15,
                            ),
                            _buildHomeItem('assets/banheiro1.png', 'Banheiros',
                                SplashBan()),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 10.0,
                                  bottom: 10),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    model.verificaLoginMapa(
                                        context, MyHomeQR());
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Row(children: [
                                        Hero(
                                            tag: 'assets/scan.png',
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/scan.png'),
                                                fit: BoxFit.cover,
                                                height: 75.0,
                                                width: 75.0)),
                                        SizedBox(width: 10.0),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "QRCode Scan",
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 17.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                    IconButton(
                                        icon: Icon(Icons.location_on),
                                        color: Colors.black,
                                        onPressed: () {
                                          setState(() {
                                            model.verificaLoginMapa(
                                                context, MyHomeQR());
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            _buildHomeItem('assets/mont3.png', 'Sobre a Cidade',
                                MySobreCidade()),
                            SizedBox(
                              height: 15,
                            ),
                          ]))),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FadeAnimation(
                        2,
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyFAQ2()));
                          },
                          child: Container(
                            height: 40.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color(0xFF1C1428)),
                            child: Center(
                                child: Text('FAQ',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.white,
                                        fontSize: 15.0))),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "Você já está logado!",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Widget _buildHomeItem(String imgPath, String nameController, _controller,
      {connectivityResult}) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 10),
      child: InkWell(
        onTap: () {
          _checkInternetConnection();
          if (connected == '1') {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => _controller));
          }
          if (connected == '2') {
            alertConnection();
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Row(children: [
                Hero(
                    tag: imgPath,
                    child: Image(
                        image: AssetImage(imgPath),
                        fit: BoxFit.cover,
                        height: 75.0,
                        width: 75.0)),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameController,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ]),
            ),
            IconButton(
                icon: Icon(Icons.location_on),
                color: Colors.black,
                onPressed: () {
                  _checkInternetConnection();
                  if (connected == '1') {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => _controller));
                  }
                  if (connected == '2') {
                    alertConnection();
                  }
                }),
          ],
        ),
      ),
    );
  }

  void alertConnection() {
    showPlatformDialog(
        context: context,
        builder: (context) => PlatformAlertDialog(
              title: 'Conexão de rede',
              content: Text(
                  'Por favor verifique sua conexão com a internet antes de prosseguir.'),
              actions: [
                destructiveAction('Voltar'),
              ],
            ));
  }
}
