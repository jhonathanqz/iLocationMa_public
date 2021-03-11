import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/add/add_farmacia.dart';
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
  //Firebase para os boxes
  var snapshots = FirebaseFirestore.instance.collection('markersfarm').snapshots();

  var urlReserva = 'https://firebasestorage.googleapis.com/v0/b/ilocationma-76ead.appspot.com/o/icones%2Ficones%20base%2Ffarmacia1.png?alt=media&token=fc5ee10c-eb68-4735-9c62-2715aa1ff27b';


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
                onTap: () {
                  OpenUtil.openMap(result.lat, result.lng);
                }),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
        _markers[result.name] = marker;
      });
    });
  }

  double zoomVal = 50.0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          flexibleSpace: AppBarGradient2(),
          leading: IconButton(
            icon: Icon(FontAwesomeIcons.arrowLeft),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => MyHomePrincipal()));
            },
          ),
          title: Text("Farmácias"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            elevation: 2,
                            backgroundColor: Colors.grey[200],
                            title: Text(
                              "Farmácias de Plantão",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            content: Text(
                              "       Aos Sábados, Domingos e Feriados as farmácias trabalham em regime de plantão. Para saber quais as farmácias que estão atendendo no plantão, por favor, clique no ícone abaixo e consulte diretamente no site da prefeitura.",
                              style: TextStyle(fontSize: 16),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 30, 0),
                                        child: Text(
                                          "Voltar ao Mapa",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )
                                    ],
                                  )),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.clinicMedical),
                                iconSize: 20,
                                color: Colors.red,
                                onPressed: () {
                                  launch(
                                      "http://montealto.sp.gov.br/site/plantaofarmaceutico/");
                                },
                              ),
                            ],
                          ));
                },
              ),
            ),
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


  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: _boxesStream(),
      ),
    );
  }

  Widget _boxesStream() {
    return StreamBuilder(
      stream: snapshots,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Erro: ${snapshot.error}'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
            ),
          );
        }
        if (snapshot.data.docs.length == 0) {
          return Center(
            child: Text('Não há nenhum local cadastrado no momento'),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (BuildContext context, int i) {
            var doc = snapshot.data.docs[i];
            var item = doc.data();
            var lat = item['lat'];
            var lng = item['lng'];

            //***BOXES DE CARDS AQUI****** */
            return Padding(
              padding: EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  _gotoLocation(item['lat'], item['lng']);
                  launch(
                      "https://www.google.com/maps/search/?api=1&query=$lat,$lng");
                },
                child: Container(
                  child: new FittedBox(
                    child: Material(
                        color: Colors.white,
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(24.0),
                        shadowColor: Colors.amber,
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
                                  image: NetworkImage(item['url'] ?? 
                                  urlReserva),
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : CircularProgressIndicator(
                                            backgroundColor: Colors.blue,
                                          );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: myDetailsContainer1(item['name']),
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _containerStars() {
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
              '',
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
