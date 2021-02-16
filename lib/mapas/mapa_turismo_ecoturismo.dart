import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/add/add_turismo.dart';
import 'package:ilocationma/home/HomeEscolha.dart';
import 'package:ilocationma/home/OpenUtil.dart';
import 'package:ilocationma/modelsfunc/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../widget.dart';
import 'homemap/HomeMapTur.dart';

class MyMapaTurismoEcoturismo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        home: MapaTurismoEcoturismo(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MapaTurismoEcoturismo extends StatefulWidget {
  @override
  MapaTurismoEcoturismoState createState() => MapaTurismoEcoturismoState();
}

class MapaTurismoEcoturismoState extends State<MapaTurismoEcoturismo> {

  FirebaseAuth auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();


  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {

    var db = FirebaseFirestore.instance;
    QuerySnapshot resultado = await db.collection("markerstur_ecoturismo").get();

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
                BitmapDescriptor.hueGreen)
        );
        _markers[result.name] = marker;

      });
    });
  }

  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (conext, child, model){
          return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              flexibleSpace: AppBarGradient3(),
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.arrowLeft),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomeMapTur()
                  ));

                },
              ),
              title: Text("Ecoturismo"),
              centerTitle: true,
              actions: <Widget>[
                Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                  child: IconButton(
                    icon: Icon(Icons.add_circle),
                    iconSize: 23,
                    onPressed: () {
                      setState(() {
                        model.verificaLoginMapa(context, MyAddTurismo());
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
                          builder: (context) => MapaTurismoEcoturismo()
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

  Widget _containerCard(String _image, double lat, double lng, String restaurantName, String restaurantName2){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: _boxes(_image, lat, lng, restaurantName, restaurantName2),
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
            _containerCard("https://s0.wklcdn.com/image_89/2696705/19848185/12425442Master.jpg",
                -21.2390185, -48.512899,
                "Cachoeira Gabiru",
                "Ecoturismo"),
           _containerCard("https://i.ytimg.com/vi/KuNOLVUdQv0/hqdefault.jpg",
               -21.2819623, -48.5142146,
               "Gruta do Olho e Cachoeira do Cabelo",
               "Ecoturismo"),
            _containerCard("https://s0.wklcdn.com/image_89/2696705/19848185/12425442Master.jpg",
                -21.2751084, -48.513199,
                "cachoeira do jardim california",
                "Ecoturismo"),
            _containerCard("https://i.ytimg.com/vi/4ELZgrOHSWA/hqdefault.jpg",
                -21.2532535, -48.4882151,
                "Cachoeira do Rio Turvo",
                "Ecoturismo"),
          ],
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double lng, String restaurantName, String restaurantName2) {
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
              shadowColor: Colors.green[500],
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
                      child: myDetailsContainer1(restaurantName, restaurantName2),
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
        FontAwesomeIcons.suitcase,
        color: Colors.amber,
        size: 15.0,
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName, String restaurantName2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                restaurantName,
                style: TextStyle(
                    color: Colors.green[500],
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
        SizedBox(height: 5.0),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Text(
                restaurantName2,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
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