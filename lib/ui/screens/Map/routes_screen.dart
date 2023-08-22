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
    // return const Center(child: Text('Routes Screen'));
    return Column(
      children: [
        Center(
          child: ElevatedButton(
            child: const Text("PRESS TO UPLOAD EXCEL AND CONVERT TO JSON"),
            onPressed: () async {
              String? excel = await ExcelToJson().convert();
              Map<String, dynamic> jsonObject = jsonDecode(excel!);
              List hoja1 = jsonObject['Con cedula_sin telefono'];
              List<Votante> listVot = [];
              for (var element in hoja1) {
                Votante votante = Votante(
                    name: element['Nombre'].toString(),
                    id: element['Cedula'].toString(),
                    leaderID: '11111111',
                    phone: element['Celular']?.toString() ?? "",
                    puestoID: element['Puesto de votación'].toString(),
                    direccion: element['Direccion'].toString(),
                    edad: '',
                    municipio: 'Valledupar',
                    barrio: element['Barrio o Corregimiento'].toString(),
                    estado: 'activo',
                    encuesta: false);

                if (votante.id != 'Sin cedula') {
                  bool hasPhone = false;
                  bool ccrepeat = false;
                  for (var e in listVot) {
                    if (votante.id == e.id) {
                      ccrepeat = true;
                      break;
                    }
                    // if (votante.phone == e.phone) {
                    //   hasPhone = true;
                    //   break;
                    // }
                  }
                  if (!ccrepeat && !hasPhone) {
                    listVot.add(votante);
                    hasPhone = false;
                  }
                }
              }
              List<Map<String, dynamic>> jsonList =
                  listVot.map((votante) => votante.toJson()).toList();
              String jsonString = json.encode(jsonList);
              window.localStorage['data'] = jsonString;
              // for (var e in listVot) {
              //   // String ss = await mainController.addVotante2(e);
              //   // String ss = await mainController.addVotante(e);
              //   print(e);
              // }
              // Acceder a los valores
              // String nombre = jsonObject['Hoja1'];

              // // Imprimir los valores
              // print('Nombre: $nombre');

              // print(excel);
            },
          ),
        ),
        ElevatedButton(
          child: const Text("Up Second List"),
          onPressed: () async {
            mainController.try3();
            // String ss = await mainController.addVotante2();
            // List<Map<String, dynamic>> jsonList = mainController.auxvot
            //     .map((votante) => votante.toJson())
            //     .toList();
            // String jsonString = json.encode(jsonList);
            // window.localStorage['data'] = jsonString;
          },
        ),
        ElevatedButton(
          child: const Text("charge second List"),
          onPressed: () async {
            // File file = File('');

            var jsonString =
                '[{"name":"ACELA VERDUGO","id":"42486331","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CLL 7Z #43-40","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"AMANDA GALVAN H","id":"5132284","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CLL 5E #40.56","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"ANDRES MENDEZ","id":"1062398218","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CLL 5B #42-48","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"ANIBAL CARVAJALINO","id":"5035479","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"Sin direccion","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"BERTA GOMEZ DE GALAN","id":"49337902","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CRA 18D #28-50","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"CARMEN CALBUENA M","id":"42487346","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CLL 5E #40-50","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"JOSE DOMINGO","id":"12643004","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CRA 21 #25-46","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"LUZ BUELVAS LOPEZ","id":"63474913","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CALLE 29# 4D-68","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"MARCOS ANDRADE","id":"14560519","leaderID":"11111111","phone":"REPETIDO","puntoID":"Sin puesto","direccion":"Sin direccion","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"MARIA MORENO","id":"49724251","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CL 5 #46-26","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"NEFTALI MENDEZ VILLEGAS","id":"5009075","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CL 6 #19-55","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"RAFAEL GAMEZ","id":"513705","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"TRANSV 23 #30-","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"RAFAEL POLO","id":"5003841","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CLL 9 CASA 52","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"WILSON ALTMAR","id":"85081018","leaderID":"11111111","phone":"REPETIDO","puntoID":"Sin puesto","direccion":"Sin direccion","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"LEINER JOSE ATEORTUA LOZANO","id":"1067593447","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"CRA 18 G1 57-41","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null},{"name":"Yuleinis Milena Alvarado Rangel","id":"1093754476","leaderID":"11111111","phone":"","puntoID":"Sin puesto","direccion":"calle 5 h #49-65","edad":"","barrio":"Sin Barrio","municipio":"Valledupar","estado":"activo","encuesta":false,"responsable":null,"mesa":null,"sexo":null,"segmento":null}]';

            List<Map<String, dynamic>> jsonList =
                json.decode(jsonString).cast<Map<String, dynamic>>();

            List<Votante> people =
                jsonList.map((json) => Votante.fromJson(json)).toList();

            // Ahora puedes utilizar la lista de personas (people) en tu nueva compilación
            // print(people);
            // for (var e in people) {
            //   String ss = await mainController.addVotante(e);
            //   print(e);
            // }
            for (var e in people) {
              String ss = await mainController.addVotante2(e);
              // String ss = await mainController.addVotante(e);
              print(ss);
            }
          },
        ),
      ],
    );
  }
}
