import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/model/votante.dart';

class ConsultarLideresScreen extends StatefulWidget {
  const ConsultarLideresScreen({super.key});

  @override
  State<ConsultarLideresScreen> createState() => ConsultarLideresScreenState();
}

MainController mainController = Get.find();

class ConsultarLideresScreenState extends State<ConsultarLideresScreen> {
  TextEditingController valueleader = TextEditingController();
  TextEditingController nombre = TextEditingController();

  RxList<Votante> filterVotanteLeader = <Votante>[].obs;
  RxList<Leader> leadersAux = <Leader>[].obs;

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    double fontSize = localwidth >= 800 ? 16 : 12;
    leadersAux.value = mainController.filterLeader;

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
                  leadersAux.value = mainController.filterLeader;
                } else {
                  leadersAux.value = mainController.filterLeader
                      .where((p0) => p0
                          .toJson()
                          .toString()
                          .toLowerCase()
                          .contains(_.toLowerCase()))
                      .toList();
                }
                mainController.update(['dropVotanteLeader']);
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
              Text(
                  localwidth >= 800
                      ? 'Nombre Lider o Responsable'
                      : 'Nombre Lider',
                  style: TextStyle(
                    fontSize: fontSize,
                  )),
              Text('Cantidad Registros', style: TextStyle(fontSize: fontSize)),
              Text('Opciones', style: TextStyle(fontSize: fontSize)),
            ],
          ),
        ),
        const Divider(
          color: Color(0xffff004e),
        ),
        GetBuilder<MainController>(
            id: 'dropVotanteLeader',
            builder: (state) {
              RxMap<String?, List<Votante>> aux = <String, List<Votante>>{}.obs;
              int cont = 0;

              for (Leader leader in leadersAux) {
                List<Votante> listVotantesAux = [];
                for (Votante votante in mainController.filterVotante) {
                  if (leader.id == votante.leaderID) {
                    listVotantesAux.add(votante);
                  }
                }
                aux[leader.id] = listVotantesAux.toList();

                cont = 0;
              }
              var sortedByValueMap = Map.fromEntries(aux.entries.toList()
                ..sort((a, b) => b.value.length.compareTo(a.value.length)));
              return Expanded(
                child: ListView.builder(
                    itemCount: sortedByValueMap.length,
                    itemBuilder: (_, index) {
                      List<Votante> leaderauxSI = [];
                      var leaderId = sortedByValueMap.keys.elementAt(index);
                      mainController.getEncuesta().forEach((element) {
                        if (element.leaderID == leaderId) {
                          leaderauxSI.add(element);
                        }
                      });
                      var leaderSicount = leaderauxSI.length.toString();

                      return Padding(
                        padding: EdgeInsets.only(
                            left: localwidth * 0.1,
                            right: localwidth * 0.07,
                            top: 5),
                        child: ListTile(
                          leading: Container(
                            width: localwidth * 0.13,
                            child: Text(
                              mainController.filterLeader
                                  .firstWhere((element) =>
                                      element.id ==
                                      sortedByValueMap.keys.elementAt(index))
                                  .name!,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          title: Text(
                            (sortedByValueMap[mainController.filterLeader
                                            .firstWhere((element) =>
                                                element.id ==
                                                sortedByValueMap.keys
                                                    .elementAt(index))
                                            .id!]
                                        ?.length ??
                                    0)
                                .toString(),
                            textAlign: TextAlign.center,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  filterVotanteLeader.value = sortedByValueMap[
                                      mainController.filterLeader
                                          .firstWhere((element) =>
                                              element.id ==
                                              sortedByValueMap.keys
                                                  .elementAt(index))
                                          .id!]!;
                                  Get.dialog(Container(
                                    margin: EdgeInsets.symmetric(
                                      vertical: Get.height * 0.2,
                                      horizontal: Get.width * 0.25,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: sortedByValueMap[mainController
                                                      .filterLeader
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          sortedByValueMap.keys
                                                              .elementAt(index))
                                                      .id!]
                                                  ?.isEmpty ??
                                              true
                                          ? const Center(
                                              child: Text("No hay datos"),
                                            )
                                          : Obx(() {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: TextField(
                                                      autofocus: true,
                                                      decoration:
                                                          const InputDecoration(
                                                              hintText:
                                                                  "Nombre de.."),
                                                      controller: valueleader,
                                                      onChanged: (_) {
                                                        filterVotanteLeader
                                                            .value = sortedByValueMap[mainController
                                                                .filterLeader
                                                                .firstWhere((element) =>
                                                                    element
                                                                        .id ==
                                                                    sortedByValueMap
                                                                        .keys
                                                                        .elementAt(
                                                                            index))
                                                                .id!]!
                                                            .where((element) =>
                                                                element.name
                                                                    .toLowerCase()
                                                                    .contains(_
                                                                        .toLowerCase()))
                                                            .toList();
                                                        state.update([
                                                          "dropVotanteLeader"
                                                        ]);
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 40),
                                                    child: Text(
                                                      'Total Respuestas SI: ${leaderSicount}',
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xffff004e)),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: ListView.builder(
                                                          itemCount:
                                                              filterVotanteLeader
                                                                  .length,
                                                          itemBuilder: (b,
                                                              indexVotantes) {
                                                            return ListTile(
                                                                title: Text(
                                                                  filterVotanteLeader[
                                                                          indexVotantes]
                                                                      .name,
                                                                ),
                                                                trailing:
                                                                    Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          30.0),
                                                                  child: filterVotanteLeader[indexVotantes]
                                                                              .encuesta ==
                                                                          true
                                                                      ? const Text(
                                                                          'Si')
                                                                      : filterVotanteLeader[indexVotantes].encuesta ==
                                                                              false
                                                                          ? const Text(
                                                                              'No')
                                                                          : filterVotanteLeader[indexVotantes].encuesta == null
                                                                              ? const Text('No contesto')
                                                                              : Text(
                                                                                  filterVotanteLeader[indexVotantes].encuesta,
                                                                                ),
                                                                ));
                                                          })),
                                                  Center(
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      style:
                                                          TextButton.styleFrom(
                                                        fixedSize:
                                                            const Size(120, 40),
                                                        backgroundColor:
                                                            const Color(
                                                                0xffff004e),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 20,
                                                          horizontal: 10,
                                                        ),
                                                      ),
                                                      child: const SizedBox(
                                                        width: 200,
                                                        child: Text(
                                                          'Cerrar',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              );
                                            }),
                                    ),
                                  ));
                                },
                                style: TextButton.styleFrom(
                                  fixedSize: const Size(50, 40),
                                  backgroundColor: const Color(0xffff004e),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 10,
                                  ),
                                ),
                                child: const SizedBox(
                                  child: Text(
                                    'Ver',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    _showloading();
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    await mainController.exportToExcel(
                                        sortedByValueMap[mainController
                                            .filterLeader
                                            .firstWhere((element) =>
                                                element.id ==
                                                sortedByValueMap.keys
                                                    .elementAt(index))
                                            .id!]!);
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.download)),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }),
      ],
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
