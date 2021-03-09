import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/mapas/mapa_bancos.dart';
import 'package:ilocationma/model/AddPaginas.dart';
import 'package:ilocationma/modelsfunc/user_model.dart';
import 'package:ilocationma/widgets/platform_alert_dialog.dart';
import 'package:ilocationma/widgets/platform_dialog_button_action.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:geolocator/geolocator.dart';

class AddBancos extends StatefulWidget {
  @override
  _AddBancosState createState() => _AddBancosState();
}

class _AddBancosState extends State<AddBancos> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerLocal = TextEditingController();
  TextEditingController controllerEnd = TextEditingController();
  TextEditingController controllerObs = TextEditingController();

  String locationMessage = '';
  var latDevice;
  var lngDevice;

  void _getCurrentLocation() async{
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      controllerEnd.text = "${position.latitude}, ${position.longitude}";
      latDevice = "${position.latitude}";
      lngDevice = "${position.longitude}";

    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        key: _scaffoldKey,
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
                          builder: (context) => MapaBancos()));
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
                    Text('Adicionar Bancos',
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
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50, bottom: 30, right: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        textFieldd(controllerNome, Icons.person, "Nome: ",
                            "Seu Nome"),
                        SizedBox(
                          height: 16,
                        ),
                        textFieldd(controllerLocal, Icons.location_on,
                            "Local: ", "Nome do Local"),
                        SizedBox(
                          height: 16,
                        ),
                        textFieldd(controllerEnd, Icons.location_searching,
                            "Endereço: ", "Endereço do Local"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(onPressed: () {
                          _getCurrentLocation();
                        }, child: Text('Obter localização atual', style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14
                        ),),),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Text(
                              "Informações",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkBoxValue1,
                              activeColor: Colors.blue,
                              onChanged: (bool value) {
                                print(value);
                                setState(() {
                                  checkBoxValue1 = value;
                                });
                              },
                            ),
                            Text(
                              "Possuí caixa eletrônico 24hrs ",
                              style: TextStyle(fontSize: 13),
                            ),
                            Icon(
                              FontAwesomeIcons.clock,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkBoxValue2,
                              activeColor: Colors.blue,
                              onChanged: (bool value) {
                                print(value);
                                setState(() {
                                  checkBoxValue2 = value;
                                });
                              },
                            ),
                            Text(
                              "Banheiro adaptado para PcD",
                              style: TextStyle(fontSize: 13),
                            ),
                            Icon(Icons.accessible_forward, color: Colors.blue),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.hourglassHalf,
                              color: Colors.blue,
                            ),
                            Text(
                              'Selecione o horário de funcionamento:',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            )
                          ],
                        ),
                        Container(
                          child: DropdownButton<String>(
                            items: _currencies.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(
                                  dropDownStringItem,
                                  style: TextStyle(fontSize: 13),
                                ),
                              );
                            }).toList(),
                            onChanged: (String newValueSelected) {
                              _onDropDownItemSelected(newValueSelected);
                            },
                            value: _currentItemSelected,
                          ),
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Text("Qual sua avaliação de 1 á 5 ?",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkBoxAvalia1,
                              activeColor: Colors.yellow,
                              onChanged: (bool value) {
                                print(value);
                                setState(() {
                                  checkBoxAvalia1 = value;
                                  if (value = true) {
                                    checkBoxAvalia5 = false;
                                    checkBoxAvalia4 = false;
                                    checkBoxAvalia3 = false;
                                    checkBoxAvalia2 = false;
                                  }
                                });
                              },
                            ),
                            Text(
                              "1",
                              style: TextStyle(fontSize: 14),
                            ),
                            Checkbox(
                              value: checkBoxAvalia2,
                              activeColor: Colors.yellow,
                              onChanged: (bool value) {
                                print(value);
                                setState(() {
                                  checkBoxAvalia2 = value;
                                  if (value = true) {
                                    checkBoxAvalia5 = false;
                                    checkBoxAvalia4 = false;
                                    checkBoxAvalia3 = false;
                                    checkBoxAvalia1 = true;
                                  }
                                });
                              },
                            ),
                            Text(
                              "2",
                              style: TextStyle(fontSize: 14),
                            ),
                            Checkbox(
                              value: checkBoxAvalia3,
                              activeColor: Colors.yellow,
                              onChanged: (bool value) {
                                print(value);
                                setState(() {
                                  checkBoxAvalia3 = value;
                                  if (value = true) {
                                    checkBoxAvalia5 = false;
                                    checkBoxAvalia4 = false;
                                    checkBoxAvalia2 = true;
                                    checkBoxAvalia1 = true;
                                  }
                                });
                              },
                            ),
                            Text(
                              "3",
                              style: TextStyle(fontSize: 14),
                            ),
                            Checkbox(
                              value: checkBoxAvalia4,
                              activeColor: Colors.yellow,
                              onChanged: (bool value) {
                                print(value);
                                setState(() {
                                  checkBoxAvalia4 = value;
                                  if (value = true) {
                                    checkBoxAvalia5 = false;
                                    checkBoxAvalia3 = true;
                                    checkBoxAvalia2 = true;
                                    checkBoxAvalia1 = true;
                                  }
                                });
                              },
                            ),
                            Text(
                              "4",
                              style: TextStyle(fontSize: 14),
                            ),
                            Checkbox(
                              value: checkBoxAvalia5,
                              activeColor: Colors.yellow,
                              onChanged: (bool value) {
                                print(value);
                                setState(() {
                                  checkBoxAvalia5 = value;
                                  if (value = true) {
                                    checkBoxAvalia4 = true;
                                    checkBoxAvalia3 = true;
                                    checkBoxAvalia2 = true;
                                    checkBoxAvalia1 = true;
                                  }
                                });
                              },
                            ),
                            Text(
                              "5",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        textFieldd(controllerObs, FontAwesomeIcons.edit,
                            "Observação: ", "Alguma observação sobre o Banco?"),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: FlatButton(
                            onPressed: () {
                              if (controllerLocal.text == '' ||
                                  controllerNome.text == '' ||
                                  controllerEnd.text == '') {
                                _onAtention();
                              } else {
                                _onSuccess();
                                _validarCampos();
                                zerarController();
                                dialogLoc(MyMapaBancos());
                              }
                            },
                            child: FadeAnimation(
                                2,
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          Colors.blue[900],
                                          Colors.blue[600],
                                        ],
                                      )),
                                  child: Center(
                                    child: Text(
                                      "Enviar",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                )),
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
    });
  }

  Widget textFieldd(controller, Icons, String _prefixText, String _labelText) {
    return FadeAnimation(
      1,
      TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12),
          prefixIcon: Icon(
            Icons,
            color: Colors.blue,
          ),
          prefixText: _prefixText,
          prefixStyle: TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
          labelText: _labelText,
          labelStyle: TextStyle(color: Colors.blue),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  void _onAtention() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "Existe campos em branco. Por favor verifique!",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _onSuccess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          "Localização Enviada com Sucesso!!!",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _onDropDownItemSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }

  _validarCampos() {
    //Recupera dados dos campos
    String nome = controllerNome.text;
    String local = controllerLocal.text;
    String end = controllerEnd.text;
    String obs = controllerObs.text;

    AddPaginas loc = AddPaginas();
    loc.nome = nome;
    loc.local = local;
    loc.end = end;
    loc.obs = obs;

    _cadastrarLoc(loc);
  }

  _cadastrarLoc(AddPaginas loc) {
    var db = FirebaseFirestore.instance;
    db.collection("markersAddBanc").add({
      "name": loc.nome,
      "address": loc.local,
      "end": loc.end,
      "lat": latDevice,
      "lng": lngDevice,
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

  void dialogLoc(_controller) {
    showPlatformDialog(
      context: context,
      builder: (context) => PlatformAlertDialog(
        title: 'Localização enviada com sucesso!',
        content: Text(
            'Após análise de nossa equipe, sua localização será incluída em nosso mapa.\n\n Obrigado pela sua contribuição!'),
        actions: [
          destructiveAction('Voltar'),
          positiveAction(
            'Continuar',
            () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => _controller),
                  (Route<dynamic> route) => false);
            },
          )
        ],
      ),
      androidBarrierDismissible: true,
    );
  }

  void zerarController() {
    controllerEnd.text==' oi';
  }
}
