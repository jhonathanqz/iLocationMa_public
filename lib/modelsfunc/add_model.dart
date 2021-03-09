import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ilocationma/model/AddPaginas.dart';
import 'package:scoped_model/scoped_model.dart';

class AddModel extends Model {
  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerLocal = TextEditingController();
  TextEditingController _controllerEnd = TextEditingController();
  TextEditingController _controllerObs = TextEditingController();
  bool checkBoxValue1 = false;
  bool checkBoxValue2 = false;
  bool checkBoxValue3 = false;
  bool checkBoxAvalia1 = false;
  bool checkBoxAvalia2 = false;
  bool checkBoxAvalia3 = false;
  bool checkBoxAvalia4 = false;
  bool checkBoxAvalia5 = false;
  var _currencies = [
    '7h às 21h',
    '7h às 22h',
    '8h às 21h',
    '9h às 18h',
    '10h às 22h',
    '24h',
    'Sem informação sobre o horário'
  ];
  var _currentItemSelected = 'Sem informação sobre o horário';

  void NovaLocalizacao(String _text) {
    //Recupera dados dos campos
    String nome = _controllerNome.text;
    String local = _controllerLocal.text;
    String end = _controllerEnd.text;
    String obs = _controllerObs.text;

    AddPaginas loc = AddPaginas();
    loc.nome = nome;
    loc.local = local;
    loc.end = end;
    loc.obs = obs;

    var db = FirebaseFirestore.instance;
    db.collection(_text).add({
      "nome": loc.nome,
      "local": loc.local,
      "end": loc.end,
      "obs": loc.obs,
      "avaliacao1": checkBoxAvalia1,
      "avaliacao2": checkBoxAvalia2,
      "avaliacao3": checkBoxAvalia3,
      "avaliacao4": checkBoxAvalia4,
      "avaliacao5": checkBoxAvalia5,
      "Caixa 24h": checkBoxValue1,
      "Banheiro PCD": checkBoxValue2,
      "horario": _currentItemSelected,
    });
  }
}
