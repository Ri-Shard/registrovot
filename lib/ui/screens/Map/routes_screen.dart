import 'dart:html';

import 'package:excel/excel.dart';
import 'package:excel_to_json/excel_to_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:get/get.dart';
import 'dart:convert';

import 'package:registrovot/model/votante.dart';
import 'package:registrovot/ui/screens/getdata/consultarLideres_screen.dart';

import '../../../controller/mainController.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => RoutesScreenState();
}

class RoutesScreenState extends State<RoutesScreen> {
  MainController mainController = Get.find();
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Routes Screen'));
    // return Column(
    //   children: [
    //     Center(
    //       child: ElevatedButton(
    //         child: const Text("PRESS TO UPLOAD EXCEL AND CONVERT TO JSON"),
    //         onPressed: () async {
    //           String? excel = await ExcelToJson().convert();
    //           Map<String, dynamic> jsonObject = jsonDecode(excel!);
    //           List hoja1 = jsonObject['Respuestas de formulario 1'];
    //           List<Votante> listVot = [];
    //           for (var element in hoja1) {
    //             Votante votante = Votante(
    //                 name: element['Nombre'].toString(),
    //                 id: element['Cedula'].toString(),
    //                 leaderID: '0000000',
    //                 phone: element['Celular']?.toString() ?? "",
    //                 puestoID: 'Sin Puesto',
    //                 direccion: element['Direccion'].toString(),
    //                 edad: '',
    //                 municipio: 'Valledupar',
    //                 barrio:
    //                     // element['Barrio']?.toString().trim() ??
    //                     "Sin Barrio",
    //                 estado: 'activo',
    //                 encuesta: 'Sin llamar',
    //                 sexo: element['Sexo'],
    //                 segmento: element['Segmento']);

    //             if (votante.id != 'Sin cedula') {
    //               bool hasPhone = false;
    //               bool ccrepeat = false;
    //               for (var e in listVot) {
    //                 if (votante.id == e.id) {
    //                   ccrepeat = true;
    //                   break;
    //                 }
    //                 // if (votante.phone == e.phone) {
    //                 //   hasPhone = true;
    //                 //   break;
    //                 // }
    //               }
    //               if (!ccrepeat && !hasPhone) {
    //                 listVot.add(votante);
    //                 hasPhone = false;
    //               }
    //             }
    //           }
    //           // List<Map<String, dynamic>> jsonList =
    //           //     listVot.map((votante) => votante.toJson()).toList();
    //           // String jsonString = json.encode(jsonList);
    //           // window.localStorage['data'] = jsonString;
    //           for (var e in listVot) {
    //             String ss = await mainController.addVotante2(e);
    //             // String ss = await mainController.addVotante(e);
    //             print(ss);
    //           }
    //           // Acceder a los valores
    //           // String nombre = jsonObject['Hoja1'];

    //           // // Imprimir los valores
    //           // print('Nombre: $nombre');

    //           // print(excel);
    //         },
    //       ),
    //     ),
    //     ElevatedButton(
    //       child: const Text("Up Second List"),
    //       onPressed: () async {
    //         mainController.try3();
    //         // String ss = await mainController.addVotante2();
    //         // List<Map<String, dynamic>> jsonList = mainController.auxvot
    //         //     .map((votante) => votante.toJson())
    //         //     .toList();
    //         // String jsonString = json.encode(jsonList);
    //         // window.localStorage['data'] = jsonString;
    //       },
    //     ),
    //     ElevatedButton(
    //       child: const Text("charge second List"),
    //       onPressed: () async {
    //         // File file = File('');

    //         var jsonString = '';

    //         List<Map<String, dynamic>> jsonList =
    //             json.decode(jsonString).cast<Map<String, dynamic>>();

    //         List<Votante> people =
    //             jsonList.map((json) => Votante.fromJson(json)).toList();

    //         // Ahora puedes utilizar la lista de personas (people) en tu nueva compilación
    //         // print(people);
    //         // for (var e in people) {
    //         //   String ss = await mainController.addVotante(e);
    //         //   print(e);
    //         // }
    //         for (var e in people) {
    //           String ss = await mainController.addVotante2(e);
    //           // String ss = await mainController.addVotante(e);
    //           print(ss);
    //         }
    //       },
    //     ),
    //   ],
    // );
  }
}
