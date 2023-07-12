import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/mainController.dart';

class ConsultarPuestosScreen extends StatefulWidget {
  const ConsultarPuestosScreen({super.key});

  @override
  State<ConsultarPuestosScreen> createState() => ConsultarPuestosScreenState();
}

class ConsultarPuestosScreenState extends State<ConsultarPuestosScreen> {
  final mainController = Get.find<MainController>();
  List<String> puestos = [];
  Map usuariosxPuesto = {};
  Map usuariosxPuestoName = {};
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataNombre = [];
  @override
  void initState() {
    super.initState();

    for (var element in mainController.filterVotante) {
      if (!puestos.contains(element.puestoID)) {
        puestos.add(element.puestoID);
      }
    }

    for (var puesto in puestos) {
      int cont = 0;

      for (var element in mainController.filterVotante) {
        if (puesto == element.puestoID) {
          cont++;
        }
      }

      usuariosxPuesto[puesto] = cont;
    }
    var sortedMap = SplayTreeMap.from(usuariosxPuesto,
        (a, b) => usuariosxPuesto[b].compareTo(usuariosxPuesto[a]));

    sortedMap.forEach((key, value) {
      data.add({'domain': key, 'measure': value});
    });
    // print(data);
    for (var dat in data) {
      for (var puestosName in mainController.filterPuesto) {
        if (dat['domain'] == puestosName.id) {
          usuariosxPuestoName[puestosName.nombre] = dat['measure'];
        }
      }
    }
    usuariosxPuestoName.forEach((key, value) {
      dataNombre.add({'domain': 'C ' + key, 'measure': value});
    });
    dataNombre.sort((a, b) => b['measure'].compareTo(a['measure']));
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Consulta Puestos'),
    );
  }
}
