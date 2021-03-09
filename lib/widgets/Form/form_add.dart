import 'package:flutter/material.dart';
import 'package:ilocationma/Animation/FadeAnimation.dart';

class FormAdd extends StatelessWidget {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerLocal = TextEditingController();
  TextEditingController controllerEnd = TextEditingController();

  @override
  Widget build(BuildContext context) => Form(
        child: Column(
          children: [
            textFieldd(controllerNome, Icons.person, "Nome: ", "Seu Nome"),
            SizedBox(
              height: 16,
            ),
            textFieldd(
                controllerLocal, Icons.location_on, "Local: ", "Nome do Local"),
            SizedBox(
              height: 16,
            ),
            textFieldd(controllerEnd, Icons.location_searching, "Endereço: ",
                "Endereço do Local"),
          ],
        ),
      );
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
}
