import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/mapas/mapa_farmacia.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:ilocationma/splash/model_Splash.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(SplashFarm());

class SplashFarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashFarmacia(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashFarmacia extends StatefulWidget {
  @override
  _SplashFarmaciaState createState() => _SplashFarmaciaState();
}

class _SplashFarmaciaState extends State<SplashFarmacia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: SplashModel(
            tituloSplash: 'Fármacias',
            localFlare: 'flare/Farmacia.flr',
            animationFlare: 'spin',
          ),
        ),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3)).then((_) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 2,
                backgroundColor: Colors.grey[200],
                title: Text(
                  "ATENÇÃO!!!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                content: Text(
                  "       Aos Sábados, Domingos e Feriados as farmácias trabalham em regime de plantão. Para saber quais as farmácias que estão atendendo no plantão, por favor, clique no ícone abaixo e consulte diretamente no site da prefeitura.",
                  style: TextStyle(fontSize: 16),
                ),
                actions: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(MaterialPageRoute(
                              builder: (context) => MapaFarmacia()));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 30, 0),
                              child: Text(
                                "Voltar ao Mapa",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        )),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.clinicMedical),
                    iconSize: 40,
                    color: Colors.red,
                    onPressed: () {
                      launch(
                          "http://montealto.sp.gov.br/site/plantaofarmaceutico/");
                    },
                  ),
                ],
              ));
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MapaFarmacia()));
    });
  }
}
