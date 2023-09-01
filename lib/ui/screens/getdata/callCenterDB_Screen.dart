import 'dart:js_interop';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:charts_painter/chart.dart';
import 'package:d_chart/d_chart.dart';
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

class CallCenterDBScreen extends StatefulWidget {
  const CallCenterDBScreen({super.key});

  @override
  State<CallCenterDBScreen> createState() => CallCenterDBScreenState();
}

class CallCenterDBScreenState extends State<CallCenterDBScreen> {
  final mainController = Get.find<MainController>();
  List<String> barrios = [];
  List<Barrio> comunas = [];
  TextEditingController nombre = TextEditingController();

  Map usuariosxBarrio = {};
  Map<String, List<Votante>> usuariosxComuna = {};
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataResp = [];
  List<Map<String, dynamic>> dataRespPor = [];

  List<Map<String, dynamic>> dataFilter = [];

  List<Map<String, dynamic>> dataComuna = [];
  List<Map<String, dynamic>> dataComunaaux = [];
  List<String> items = [
    'Si',
    'No',
    'Sin llamar',
    'No contesta',
    'Rechazado',
    'Llamar mas tarde',
    'Apagado',
    'Numero no activo',
    'Numero incorrecto'
  ];
  Map usuariosxResp = {};
  Map usuariosxRespPor = {};

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
    for (var resp in items) {
      int cont = 0;
      List<Votante> listavVotantexRespuesta = [];
      for (var element in mainController.filterVotante) {
        if (resp == element.encuesta) {
          cont++;
          listavVotantexRespuesta.add(element);
        }
      }
      usuariosxResp[resp] = listavVotantexRespuesta;
      usuariosxRespPor[resp] = double.parse((listavVotantexRespuesta.length /
              mainController.filterVotante.length *
              100)
          .toStringAsFixed(2));
    }
    var sortedMapRespPor = Map.fromEntries(usuariosxRespPor.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value)));

    var sortedMapResp = Map.fromEntries(usuariosxResp.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length)));
    sortedMapResp.forEach((key, value) {
      dataResp.add({'domain': key, 'measure': value.length});
    });
    // SplayTreeMap.from(
    //     usuariosxBarrio,
    //     (a, b) =>
    //         usuariosxBarrio[b].length.compareTo(usuariosxBarrio[a].length));

    sortedMapRespPor.forEach((key, value) {
      dataRespPor.add({'domain': key, 'measure': value});
    });
    for (var barrio in barrios) {
      int cont = 0;
      List<Votante> listavVotantexBarrios = [];
      for (var element in mainController.filterVotante) {
        if (barrio == element.barrio && element.encuesta == 'Si') {
          cont++;
          listavVotantexBarrios.add(element);
        }
      }

      // usuariosxBarrio[barrio] = cont;
      usuariosxBarrio[barrio] = listavVotantexBarrios;
    }
    var sortedMap = Map.fromEntries(usuariosxBarrio.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length)));
    // SplayTreeMap.from(
    //     usuariosxBarrio,
    //     (a, b) =>
    //         usuariosxBarrio[b].length.compareTo(usuariosxBarrio[a].length));

    sortedMap.forEach((key, value) {
      data.add({'domain': key, 'measure': value});
    });
    dataFilter = data;
    for (var dat in data) {
      List<Votante> listavVotantexComunas = [];
      for (var barriocomunas in comunas) {
        if (dat['domain'] == barriocomunas.barrio) {
          if (!usuariosxComuna.keys.contains(barriocomunas.comuna)) {
            usuariosxComuna[barriocomunas.comuna!] = <Votante>[];
            usuariosxComuna[barriocomunas.comuna]!.addAll(dat['measure']);
          } else {
            usuariosxComuna[barriocomunas.comuna]!.addAll(dat['measure']);
          }
        }
      }
    }
    usuariosxComuna.forEach((key, value) {
      dataComuna.add({'domain': 'C $key', 'measure': value});
    });
    dataComuna
        .sort((a, b) => b['measure'].length.compareTo(a['measure'].length));
    dataComuna.forEach((element) {
      dataComunaaux.add(
          {'domain': element['domain'], 'measure': element['measure'].length});
    });
  }

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    String colection =
        mainController.emailUser.split('@').last.split('.').first;

    return localwidth >= 800
        ? Padding(
            padding: EdgeInsets.symmetric(
                horizontal: localwidth * 0.1, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cantidad Respuestas SI por Barrio',
                        style: TextStyle(fontSize: 20),
                      ),
                      Column(
                        children: [
                          Text(
                              'Total Registros: ${mainController.filterVotante.length}'),
                          Text(
                              'Total Respuestas SI: ${mainController.getEncuesta().length}',
                              style: const TextStyle(color: Color(0xffff004e))),
                        ],
                      ),
                      const Text('Cantidad Respuestas SI por Comuna',
                          style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: SizedBox(
                    width:
                        localwidth >= 800 ? localwidth * 0.2 : localwidth * 0.3,
                    child: TextFormField(
                      enabled: true,
                      decoration: const InputDecoration(
                        labelText: 'Buscar Barrio',
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
                          dataFilter = data;
                        } else {
                          dataFilter = data
                              .where((p0) => p0
                                  .toString()
                                  .toLowerCase()
                                  .contains(_.toLowerCase()))
                              .toList();
                        }
                        mainController.update(['dropBarrios']);
                      },
                    ),
                  ),
                ),
                const Divider(
                  color: Color(0xffff004e),
                ),
                // mainController.emailUser.toLowerCase().contains('alcaldia') ||
                //         mainController.emailUser.toLowerCase().contains('consejo') ||
                //         colection.toLowerCase().contains('registro')
                //     ?

                Expanded(
                  child: Row(
                    children: [
                      GetBuilder<MainController>(
                          id: 'dropBarrios',
                          builder: (context) {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: dataFilter.length,
                                  itemBuilder: (_, index) {
                                    return ListTile(
                                      title: Text(dataFilter[index]['domain']),
                                      trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(dataFilter[index]['measure']
                                                .length
                                                .toString()),
                                            IconButton(
                                                onPressed: () async {
                                                  _showloading();
                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 1));
                                                  await mainController
                                                      .exportToExcel(
                                                          dataFilter[index]
                                                              ['measure']);
                                                  Get.back();
                                                },
                                                icon:
                                                    const Icon(Icons.download)),
                                          ]),
                                    );
                                  }),
                            );
                          }),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        child: DChartBar(
                          data: [
                            {'id': 'Bar', 'data': dataComunaaux},
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
                ),
                // : const SizedBox(),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          Get.dialog(Container(
                            margin: EdgeInsets.symmetric(
                              vertical: Get.height * 0.2,
                              horizontal: Get.width * 0.25,
                            ),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    const Text('Seleccionar Resultado'),
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: dataComuna.length,
                                            itemBuilder: (b, inx) {
                                              return ListTile(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                title: Text(
                                                    'Comuna ${dataComuna[inx]['domain']}'),
                                                trailing: IconButton(
                                                    onPressed: () async {
                                                      _showloading();
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 1));
                                                      await mainController
                                                          .exportToExcel(
                                                              dataComuna[inx]
                                                                  ['measure']);
                                                      Get.back();
                                                    },
                                                    icon: const Icon(
                                                        Icons.download)),
                                              );
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
                                          padding: const EdgeInsets.symmetric(
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
                                )),
                          ));
                        },
                        child: const Text('Descargar Registros por comuna')),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                GetBuilder<MainController>(
                    id: 'dropModal',
                    builder: (state) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.dialog(Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.2,
                                  horizontal: Get.width * 0.25,
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Respuestas Call Center',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: DChartPie(
                                                data: dataRespPor,
                                                fillColor: (pieData, index) {
                                                  if (index == 0) {
                                                    return Colors.green;
                                                  }
                                                  if (index == 1) {
                                                    return Colors.blue;
                                                  }
                                                  if (index == 2) {
                                                    return Colors.amber;
                                                  }
                                                  if (index == 3) {
                                                    return Colors.pink;
                                                  }
                                                  if (index == 4) {
                                                    return Colors.grey;
                                                  }
                                                  if (index == 5) {
                                                    return Colors.purple;
                                                  }
                                                  if (index == 6) {
                                                    return Colors.red;
                                                  }
                                                  if (index == 7) {
                                                    return Colors.orange;
                                                  }
                                                  if (index == 8) {
                                                    return Colors.cyan;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (int index = 0;
                                                    index < dataRespPor.length;
                                                    index++)
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 16,
                                                            height: 16,
                                                            color: index == 0
                                                                ? Colors.green
                                                                : index == 1
                                                                    ? Colors
                                                                        .blue
                                                                    : index == 2
                                                                        ? Colors
                                                                            .amber
                                                                        : index ==
                                                                                3
                                                                            ? Colors.pink
                                                                            : index == 4
                                                                                ? Colors.grey
                                                                                : index == 5
                                                                                    ? Colors.purple
                                                                                    : index == 6
                                                                                        ? Colors.red
                                                                                        : index == 7
                                                                                            ? Colors.orange
                                                                                            : Colors.cyan),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(index == 0
                                                            ? dataRespPor[index]
                                                                    ['domain'] +
                                                                " " +
                                                                dataResp[index][
                                                                        'measure']
                                                                    .toString()
                                                            : index == 1
                                                                ? dataRespPor[index]
                                                                        [
                                                                        'domain'] +
                                                                    " " +
                                                                    dataResp[index]
                                                                            [
                                                                            'measure']
                                                                        .toString()
                                                                : index == 2
                                                                    ? dataRespPor[index]
                                                                            [
                                                                            'domain'] +
                                                                        " " +
                                                                        dataResp[index]['measure']
                                                                            .toString()
                                                                    : index == 3
                                                                        ? dataRespPor[index]['domain'] +
                                                                            " " +
                                                                            dataResp[index]['measure'].toString()
                                                                        : index == 4
                                                                            ? dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()
                                                                            : index == 5
                                                                                ? dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()
                                                                                : index == 6
                                                                                    ? dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()
                                                                                    : index == 7
                                                                                        ? dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()
                                                                                        : dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )));
                          },
                          child: const Text('Ver Total Call Center'),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(
                horizontal: localwidth * 0.1, vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                      'Total Registros: ${mainController.filterVotante.length}'),
                ),
                const Divider(
                  color: Color(0xffff004e),
                ),
                // mainController.emailUser.toLowerCase().contains('alcaldia') ||
                //         mainController.emailUser.toLowerCase().contains('consejo') ||
                //         colection.toLowerCase().contains('registro')
                //     ?

                Expanded(
                  child: Column(
                    children: [
                      const Text(
                        'Cantidad Registros por Barrio',
                        style: TextStyle(fontSize: 16),
                      ),
                      GetBuilder<MainController>(
                          id: 'dropBarrios',
                          builder: (context) {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: dataFilter.length,
                                  itemBuilder: (_, index) {
                                    return ListTile(
                                      title: Text(dataFilter[index]['domain']),
                                      trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(dataFilter[index]['measure']
                                                .length
                                                .toString()),
                                            IconButton(
                                                onPressed: () async {
                                                  _showloading();
                                                  await Future.delayed(
                                                      const Duration(
                                                          seconds: 1));
                                                  await mainController
                                                      .exportToExcel(
                                                          dataFilter[index]
                                                              ['measure']);
                                                  Get.back();
                                                },
                                                icon:
                                                    const Icon(Icons.download)),
                                          ]),
                                    );
                                  }),
                            );
                          }),
                      const SizedBox(
                        width: 50,
                      ),
                      const Text('Cantidad Registros por Comuna',
                          style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: DChartBar(
                          data: [
                            {'id': 'Bar', 'data': dataComunaaux},
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
                      TextButton(
                          onPressed: () {
                            Get.dialog(Container(
                              margin: EdgeInsets.symmetric(
                                vertical: Get.height * 0.2,
                                horizontal: Get.width * 0.25,
                              ),
                              child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      const Text('Seleccionar Resultado'),
                                      Expanded(
                                          child: ListView.builder(
                                              itemCount: dataComuna.length,
                                              itemBuilder: (b, inx) {
                                                return ListTile(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  title: Text(
                                                      'Comuna ${dataComuna[inx]['domain']}'),
                                                  trailing: IconButton(
                                                      onPressed: () async {
                                                        _showloading();
                                                        await Future.delayed(
                                                            const Duration(
                                                                seconds: 1));
                                                        await mainController
                                                            .exportToExcel(
                                                                dataComuna[inx][
                                                                    'measure']);
                                                        Get.back();
                                                      },
                                                      icon: const Icon(
                                                          Icons.download)),
                                                );
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
                                            padding: const EdgeInsets.symmetric(
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
                                  )),
                            ));
                          },
                          child: const Text('Descargar Registros por comuna')),
                    ],
                  ),
                ),
                // : const SizedBox(),
                const Row(
                  children: [
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                GetBuilder<MainController>(
                    id: 'dropModal',
                    builder: (state) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Get.dialog(Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.2,
                                  horizontal: Get.width * 0.25,
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        'Respuestas Call Center',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: DChartPie(
                                                data: dataRespPor,
                                                fillColor: (pieData, index) {
                                                  if (index == 0) {
                                                    return Colors.green;
                                                  }
                                                  if (index == 1) {
                                                    return Colors.blue;
                                                  }
                                                  if (index == 2) {
                                                    return Colors.amber;
                                                  }
                                                  if (index == 3) {
                                                    return Colors.pink;
                                                  }
                                                  if (index == 4) {
                                                    return Colors.grey;
                                                  }
                                                  if (index == 5) {
                                                    return Colors.purple;
                                                  }
                                                  if (index == 6) {
                                                    return Colors.red;
                                                  }
                                                  if (index == 7) {
                                                    return Colors.orange;
                                                  }
                                                  if (index == 8) {
                                                    return Colors.cyan;
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                for (int index = 0;
                                                    index < dataRespPor.length;
                                                    index++)
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 4),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                            width: 16,
                                                            height: 16,
                                                            color: index == 0
                                                                ? Colors.green
                                                                : index == 1
                                                                    ? Colors
                                                                        .blue
                                                                    : index == 2
                                                                        ? Colors
                                                                            .amber
                                                                        : index ==
                                                                                3
                                                                            ? Colors.pink
                                                                            : index == 4
                                                                                ? Colors.grey
                                                                                : index == 5
                                                                                    ? Colors.purple
                                                                                    : index == 6
                                                                                        ? Colors.red
                                                                                        : index == 7
                                                                                            ? Colors.orange
                                                                                            : Colors.cyan),
                                                        const SizedBox(
                                                            width: 8),
                                                        Text(index == 0
                                                            ? dataRespPor[index]
                                                                    ['domain'] +
                                                                " " +
                                                                dataResp[index][
                                                                        'measure']
                                                                    .toString()
                                                            : index == 1
                                                                ? dataRespPor[index]
                                                                        [
                                                                        'domain'] +
                                                                    " " +
                                                                    dataResp[index]
                                                                            [
                                                                            'measure']
                                                                        .toString()
                                                                : index == 2
                                                                    ? dataRespPor[index]
                                                                            [
                                                                            'domain'] +
                                                                        " " +
                                                                        dataResp[index]['measure']
                                                                            .toString()
                                                                    : index == 3
                                                                        ? dataRespPor[index]['domain'] +
                                                                            " " +
                                                                            dataResp[index]['measure'].toString()
                                                                        : index == 4
                                                                            ? dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()
                                                                            : index == 5
                                                                                ? dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()
                                                                                : index == 6
                                                                                    ? dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()
                                                                                    : index == 7
                                                                                        ? dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()
                                                                                        : dataRespPor[index]['domain'] + " " + dataResp[index]['measure'].toString()),
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )));
                          },
                          child: const Text('Ver Total Call Center'),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
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
