import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/add/add_farmacia.dart';
import 'package:ilocationma/home/HomeEscolha.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:ilocationma/home/OpenUtil.dart';
import 'package:ilocationma/main.dart';
import 'package:ilocationma/modelsfunc/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget.dart';

class MyMapaFarmacia extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        home: MapaFarmacia(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MapaFarmacia extends StatefulWidget {
  @override
  MapaFarmaciaState createState() => MapaFarmaciaState();
}

class MapaFarmaciaState extends State<MapaFarmacia> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();


  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {

    var db = FirebaseFirestore.instance;
    QuerySnapshot resultado = await db.collection("markersfarm").get();

    setState(() {
      _markers.clear();

      resultado.docs.forEach((d) {
        print(d.data());
        final result = Markers.fromJson(d.data());

        final marker = Marker(
          markerId: MarkerId(result.name),
          position: LatLng(result.lat.toDouble(), result.lng.toDouble()),
          infoWindow: InfoWindow(
            title: result.name,
            snippet: result.address,
              onTap: (){
                OpenUtil.openMap(result.lat, result.lng);

              }
          ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed)
        );
        _markers[result.name] = marker;
      });
    });
  }

  double zoomVal = 50.0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              flexibleSpace: AppBarGradient2(),
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyHomePrincipal()
                  ));


                },
              ),
              title: Text("Farmácias"),
              centerTitle: true,
              actions: <Widget>[
                Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                    padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                    icon: Icon(Icons.add_circle),
                    iconSize: 23,
                    onPressed: () {
                      setState(() {
                        model.verificaLoginMapa(context, MyAddFarmacia());
                      });

                    },
                  ),
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    icon: Icon(FontAwesomeIcons.clinicMedical),
                    color: Colors.red,
                    iconSize: 23,
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 2,
                            backgroundColor: Colors.grey[200],
                            title: Text("Farmácias de Plantão", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20
                            ),),
                            content: Text("       Aos Sábados, Domingos e Feriados as farmácias trabalham em regime de plantão. Para saber quais as farmácias que estão atendendo no plantão, por favor, clique no ícone abaixo e consulte diretamente no site da prefeitura.", style: TextStyle(
                                fontSize: 16
                            ),),
                            actions: <Widget> [
                              FlatButton(onPressed: (){
                                Navigator.pop(context);

                              },
                                  child: Row(
                                    children: [
                                      Padding(padding: EdgeInsets.fromLTRB(10, 10, 30, 0),
                                        child: Text("Voltar ao Mapa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),)

                                    ],
                                  )),

                              IconButton(
                                icon: Icon(FontAwesomeIcons.clinicMedical),
                                iconSize: 20,
                                color: Colors.red,
                                onPressed: () {
                                  launch("http://montealto.sp.gov.br/site/plantaofarmaceutico/");
                                },
                              ),

                            ],
                          )
                      );
                    },
                  ),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.syncAlt),
                    iconSize: 25,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MapaFarmacia()));
                    },
                  ),
                ),
              ],

            ),
            body: Stack(
              children: <Widget>[
                _buildGoogleMap(context),
                _buildContainer(),
              ],
            ),
          );
    });
  }

  Widget _containerCard(String _image, double lat, double lng, String restaurantName){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: _boxes(_image, lat, lng, restaurantName),
    );
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _containerCard("https://droganossa.net/wp-content/uploads/2018/06/logotipo-dnossa-vertical-01.jpg",
                -21.2616624, -48.4925371,
                "Farm. Droga Nossa"),
            _containerCard("https://segredosdomundo.r7.com/wp-content/uploads/2020/04/simbolo-da-farmacia-historia-de-onde-surgiu-e-o-significado-2.jpg",
                -21.01767, -48.2294025,
                "Farm. Drogaria Monte Alto"),
            _containerCard("https://www.listatotal.com.br/logos/redefarmareallogo.png",
                -21.2508165, -48.5150131,
                "Farm. Real Farma"),
            _containerCard("https://ncdn0.infojobs.com.br/logos/Company_Evaluation/197760.jpg",
                -21.2614453, -48.4867373,
                "Farm. Drogaria Vitoria"),
            _containerCard("https://tvminas.com/admin/imagens/foto_empresa/070820152207716/foto_principal.jpg",
                -21.2629508, -48.4938294,
                "Farm. Drogaria Poupe Já "),
            _containerCard("https://www.aciamcdlmariana.com.br/uploads/aciam_2017/entidades/logomarcas/tn/c_200x200_5f2e42e838a9fe1f18ae32ecf65d3c55c7fdc586.jpg",
                -21.2633702, -485017932,
                "Farm. Sta Barbara I"),
            _containerCard("https://img-anuncio.listamais.com.br/logo-anuncios/504354.png",
                -21.267467, -48.5003194,
                "Farm. Farma Nova"),
            _containerCard("https://segredosdomundo.r7.com/wp-content/uploads/2020/04/simbolo-da-farmacia-historia-de-onde-surgiu-e-o-significado-2.jpg",
                -21.2663264, -48.4770238,
                "Farm. Droga Azul"),
            _containerCard("https://leianoticias.com.br/wp-content/uploads/2019/09/whatsapp-image-2019-09-18-at-14-55-06-297x290.jpeg",
                -21.2623594, -48.4977247,
                "Farm. Drogaria Total Popular"),
            _containerCard("https://image.isu.pub/130419113428-ef3c8c1a48d342339b57e9fbbec9a66e/jpg/page_1.jpg",
                -21.2619178, -48.4944205,
                "Farm. Drogaria Total Drogalita"),
            _containerCard("https://www.acinpcdl.com.br/wp-content/uploads/2014/12/DROGARIA-AVENIDA.-Copy.png",
                -21.2680889, -48.4769702,
                "Farm. Drogaria Avenida"),
            _containerCard("https://www.aciamcdlmariana.com.br/uploads/aciam_2017/entidades/logomarcas/tn/c_200x200_5f2e42e838a9fe1f18ae32ecf65d3c55c7fdc586.jpg",
                -21.2643264, -48.5020214,
                "Farm. Santa Barbara II"),
            _containerCard("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRVqtb9U8otrxR60b2DN8nGYjyPWFVWGxTaPw&usqp=CAU",
                -21.2623654, -48.4958713,
                "Farm. Droga Serve"),
            _containerCard("https://segredosdomundo.r7.com/wp-content/uploads/2020/04/simbolo-da-farmacia-historia-de-onde-surgiu-e-o-significado-2.jpg",
                -21.261892, -48.4886577,
                "Farm. Farmativa"),
            _containerCard("https://segredosdomundo.r7.com/wp-content/uploads/2020/04/simbolo-da-farmacia-historia-de-onde-surgiu-e-o-significado-2.jpg",
                -21.2677295, -48.4765871,
                "Farm. Droga Med"),
            _containerCard("https://segredosdomundo.r7.com/wp-content/uploads/2020/04/simbolo-da-farmacia-historia-de-onde-surgiu-e-o-significado-2.jpg",
                -21.2661626, -48.5006341,
                "Farm. Drogaria Paraiso"),
            _containerCard("https://segredosdomundo.r7.com/wp-content/uploads/2020/04/simbolo-da-farmacia-historia-de-onde-surgiu-e-o-significado-2.jpg",
                -21.2625947, -48.4971086,
                "Farm. Farma Center"),
            _containerCard("https://acianf.com.br/images/empresas/perfil/drogaria-sao-jose_5ecd4e562e99d.crop.jpg",
                -21.2538074, -48.5085604,
                "Farm. Drogaria São José"),
            _containerCard("https://i.ytimg.com/vi/F58kWUA6px4/maxresdefault.jpg",
                -21.2623466, -48.4951469,
                "Farm. Rede Bem"),
            _containerCard("https://pbs.twimg.com/profile_images/1258364100972883973/gGcA20Y2_400x400.jpg",
                -21.263051, -48.5002877,
                "Farm. Drogal"),
            _containerCard("https://guiadafarmacia.com.br/wp-content/uploads/2017/12/droga-raia.jpg",
                -21.2631062, -48.4987012,
                "Farm. Droga Raia"),
            _containerCard("https://adccta.com/wp-content/uploads/2018/11/farma-conde-site.jpg",
                -21.2629671, -48.5001101,
                "Farm. Farma Conde"),

          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double lng, String restaurantName) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, lng);
        launch("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
      },
      child: Container(
        child: new FittedBox(
          child: Material(
              color: Colors.white,
              elevation: 14.0,
              borderRadius: BorderRadius.circular(24.0),
              shadowColor: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 180,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(24.0),
                      child: Image(
                        fit: BoxFit.fill,
                        image: NetworkImage(_image),
                        loadingBuilder: (context, child, progress) {
                          return progress == null ? child: CircularProgressIndicator(backgroundColor: Colors.blue,);
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myDetailsContainer1(restaurantName),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
  Widget _containerStars(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Icon(
      FontAwesomeIcons.syringe,
      color: Colors.amber,
      size: 15.0,
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                restaurantName,
                style: TextStyle(
                    color: Colors.cyan,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(height: 5.0),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    child: Text(
                      "5.0",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.0,
                      ),
                    )),
                SizedBox(
                  width: 5,
                ),
                _containerStars(),
                _containerStars(),
                _containerStars(),
                _containerStars(),
                _containerStars(),

              ],
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              "Brasil",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            )),
        SizedBox(height: 5.0),
        Container(
            child: Text(
              "Monte Alto, SP",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  Widget _buildGoogleMap(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition:
        CameraPosition(target: LatLng(-21.2621781, -48.4975432), zoom: 13),
        onMapCreated: _onMapCreated,
        markers: _markers.values.toSet(),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, lng),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}

