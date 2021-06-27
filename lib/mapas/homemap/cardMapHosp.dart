import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/widgets/global.dart';
import 'package:url_launcher/url_launcher.dart';

class CardMapHosp extends StatelessWidget {
  var snapshots = FirebaseFirestore.instance
      .collection(Global.firebaseHospital)
      .snapshots();

  var urlReserva = 'https://firebasestorage.googleapis.com/v0/b/ilocationma-76ead.appspot.com/o/icones%2Ficones%20base%2Fhospital1.png?alt=media&token=9ec2f08d-37b6-4f80-be26-1464b73a6c9c';


  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Localização'),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
      ),
      body: StreamBuilder(
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
              var mail = item['email'] ?? null;
              var zap = item['whatsapp'] ?? null;
              var phone1 = item['phone1'] ?? 'Não há telefones cadastrados';
              var phone2 = item['phone2'] ?? '';
              var phone3 = item['phone3'] ?? '';

              final Uri _emailLaunchUri = Uri(
                scheme: 'mailto',
                path: mail,
                query: 'subject=Contato & body=Detalhe aqui seu contato: ',
              );

              openWhatsapp() async {
                var whatsappUrl = "whatsapp://send?phone=$zap";

                if (await canLaunch(whatsappUrl)) {
                  await launch(whatsappUrl);
                } else {
                  throw 'Could not launch $whatsappUrl';
                }
              }

              //***Card de Localização****** */
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        child: Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 200.0,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    item['url'] ?? urlReserva,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      return progress == null
                                          ? child
                                          : CircularProgressIndicator(
                                              backgroundColor: Colors.blue,
                                            );
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8, top: 8, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item['name'],
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                      Text(
                                        item['endereco'] ?? item['address'],
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                                FlatButton(
                                  color: Colors.blue[200],
                                  onPressed: () {
                                    launch(
                                        "https://www.google.com/maps/search/?api=1&query=$lat,$lng");
                                  },
                                  child: Expanded(
                                    child: Container(
                                        color: Colors.blue[200],
                                        child: Row(
                                          children: [
                                            Icon(Icons.location_on),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Ver no mapa',
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                FlatButton(
                                  color: Colors.blue[200],
                                  onPressed: () {
                                    if (mail != null) {
                                      _emailLaunchUri.toString();
                                    } else {
                                      _onSuccess(
                                          'Não há Email cadastrado para o estabelecimento.');
                                    }
                                  },
                                  child: Expanded(
                                    child: Container(
                                        color: Colors.blue[200],
                                        child: Row(
                                          children: [
                                            Icon(Icons.mail),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Email',
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                FlatButton(
                                  color: Colors.blue[200],
                                  onPressed: () {
                                    if (zap != null) {
                                      openWhatsapp();
                                    } else {
                                      _onSuccess(
                                          'Não há Whatsapp cadastrado para o estabelecimento.');
                                    }
                                  },
                                  child: Expanded(
                                    child: Container(
                                        color: Colors.blue[200],
                                        child: Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.whatsapp,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'Whatsapp',
                                              style: TextStyle(fontSize: 18),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                Container(
                                  color: Colors.blue[200],
                                  margin: EdgeInsets.only(top: 8),
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: 8, left: 12),
                                          child: Row(
                                            children: [
                                              Icon(Icons.phone),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Telefones',
                                                style: TextStyle(fontSize: 18),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: 15,
                                            left: 12,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (phone1 != '') {
                                                launch("tel:$phone1");
                                              }
                                            },
                                            child: Text(
                                              phone1,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 15, left: 12),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (phone2 != '') {
                                                launch("tel:$phone2");
                                              }
                                            },
                                            child: Text(
                                              phone2,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 15, left: 12, bottom: 8),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (phone3 != '') {
                                                launch("tel:$phone3");
                                              }
                                            },
                                            child: Text(
                                              phone3,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _onSuccess(String _text) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          _text,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[700],
        duration: Duration(seconds: 3),
      ),
    );
  }
}
