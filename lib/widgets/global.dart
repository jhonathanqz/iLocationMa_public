library globals;
import 'package:flutter/material.dart';
import 'dart:io';


class Global {

  Global({
    this.isLogado,
  });

  var isLogado = '';

  //Bancos Firebase
  static var firebaseBanco = 'markers';
  static var firebaseBanheiro = 'markersbanh';
  static var firebaseCulinaria = 'markersrest';
  static var firebaseFarmacia = 'markersfarm';
  static var firebaseHospital = 'markershosp';
  static var firebasePosto = 'markersposto';
  static var firebaseTurEco = 'markerstur_ecoturismo';
  static var firebaseTurRel = 'markerstur_religioso';
  static var firebaseTurLoc = 'markerstur';

  //Add Firebase
  static var firebaseAddBanco = 'markersAddBanc';
  static var firebaseAddBanheiro = 'markersAddBanh';
  static var firebaseAddCulinaria = 'markersAddRest';
  static var firebaseAddFarmacia = 'markersAddFarm';
  static var firebaseAddHospital = 'markersAddHosp';
  static var firebaseAddPosto = 'markersAddPosto';
  static var firebaseAddTurEco = 'markersAddTur';
  static var firebaseAddTurRel = 'markersAddTur';
  static var firebaseAddTurLoc = 'markersAddTur';
  static var firebaseAddTur = 'markersAddTur';

}