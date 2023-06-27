import 'dart:js_interop';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/ui/screens/getdata/consultarLideres_screen.dart';

import '../../../controller/mainController.dart';
import '../../../model/votante.dart';

class DownloadDBScreen extends StatefulWidget {
  const DownloadDBScreen({super.key});

  @override
  State<DownloadDBScreen> createState() => DownloadDBScreenState();
}

class DownloadDBScreenState extends State<DownloadDBScreen> {
  final mainController = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            exportToExcel();
          },
          child: const Text('Descargar Base de Datos'),
        ),
      ),
    );
  }

  void exportToExcel() {
    try {
      final excel = Excel.createExcel();
      final Sheet sheet = excel[excel.getDefaultSheet()!];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = 'Cedula';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
          .value = 'Nombre';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
          .value = 'Telefono';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          .value = 'Edad';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
          .value = 'Municipio';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
          .value = 'Barrio';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0))
          .value = 'Direccion';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0))
          .value = 'Lider';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0))
          .value = 'Encuesta';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0))
          .value = 'Puesto de Votacion';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0))
          .value = 'Estado';

      for (var row = 0; row < mainController.filterVotante.length; row++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
            .value = mainController.filterVotante[row].id;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
            .value = mainController.filterVotante[row].name;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
            .value = mainController.filterVotante[row].phone;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1))
            .value = mainController.filterVotante[row].edad;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1))
            .value = mainController.filterVotante[row].municipio;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1))
            .value = mainController.filterVotante[row].barrio;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row + 1))
            .value = mainController.filterVotante[row].direccion;
        Leader? leader = mainController
            .getoneLeader(mainController.filterVotante[row].leaderID);
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row + 1))
            .value = leader?.name ?? '';
        String? encuesta;
        if (mainController.filterVotante[row].encuesta == true) {
          encuesta = 'Si';
        } else {
          encuesta = (mainController.filterVotante[row].encuesta == false
              ? 'No'
              : 'No responde');
        }
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row + 1))
            .value = encuesta;
        Puesto? puesto = mainController
            .getonePuesto(mainController.filterVotante[row].puestoID);
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row + 1))
            .value = puesto?.nombre ?? '';
        sheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row + 1))
            .value = mainController.filterVotante[row].estado;
      }

      excel.save(fileName: "ReporteDataBase.xlsx");
      Future.delayed(const Duration(seconds: 2)).whenComplete(() => Get.back());
    } catch (e) {
      Get.back();
      AwesomeDialog(
              width: 566,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Error',
              desc: 'Ocurrio un error al generar el archivo $e',
              btnOkOnPress: () {},
              btnOkIcon: Icons.cancel,
              btnOkColor: const Color(0xff01b9ff))
          .show();
    }
  }
}
