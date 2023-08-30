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
  TextEditingController nombre = TextEditingController();

  List<String> puestos = [];
  Map usuariosxPuesto = {};
  Map usuariosxPuestoName = {};
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataNombre = [];
  List<Map<String, dynamic>> dataNombrefilter = [];

  RxList<Votante> votanteAux = <Votante>[].obs;

  @override
  void initState() {
    super.initState();
    votanteAux.value = mainController.filterVotante;

    for (var element in votanteAux) {
      if (!puestos.contains(element.puestoID)) {
        puestos.add(element.puestoID);
      }
    }

    for (var puesto in puestos) {
      int cont = 0;
      List<Votante> listavVotantexPuestos = [];

      for (var element in votanteAux) {
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
    dataNombrefilter = dataNombre;

    mainController.update(['dropPuesto']);
  }

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: SizedBox(
            width: localwidth >= 800 ? localwidth * 0.2 : localwidth * 0.3,
            child: TextFormField(
              enabled: true,
              decoration: const InputDecoration(
                labelText: 'Buscar',
              ),
              controller: nombre,
              validator: (_) {
                if (_ == null || _.isEmpty) {
                  return "Debe llenar este campo";
                }

                if (_.length > 10) {
                  return "número no válido";
                }
                if (_.length < 7) {
                  return "número no válido";
                }
              },
              onChanged: (_) {
                if (_.isEmpty) {
                  dataNombrefilter = dataNombre;
                } else {
                  dataNombrefilter = dataNombre
                      .where((p0) =>
                          p0.toString().toLowerCase().contains(_.toLowerCase()))
                      .toList();
                }
                mainController.update(['dropPuesto']);
              },
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: localwidth * 0.1, vertical: 20),
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
        GetBuilder<MainController>(
            id: 'dropPuesto',
            builder: (state) {
              return Expanded(
                child: ListView.builder(
                    itemCount: dataNombrefilter.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: localwidth * 0.1,
                            right: localwidth * 0.07,
                            top: 5),
                        child: ListTile(
                          title: Text(dataNombrefilter[index]['domain']),
                          trailing: Text(
                              dataNombrefilter[index]['measure'].toString()),
                        ),
                      );
                    }),
              );
            })
      ],
    );
  }
}
