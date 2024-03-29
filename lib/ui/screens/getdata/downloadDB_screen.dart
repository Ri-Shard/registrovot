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
  TextEditingController nombre = TextEditingController();

  Map usuariosxBarrio = {};
  Map<String, List<Votante>> usuariosxComuna = {};
  List<Map<String, dynamic>> data = [];
  List<Map<String, dynamic>> dataFilter = [];

  List<Map<String, dynamic>> dataComuna = [];
  List<Map<String, dynamic>> dataComunaaux = [];

  StaticFields staticFields = StaticFields();
  @override
  void initState() {
    super.initState();

    if (mainController.emailUser.contains('edil')) {
      for (var barr in staticFields.getBarriosCarta()) {
        comunas.add(barr);
      }
    } else {
      for (var barr in staticFields.getBarrios()) {
        comunas.add(barr);
      }
    }
    for (var element in mainController.filterVotante) {
      if (!barrios.contains(element.barrio)) {
        barrios.add(element.barrio ?? '-');
      }
    }
    for (var barrio in barrios) {
      int cont = 0;
      List<Votante> listavVotantexBarrios = [];
      for (var element in mainController.filterVotante) {
        if (barrio == element.barrio) {
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
                        'Cantidad Registros por Barrio',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                          'Total Registros: ${mainController.filterVotante.length}'),
                      const Text('Cantidad Registros por Comuna',
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
                    Spacer(),
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
                        child: Text('Descargar Registros por comuna')),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      _showloading();
                      await Future.delayed(const Duration(seconds: 1));
                      await mainController
                          .exportToExcel(mainController.filterVotante);
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
                          child: Text('Descargar Registros por comuna')),
                    ],
                  ),
                ),
                // : const SizedBox(),
                Row(
                  children: [
                    Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      _showloading();
                      await Future.delayed(const Duration(seconds: 1));
                      await mainController
                          .exportToExcel(mainController.filterVotante);
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
