import 'package:flutter/material.dart';
import 'package:ilocationma/widgets/platform_alert_dialog.dart';
import 'package:ilocationma/widgets/platform_dialog_button_action.dart';

class DialogAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void alert(context, controller){
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
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      androidBarrierDismissible: true,
    );
  } 
  }
}
