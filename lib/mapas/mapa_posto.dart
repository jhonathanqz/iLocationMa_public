import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/add/add_posto.dart';
import 'package:ilocationma/home/HomePrincipal.dart';
import 'package:ilocationma/home/OpenUtil.dart';
import 'package:ilocationma/main.dart';
import 'package:ilocationma/mapas/homemap/cardMapBanco.dart';
import 'package:ilocationma/mapas/homemap/cardMapPosto.dart';
import 'package:ilocationma/modelsfunc/user_model.dart';
import 'package:ilocationma/widgets/global.dart';
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

  //Firebase para os Boxes
  var snapshots = FirebaseFirestore.instance.collection(Global.firebasePosto).snapshots();

  var urlReserva = 'https://firebasestorage.googleapis.com/v0/b/ilocationma-76ead.appspot.com/o/icones%2Ficones%20base%2Fposto1.png?alt=media&token=0eceb62e-8757-4e73-a370-8f566703c77a';

  FirebaseAuth auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    var db = FirebaseFirestore.instance;
    QuerySnapshot resultado = await db.collection(Global.firebasePosto).get();

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
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueCyan));
        _markers[result.name] = marker;
      });
    });
  }

  double zoomVal = 50.0;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (conext, child, model) {
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
          title: Text("Posto de Combustível"),
          centerTitle: true,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
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
                  _gotoLocation(lat, lng);
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => CardMapPosto()));
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
                                  image: NetworkImage(item['url'] ?? urlReserva),
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : Center(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            child: CircularProgressIndicator(
                                                backgroundColor: Colors.blue,
                                              ),
                                          ),
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
