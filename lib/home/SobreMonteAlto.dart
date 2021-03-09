import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'HomePrincipal.dart';

void main() => runApp(MySobreCidade());

class MySobreCidade extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SobreCidade(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SobreCidade extends StatefulWidget {
  @override
  _SobreCidadeState createState() => _SobreCidadeState();
}

class _SobreCidadeState extends State<SobreCidade> {
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
                        builder: (context) => MyHomePrincipal()));
                  },
                ),
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
                          fontSize: 25.0)),
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
                children: <Widget>[
                  Text('Sobre a Cidade',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 20.0))
                ],
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: MediaQuery.of(context).size.height - 185.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35)),
            ),
            child: ListView(
              primary: false,
              padding: EdgeInsets.all(16),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 30, left: 0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                        1,
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "       Monte Alto é uma simpática cidade do interior de São Paulo, com aproximadamente 50 mil habitantes, situada a 350Km da capital, fundada a 139 anos por Porfírio Luís de Alcântara Pimentel, farmacêutico e cirurgião do imperador Dom Pedro II."
                                "\n\n       De Onírica imagem a cidade real, surgiu então a próspera "
                                "Cidade Sonho"
                                ", inicialmente denominada Bom Jesus de Pirapora das Três Divisas de Monte Alto, inspirado em seu padroeiro o Sr. Bom Jesus."
                                "\n\n       Sua economia inicialmente baseada na cafeícultura, hoje é referência na produção de cebola e frutas para exportação, com predomínio no setor siderúrgico, automotivo e alimentício com excelência de mão-de-obra devidamente capacitada."
                                "\n\n      De clima tropical e população calorosa, acolhedora e resiliente, a explendorosa cidadezinha, rodeada de serras verdejantes e caudalosas cachoeiras, recebeu em 29 de Outubro de 2017 o título de cidade turística pela descoberta de diversos fósseis de dinossauros hoje expostos no museu de paleontologia e arqueologia."
                                "\n\n       O turismo religioso no distrito de Aparecida atrai romeiros de toda região e as inúmeras trilhas rurais são foco dos amantes dos esportes radicais, como ciclistas e motociclistas."
                                "\n\n       Visando uma experiência única para nossos visitantes, criamos o iLocation, um aplicativo de localização (Hospitais, Farmácias, Restaurantes, Pontos Turísticos, etc) e de informações, onde através do código QrCode obterão a descrição detalhada de todos os fósseis expostos em nosso museu.",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black),
                                textAlign: TextAlign.justify,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                        2,
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 50),
                          height: 500,
                          width: 300,
                          child: PageView(
                            children: <Widget>[
                              _img("assets/mont2.jpg"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _img(String img) {
    return Image.asset(
      img,
      fit: BoxFit.cover,
    );
  }
}
