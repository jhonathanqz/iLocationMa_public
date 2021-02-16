import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/add/add_posto.dart';
import 'package:ilocationma/home/HomeEscolha.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:ilocationma/home/OpenUtil.dart';
import 'package:ilocationma/main.dart';
import 'package:ilocationma/modelsfunc/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget.dart';

class MyMapaPosto extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        home: MapaPosto(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MapaPosto extends StatefulWidget {
  @override
  MapaPostoState createState() => MapaPostoState();
}

class MapaPostoState extends State<MapaPosto> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();


  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {

    var db = FirebaseFirestore.instance;
    QuerySnapshot resultado = await db.collection("markersposto").get();

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
                BitmapDescriptor.hueCyan)
        );
        _markers[result.name] = marker;
      });
    });
  }

  double zoomVal = 50.0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (conext, child, model) {
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
              title: Text("Posto de Combustível"),
              centerTitle: true,
              actions: <Widget>[

                Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    icon: Icon(Icons.add_circle),
                    iconSize: 23,
                    onPressed: () {
                      setState(() {
                        model.verificaLoginMapa(context, MyAddPosto());
                      });

                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.syncAlt),
                    iconSize: 20,
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => MapaPosto()));
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
            _containerCard("https://1.bp.blogspot.com/-zFbwODxhzN4/XU2OD3gY-VI/AAAAAAAANTw/GgdkvCCfoPw-mskdln21yQiiJDVH1jSbwCLcBGAs/s1600/posto%2Bcidade%2Bso4.jpg",
                -21.2641637,
                -48.5007975,
                "Auto Posto Cidade Sonho"),
            _containerCard("https://posto.clubpetro.com.br/projeto/clube-petro/arquivos/posto/postojotaw/arquivos/ebb2f477a45ac5f1e3c22f7868860a25.jpg",
                -21.2618128,
                -48.4932725,
                "Auto Posto JW"),
            _containerCard("https://www.brasquimica.ind.br/sistema/public/img/images/copercana.png",
                -21.2619789,
                -48.4943071,
                "Auto Posto Copercana"),
            _containerCard("https://www.br.com.br/pc/rede-de-postos/busca/!ut/p/z1/04_Sj9CPykssy0xPLMnMz0vMAfIjo8zi3Q183A39TQy93N39TQ0cA01DLb28nA3d_cz0w1EV-LuaWhg4OhqYhVmEGBoZBBnqRxGj3wAHcDQgTj8eBVH4jQ_Xj0K1wt_UxdnA0czVx8sjyMXIwMgYQwGmFwlZUpAbGhphkOkJAPwM0hk!/img/tottem-posto-interna.jpg",
                -21.2638044,
                -48.503762,
                "Auto Posto Pignatta"),
            _containerCard("https://spaceks.net/sites/radiowebasertaneja.com/images/summer/user_589209863.jpg",
                -21.2654914,
                -48.4770954,
                "Auto Posto Faveri"),
            _containerCard("https://s2.glbimg.com/dlWcfTwB_KUkmNsCgchJ-XoUYNE=/512x320/smart/e.glbimg.com/og/ed/f/original/2017/05/10/fachada-para-posto-ipiranga.jpg",
                -21.2608512,
                -48.5004927,
                "Auto Posto Bela Vista"),
            _containerCard("https://static.wixstatic.com/media/e53766_8a0bac25c0d248bcac5791a6eaff146c~mv2_d_2880_1440_s_2.jpg/v1/fill/w_2560,h_1280,fp_0.50_0.50,q_90/e53766_8a0bac25c0d248bcac5791a6eaff146c~mv2_d_2880_1440_s_2.jpg",
                -21.2619114,
                -48.4656251,
                "Posto Estoril"),
            _containerCard("https://images.vexels.com/media/users/3/147719/isolated/preview/8cf7b8ea32906351a66d29dad68fd302-logotipo-de-servi--o-de-posto-de-gasolina-de-carro-by-vexels.png",
                -21.2589342,
                -48.4930101,
                "Auto Posto Monte Alto 1"),


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
              shadowColor: Colors.cyan,
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
        FontAwesomeIcons.gasPump,
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

