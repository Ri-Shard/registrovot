import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/model/votante.dart';

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
      List<Votante> listavVotantexPuestos = [];

      for (var element in mainController.filterVotante) {
        if (puesto == element.puestoID) {
          cont++;
          listavVotantexPuestos.add(element);
        }
      }

      usuariosxPuesto[puesto] = listavVotantexPuestos;
    }
    // var sortedMap = SplayTreeMap.from(usuariosxPuesto,
    //     (a, b) => usuariosxPuesto[b].compareTo(usuariosxPuesto[a]));
    var sortedMap = Map.fromEntries(usuariosxPuesto.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length)));
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
      dataNombre.add({'domain': key, 'measure': value.length});
    });
    // dataNombre.sort((a, b) => b['measure'].compareTo(a['measure']));
  }

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    return Padding(
        padding:
            EdgeInsets.symmetric(horizontal: localwidth * 0.1, vertical: 20),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cantidad Registros por Puesto',
                  style: TextStyle(fontSize: 20),
                ),
                Text('Total Registros: ${mainController.filterVotante.length}'),
              ],
            ),
          ),
          const Divider(
            color: Color(0xffff004e),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: dataNombre.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                          title: Text(dataNombre[index]['domain']),
                          trailing:
                              Text(dataNombre[index]['measure'].toString()),
                        );
                      }),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
          )
        ]));
  }
}
