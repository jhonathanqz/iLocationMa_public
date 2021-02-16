import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';
import 'package:ilocationma/mapas/mapa_bancos.dart';
import 'package:ilocationma/mapas/mapa_hospital.dart';
import 'package:ilocationma/model/AddPaginas.dart';
import 'package:ilocationma/modelsfunc/user_model.dart';
import 'package:scoped_model/scoped_model.dart';



void main() => runApp(MyAddHospital());

class MyAddHospital extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddHospital(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AddHospital extends StatefulWidget {
  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {

  TextEditingController _controllerNome = TextEditingController();
  TextEditingController _controllerLocal = TextEditingController();
  TextEditingController _controllerEnd = TextEditingController();
  TextEditingController _controllerObs = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();



  _validarCampos(){

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


    _cadastrarLoc(loc);
  }

  _cadastrarLoc( AddPaginas loc ){
    var db = FirebaseFirestore.instance;
    db.collection("markersAddHosp").add(
        {
          "nome" : loc.nome,
          "local" : loc.local,
          "end" : loc.end,
          "obs" : loc.obs,
          "avaliacao1" : checkBoxAvalia1,
          "avaliacao2" : checkBoxAvalia2,
          "avaliacao3" : checkBoxAvalia3,
          "avaliacao4" : checkBoxAvalia4,
          "avaliacao5" : checkBoxAvalia5,
          "Hosp. Particular" :  checkBoxValue1,
          "Convênio" : checkBoxValue2,
          "S.U.S" : checkBoxValue3,
          "Possui UTI" : checkBoxValue4,
          "horario" : _currentItemSelected,

        }

    );
  }

  bool checkBoxValue1 = false;
  bool checkBoxValue2 = false;
  bool checkBoxValue3 = false;
  bool checkBoxValue4 = false;
  bool checkBoxAvalia1 = false;
  bool checkBoxAvalia2 = false;
  bool checkBoxAvalia3 = false;
  bool checkBoxAvalia4 = false;
  bool checkBoxAvalia5 = false;


  var _currencies = ['7h às 21h', '7h às 22h', '8h às 21h', '9h às 18h', '10h às 22h', '24h', 'Sem informação sobre o horário'];
  var _currentItemSelected = 'Sem informação sobre o horário';


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
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
                              builder: (context) => MapaHospital()
                          ));
                        },
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 25.0),
                FadeAnimation(1,
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text('iLocationMA' ,
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0)),

                      ],
                    ),

                  ),),
                SizedBox(height: 10,),
                FadeAnimation(1,
                  Padding(
                    padding: EdgeInsets.only(left: 40.0),
                    child: Row(
                      children: <Widget>[
                        Text('Adicionar Hospital',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.white,
                                fontSize: 20.0))
                      ],
                    ),

                  ),),
                SizedBox(height: 40.0),
                Container(
                  height: MediaQuery.of(context).size.height - 185.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(75.0)),
                  ),
                  child: ListView(
                    primary: false,
                    padding: EdgeInsets.all(16),
                    children: <Widget>[

                      Padding(padding: EdgeInsets.only(top: 50, bottom: 30, right: 35),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            textFieldd(_controllerNome,Icons.person, "Nome: ", "Seu Nome"),
                            SizedBox(
                              height: 16,
                            ),
                            textFieldd(_controllerLocal,Icons.location_on, "Local: ", "Nome do Local"),
                            SizedBox(
                              height: 16,
                            ),
                            textFieldd(_controllerEnd,Icons.location_searching, "Endereço: ", "Endereço do Local"),
                            Divider(),
                            Row(
                              children: <Widget>[
                                Text("Informações", style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),)
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
                                Text("Particular", style: TextStyle(fontSize: 13),),
                                Icon(Icons.enhanced_encryption, color: Colors.blue,),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(
                                  value: checkBoxValue4,
                                  activeColor: Colors.blue,
                                  onChanged: (bool value) {
                                    print(value);
                                    setState(() {
                                      checkBoxValue4 = value;
                                    });
                                  },

                                ),
                                Text("Convênio", style: TextStyle(fontSize: 13),),
                                Icon(FontAwesomeIcons.moneyBillWaveAlt, color: Colors.blue,),
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
                                Text("Público (SUS)", style: TextStyle(fontSize: 13),),
                                Icon(Icons.local_hospital, color: Colors.blue),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Checkbox(

                                  value: checkBoxValue3,
                                  activeColor: Colors.blue,
                                  onChanged: (bool value) {
                                    print(value);
                                    setState(() {
                                      checkBoxValue3 = value;
                                    });
                                  },

                                ),
                                Text("Possui U.T.I ", style: TextStyle(fontSize: 13),),

                                Icon(FontAwesomeIcons.procedures, color: Colors.blue,),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Icon(FontAwesomeIcons.hourglassHalf, color: Colors.blue,),
                                Text('Selecione os horários de visita:', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 14),)
                              ],
                            ),
                            Container(

                              child:DropdownButton<String>(
                                items: _currencies.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),

                                onChanged: (String newValueSelected) {
                                  _onDropDownItemSelected(newValueSelected);

                                },
                                value: _currentItemSelected,
                              ),
                            ),
                            SizedBox(height: 10,),

                            Row(
                              children: <Widget>[
                                Text("Qual sua nota de 1 á 5, referente ao atendimento?", style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold)),
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
                                      if(value=true){
                                        checkBoxAvalia5=false;
                                        checkBoxAvalia4=false;
                                        checkBoxAvalia3=false;
                                        checkBoxAvalia2=false;
                                      }
                                    });
                                  },

                                ),
                                Text("1", style: TextStyle(fontSize: 14),),
                                Checkbox(

                                  value: checkBoxAvalia2,
                                  activeColor: Colors.yellow,
                                  onChanged: (bool value) {
                                    print(value);
                                    setState(() {
                                      checkBoxAvalia2 = value;
                                      if(value=true){
                                        checkBoxAvalia5=false;
                                        checkBoxAvalia4=false;
                                        checkBoxAvalia3=false;
                                        checkBoxAvalia1=true;
                                      }
                                    });
                                  },

                                ),
                                Text("2", style: TextStyle(fontSize: 14),),
                                Checkbox(

                                  value: checkBoxAvalia3,
                                  activeColor: Colors.yellow,
                                  onChanged: (bool value) {
                                    print(value);
                                    setState(() {
                                      checkBoxAvalia3 = value;
                                      if(value=true){
                                        checkBoxAvalia5=false;
                                        checkBoxAvalia4=false;
                                        checkBoxAvalia2=true;
                                        checkBoxAvalia1=true;
                                      }
                                    });
                                  },

                                ),
                                Text("3", style: TextStyle(fontSize: 14),),
                                Checkbox(

                                  value: checkBoxAvalia4,
                                  activeColor: Colors.yellow,
                                  onChanged: (bool value) {
                                    print(value);
                                    setState(() {
                                      checkBoxAvalia4 = value;
                                      if(value=true){
                                        checkBoxAvalia5=false;
                                        checkBoxAvalia3=true;
                                        checkBoxAvalia2=true;
                                        checkBoxAvalia1=true;
                                      }
                                    });
                                  },

                                ),
                                Text("4", style: TextStyle(fontSize: 14),),
                                Checkbox(

                                  value: checkBoxAvalia5,
                                  activeColor: Colors.yellow,
                                  onChanged: (bool value) {
                                    print(value);
                                    setState(() {
                                      checkBoxAvalia5 = value;
                                      if(value=true){
                                        checkBoxAvalia4=true;
                                        checkBoxAvalia3=true;
                                        checkBoxAvalia2=true;
                                        checkBoxAvalia1=true;

                                      }
                                    });
                                  },

                                ),
                                Text("5", style: TextStyle(fontSize: 14),),
                              ],
                            ),
                            textFieldd(_controllerObs, FontAwesomeIcons.edit, "Observação: ", "Alguma observação sobre o uso do Hospital?"),

                            Padding(padding: EdgeInsets.symmetric(vertical: 20),
                              child: FlatButton(
                                onPressed: () {
                                  if(_controllerLocal.text== '' || _controllerNome.text=='' || _controllerEnd.text==''){
                                    _onAtention();
                                  }else{
                                    _onSuccess();
                                    _validarCampos();
                                    model.NovaLocalizacao(context, MyMapaHospital());

                                  }
                                },
                                child: FadeAnimation(2, Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          Colors.blue[900],
                                          Colors.blue[600],
                                        ],
                                      )
                                  ),
                                  child: Center(
                                    child: Text("Enviar", style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.bold, fontSize: 17),),
                                  ),
                                )),
                              ),),


                          ],
                        ),),



                    ],
                  ),
                )
              ],
            ),
          );
    });
  }
  Widget textFieldd(controller, Icons, String _prefixText, String _labelText) {
    return FadeAnimation(1, TextField(
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
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15)),
      ),
    ),);
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


}
