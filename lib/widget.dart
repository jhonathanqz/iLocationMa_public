import 'package:flutter/material.dart';

class AppBarGradient1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Colors.blue[600],
                Colors.black87,
              ],
              tileMode: TileMode.clamp)),
    );
  }
}

//Classe Markers para importar dos marcadores do firebase
class Markers {
  double lat;
  double lng;
  String name;
  String address;
  String url;
  Markers({this.lat, this.lng, this.name, this.address, this.url});
  Markers.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
    name = json['name'];
    address = json['address'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['address'] = this.address;
    data['url'] = this.url;

    return data;
  }
}

class NameUsuario {
  String nomeCadastro;
  NameUsuario({this.nomeCadastro});
  NameUsuario.fromJson(Map<String, dynamic> json) {
    nomeCadastro = json['nomeCadastro'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeCadastro'] = this.nomeCadastro;
    return data;
  }
}

//***Classe para retornar a lista de Boxes nos mapas***//
class MarkersBoxes {
  double lat;
  double lng;
  String name;
  String url;
  MarkersBoxes({this.lat, this.lng, this.name, this.url});
  MarkersBoxes.fromJson(Map<String, dynamic> json) {
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}
