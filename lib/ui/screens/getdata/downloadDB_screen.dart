import 'dart:js_interop';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charts_painter/chart.dart';
import 'package:d_chart/d_chart.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/ui/common/staticsFields.dart';
import 'package:registrovot/ui/screens/getdata/consultarLideres_screen.dart';

import '../../../controller/mainController.dart';
import '../../../model/votante.dart';
import 'dart:collection';

class DownloadDBScreen extends StatefulWidget {
  const DownloadDBScreen({super.key});

  @override
  State<DownloadDBScreen> createState() => DownloadDBScreenState();
}

class DownloadDBScreenState extends State<DownloadDBScreen> {
  final mainController = Get.find<MainController>();
  List<String> barrios = [];
  List<Barrio> comunas = [];

  Map usuariosxBarrio = {};
  Map usuariosxComuna = {};
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataComuna = [];
  StaticFields staticFields = StaticFields();
  @override
  void initState() {
    super.initState();

    for (var barr in staticFields.getBarrios()) {
      comunas.add(barr);
    }

    for (var element in mainController.filterVotante) {
      if (!barrios.contains(element.barrio)) {
        barrios.add(element.barrio ?? '-');
      }
    }

    for (var barrio in barrios) {
      int cont = 0;

      for (var element in mainController.filterVotante) {
        if (barrio == element.barrio) {
          cont++;
        }
      }

      usuariosxBarrio[barrio] = cont;
    }
    var sortedMap = SplayTreeMap.from(usuariosxBarrio,
        (a, b) => usuariosxBarrio[b].compareTo(usuariosxBarrio[a]));

    sortedMap.forEach((key, value) {
      data.add({'domain': key, 'measure': value});
    });

    for (var dat in data) {
      for (var barriocomunas in comunas) {
        if (dat['domain'] == barriocomunas.barrio) {
          if (!usuariosxComuna.keys.contains(barriocomunas.comuna)) {
            usuariosxComuna[barriocomunas.comuna] = dat['measure'];
          } else {
            usuariosxComuna[barriocomunas.comuna] += dat['measure'];
          }
        }
      }
    }
    usuariosxComuna.forEach((key, value) {
      dataComuna.add({'domain': 'Comuna ' + key, 'measure': value});
    });
    dataComuna.sort((a, b) => b['measure'].compareTo(a['measure']));
    // var sortedMapComuna = SplayTreeMap.from(usuariosxComuna,
    //     (a, b) => usuariosxComuna[b].compareTo(usuariosxComuna[a]));
    // sortedMapComuna.forEach((key, value) {
    //   dataComuna.add({'domain': key, 'measure': value});
    // });
    print(dataComuna);
  }

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    String colection =
        mainController.emailUser.split('@').last.split('.').first;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: localwidth * 0.1, vertical: 20),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cantidad Registros por Barrio',
                  style: TextStyle(fontSize: 20),
                ),
                Text('Cantidad Registros por Comuna',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffff004e),
          ),
          mainController.emailUser.toLowerCase().contains('alcaldia') ||
                  mainController.emailUser.toLowerCase().contains('consejo') ||
                  colection.toLowerCase().contains('registro')
              ? Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                title: Text(data[index]['domain']),
                                trailing:
                                    Text(data[index]['measure'].toString()),
                              );
                            }),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: DChartBar(
                          data: [
                            {'id': 'Bar', 'data': dataComuna},
                          ],
                          domainLabelPaddingToAxisLine: 16,
                          axisLineTick: 2,
                          axisLinePointTick: 2,
                          axisLinePointWidth: 10,
                          axisLineColor: Colors.green,
                          measureLabelPaddingToAxisLine: 16,
                          barColor: (barData, index, id) {
                            int r = 0 + Random().nextInt((255 + 1) - 0);
                            int g = 0 + Random().nextInt((255 + 1) - 0);
                            int b = 0 + Random().nextInt((255 + 1) - 0);
                            return Color.fromARGB(255, r, g, b);
                          },
                          showBarValue: true,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                _showloading();
                await Future.delayed(const Duration(seconds: 1));
                await exportToExcel();
                Get.back();
              },
              child: const Text('Descargar Base de Datos'),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Future<void> exportToExcel() async {
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

  void _showloading() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: LoadingAnimationWidget.newtonCradle(
                color: Colors.pink, size: 100)));
  }
}
