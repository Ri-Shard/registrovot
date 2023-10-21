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
import '../../../model/leader.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => RoutesScreenState();
}

class RoutesScreenState extends State<RoutesScreen> {
  MainController mainController = Get.find();
  TextEditingController nombre = TextEditingController();
  TextEditingController valueleader = TextEditingController();

  List<String> puestos = [];
  Map usuariosxPuesto = {};
  Map usuariosxPuestoName = {};

  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataNombre = [];
  List<Map<String, dynamic>> dataNombrefilter = [];
  List<Map<String, dynamic>> dataLeaderPuesto = [];

  RxList<Votante> votanteAux = <Votante>[].obs;
  RxList<Votante> filterRoutes = <Votante>[].obs;
  RxList<Leader> leadersAux = <Leader>[].obs;

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
      // Map leaderxPuesto = {};
      Map<String, dynamic> leaderxPuesto = {};
      for (var vot in value) {
        if (vot.leaderID != '0000000') {
          if (!leaderxPuesto.containsKey(vot.leaderID)) {
            leaderxPuesto[vot.leaderID] = [];
          }

          leaderxPuesto[vot.leaderID].add(vot.leaderID);
        }
      }
      dataNombre.add(
          {'domain': key, 'measure': value.length, 'leader': leaderxPuesto});
    });
    // dataNombre.sort((a, b) => b['measure'].compareTo(a['measure']));
    dataNombrefilter = dataNombre;

    mainController.update(['dropPuesto']);
  }

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    double fontSize = localwidth >= 800 ? 16 : 12;
    leadersAux.value = mainController.filterLeader;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          .where((p0) => p0
                              .toString()
                              .toLowerCase()
                              .contains(_.toLowerCase()))
                          .toList();
                    }
                    mainController.update(['dropPuestoRoute']);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 50),
              child: Text(
                  'Total Registros: ${mainController.filterVotante.length}'),
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: localwidth * 0.1, vertical: 20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Puesto de Votacion',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Cantidad de Votos',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Cantidad de Lideres',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Estimado transporte',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        const Divider(
          color: Color(0xffff004e),
        ),
        GetBuilder<MainController>(
            id: 'dropPuestoRoute',
            builder: (state) {
              return Expanded(
                child: ListView.builder(
                    itemCount: dataNombrefilter.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: localwidth * 0.1,
                          top: 10,
                          bottom: 10,
                          right: localwidth * 0.03,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: localwidth * 0.13,
                              child: Text(dataNombrefilter[index]['domain'],
                                  textAlign: TextAlign.start),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: localwidth * 0.02,
                              ),
                              child: Text(
                                  dataNombrefilter[index]['measure'].toString(),
                                  textAlign: TextAlign.start),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: localwidth * 0.11,
                              ),
                              child: Text(
                                  dataNombrefilter[index]['leader']
                                      .length
                                      .toString(),
                                  textAlign: TextAlign.start),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: localwidth * 0.13,
                              ),
                              child: dataNombrefilter[index]['measure'] / 20 < 1
                                  ? const Text('1', textAlign: TextAlign.start)
                                  : Text(
                                      '${(dataNombrefilter[index]['measure'] / 20).toInt()}',
                                      textAlign: TextAlign.end),
                            ),
                            TextButton(
                                onPressed: () {
                                  var listaLeaders = {};
                                  for (var element in dataNombrefilter[index]
                                          ['leader']
                                      .values) {
                                    final leader =
                                        searchNameLeader(element[0])!.name!;
                                    final leaderLength = element.length;

                                    listaLeaders[leader] = leaderLength;
                                  }

                                  Get.dialog(Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: Get.height * 0.2,
                                      horizontal: Get.width * 0.25,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50.0, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('Nombre Lider',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text('Cantidad de votos',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text('Estimado',
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            color: Color(0xffff004e),
                                          ),
                                          Expanded(
                                              child: ListView.builder(
                                                  itemCount:
                                                      listaLeaders.length,
                                                  itemBuilder:
                                                      (b, indexVotantes) {
                                                    final leader = listaLeaders
                                                        .keys
                                                        .elementAt(
                                                            indexVotantes);
                                                    final leaderLength =
                                                        listaLeaders.values
                                                            .elementAt(
                                                                indexVotantes);

                                                    return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10,
                                                                horizontal:
                                                                    50.0),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  localwidth *
                                                                      0.13,
                                                              child: Text(
                                                                leader,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                right:
                                                                    localwidth *
                                                                        0.1,
                                                              ),
                                                              child: Text(
                                                                  leaderLength
                                                                      .toString(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                right:
                                                                    localwidth *
                                                                        0.02,
                                                              ),
                                                              child: leaderLength /
                                                                          20 <
                                                                      1
                                                                  ? const Text(
                                                                      '1',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start)
                                                                  : Text(
                                                                      '${(leaderLength / 20).toInt()}',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start),
                                                            ),
                                                          ],
                                                        ));
                                                  })),
                                          Center(
                                            child: TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              style: TextButton.styleFrom(
                                                fixedSize: const Size(120, 40),
                                                backgroundColor:
                                                    const Color(0xffff004e),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 20,
                                                  horizontal: 10,
                                                ),
                                              ),
                                              child: const SizedBox(
                                                width: 200,
                                                child: Text(
                                                  'Cerrar',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ));
                                },
                                child: const Text('ver info Lider'))
                          ],
                        ),
                      );
                    }),
              );
            })
      ],
    );

    // return const Center(child: Text('Routes Screen'));
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

Leader? searchNameLeader(String leaderID) {
  Leader? leader;
  mainController.filterLeader.forEach((element) {
    if (element.id == leaderID) {
      leader = element;
    }
  });
  return leader;
}
