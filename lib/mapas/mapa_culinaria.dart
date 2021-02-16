import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/add/add_culinaria.dart';
import 'package:ilocationma/home/HomeEscolha.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:ilocationma/home/OpenUtil.dart';
import 'package:ilocationma/main.dart';
import 'package:ilocationma/modelsfunc/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widget.dart';

class MyMapaCulinaria extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        home: MapaCulinaria(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MapaCulinaria extends StatefulWidget {
  @override
  MapaCulinariaState createState() => MapaCulinariaState();
}

class MapaCulinariaState extends State<MapaCulinaria> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {

    var db = FirebaseFirestore.instance;
    QuerySnapshot resultado = await db.collection("markersrest").get();

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
                BitmapDescriptor.hueOrange)
        );
        _markers[result.name] = marker;
      });
    });
  }

  void _verificaLogin(String _text) {
    auth.authStateChanges()
        .listen((User user) {
      if (user == null) {
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
                    child: Text("Voltar ao Mapa", style: TextStyle(
                        fontSize: 17, color: Colors.blue, fontWeight: FontWeight.bold
                    ),)),
                FlatButton(onPressed: () {
                  setState(() {

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => HomeEscolha()
                    ));
                  });
                },
                    child: Text("Login", style: TextStyle(
                        fontSize: 17, color: Colors.redAccent, fontWeight: FontWeight.bold
                    ),))
              ],
            ));

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(
              _text,
              style: TextStyle(
                  color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );

      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyAddCulinaria())
        );
      }});
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {

      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          flexibleSpace: AppBarGradient3(),
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyHomePrincipal()
              ));

            },
          ),
          title: Text("Alimentação"),
          centerTitle: true,
          actions: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                icon: Icon(Icons.add_circle),
                iconSize: 23,
                onPressed: () {
                  setState(() {
                    model.verificaLoginMapa(context, MyAddCulinaria());
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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MapaCulinaria()
                  ));

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
            _containerCard("https://www.inglesthehouse.com.br/wp-content/uploads/2019/06/Sorvete-Cremoso.jpg",
                -21.262055,-48.4974041,
                "Sorveteria Cremoso"),
            _containerCard("https://www.codemoney.com.br/site2017/wp-content/uploads/2018/12/porque-o-subway-tem-esse-nome-1600x800-c-center.jpg",
                -21.2625026,-48.4971678,
                "Subway"),
            _containerCard("https://10619-2.s.cdn12.com/rests/original/314_507820567.jpg",
                -21.262197, -48.49747,
                "Botequeim do Herculano"),
            _containerCard("https://media-cdn.tripadvisor.com/media/photo-s/0d/ec/91/5d/fachada-monte-alto.jpg",
                -21.2646767, -48.5062972,
                "Vesúvio"),
            _containerCard("https://10619-2.s.cdn12.com/rests/small/w312/h280/332_508893226.jpg",
                -21.261274, -48.4900335,
                "Rest. do Abril"),
            _containerCard("https://static-images.ifood.com.br/image/upload//logosgde/201812221118_37f6b14c-4ca9-464b-aa0e-c40795ecf203.jpg",
                -21.2662749, -48.5026316,
                "Pizzaria La' Sorella"),
            _containerCard("https://www.dinapolipremium.com.br/img/logo_dinapoli.png",
                -21.2618135, -48.4993848,
                "Di' Napoli"),
            _containerCard("https://1.bp.blogspot.com/-83-kmZO1hyo/VRQPpjN5k2I/AAAAAAAAFI4/-FbsV1GKlAw/s1600/LOGO%2BRESTAURANTE%2BDO%2BDED%C3%83O%2Bcdr.jpg",
                -21.2602485, -48.494151,
                "Rest. Dedão"),
            _containerCard("https://i.ytimg.com/vi/UnlmNxvejNE/maxresdefault.jpg",
                -21.2613385,-48.4987374,
                "Armazém Santo Onofre"),
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
              shadowColor: Colors.orange,
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
        FontAwesomeIcons.utensils,
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
                    color: Colors.deepOrange,
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
        CameraPosition(target: LatLng(-21.2621781, -48.4975432), zoom: 12),
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
