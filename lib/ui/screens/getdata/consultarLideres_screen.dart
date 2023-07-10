import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/model/votante.dart';

class ConsultarLideresScreen extends StatefulWidget {
  const ConsultarLideresScreen({super.key});

  @override
  State<ConsultarLideresScreen> createState() => ConsultarLideresScreenState();
}

MainController mainController = Get.find();

class ConsultarLideresScreenState extends State<ConsultarLideresScreen> {
  TextEditingController valueleader = TextEditingController();
  RxList<Votante> filterVotanteLeader = <Votante>[].obs;
  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    double fontSize = localwidth >= 800 ? 16 : 12;
    return Column(
      children: [
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

              for (Leader leader in mainController.filterLeader) {
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
              print(sortedByValueMap);
              return Expanded(
                child: ListView.builder(
                    itemCount: sortedByValueMap.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: localwidth * 0.1, vertical: 20),
                        child: ListTile(
                          leading: Container(
                            width: localwidth * 0.2,
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
                          trailing: TextButton(
                            onPressed: () {
                              filterVotanteLeader.value = sortedByValueMap[
                                  mainController.filterLeader[index].id!]!;
                              Get.dialog(Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: Get.height * 0.2,
                                  horizontal: Get.width * 0.25,
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: sortedByValueMap[mainController
                                                  .filterLeader[index].id!]
                                              ?.isEmpty ??
                                          true
                                      ? const Center(
                                          child: Text("No hay datos"),
                                        )
                                      : Obx(() {
                                          return Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: TextField(
                                                  autofocus: true,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Nombre de.."),
                                                  controller: valueleader,
                                                  onChanged: (_) {
                                                    filterVotanteLeader
                                                        .value = sortedByValueMap[
                                                            mainController
                                                                .filterLeader[
                                                                    index]
                                                                .id!]!
                                                        .where((element) => element
                                                            .name
                                                            .toLowerCase()
                                                            .contains(_
                                                                .toLowerCase()))
                                                        .toList();
                                                    state.update(
                                                        ["dropVotanteLeader"]);
                                                  },
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                  'Seleccionar Resultado'),
                                              Expanded(
                                                  child: ListView.builder(
                                                      itemCount:
                                                          filterVotanteLeader
                                                              .length,
                                                      itemBuilder:
                                                          (b, indexVotantes) {
                                                        return ListTile(
                                                            title: Text(
                                                          filterVotanteLeader[
                                                                  indexVotantes]
                                                              .name,
                                                        ));
                                                      })),
                                              Center(
                                                child: TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  style: TextButton.styleFrom(
                                                    fixedSize:
                                                        const Size(120, 40),
                                                    backgroundColor:
                                                        const Color(0xffff004e),
                                                    padding: const EdgeInsets
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
                        ),
                      );
                    }),
              );
            }),
      ],
    );
  }
}
