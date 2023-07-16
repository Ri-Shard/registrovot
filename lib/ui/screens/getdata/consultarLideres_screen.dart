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
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
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
                                                  const Text(
                                                      'Seleccionar Resultado'),
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
                                    await exportToExcel(sortedByValueMap[
                                        mainController.filterLeader
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

  Future<void> exportToExcel(List<Votante> listVot) async {
    try {
      final excel = Excel.createExcel();
      final Sheet sheet = excel[excel.getDefaultSheet()!];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = 'Cedula';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
          .value = 'Nombre';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
          .value = 'Telefono';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          .value = 'Edad';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
          .value = 'Municipio';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
          .value = 'Barrio';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0))
          .value = 'Direccion';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0))
          .value = 'Lider';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0))
          .value = 'Encuesta';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0))
          .value = 'Puesto de Votacion';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0))
          .value = 'Estado';

      for (var row = 0; row < listVot.length; row++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
            .value = listVot[row].id;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
            .value = listVot[row].name;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
            .value = listVot[row].phone;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1))
            .value = listVot[row].edad;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1))
            .value = listVot[row].municipio;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1))
            .value = listVot[row].barrio;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row + 1))
            .value = listVot[row].direccion;
        Leader? leader = mainController.getoneLeader(listVot[row].leaderID);
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row + 1))
            .value = leader?.name ?? '';
        String? encuesta;
        if (listVot[row].encuesta == true) {
          encuesta = 'Si';
        } else {
          encuesta = (listVot[row].encuesta == false ? 'No' : 'No responde');
        }

        if (listVot[row].encuesta == true ||
            listVot[row].encuesta == false ||
            listVot[row].encuesta == null) {
          if (listVot[row].encuesta == true) {
            encuesta = 'Si';
          } else {
            encuesta = (listVot[row].encuesta == false ? 'No' : 'No contesto');
          }
        } else {
          if (listVot[row].encuesta == 'Si') {
            encuesta = 'Si';
          } else if (listVot[row].encuesta == 'No') {
            encuesta = 'No';
          } else if (listVot[row].encuesta == 'No contesto') {
            encuesta = 'No contesto';
          } else if (listVot[row].encuesta == 'Apagado') {
            encuesta = 'Apagado';
          } else if (listVot[row].encuesta == 'Numero no activo') {
            encuesta = 'Numero no activo';
          } else if (listVot[row].encuesta == 'Numero incorrecto') {
            encuesta = 'Numero incorrecto';
          }
        }
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row + 1))
            .value = encuesta;
        Puesto? puesto = mainController.getonePuesto(listVot[row].puestoID);
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row + 1))
            .value = puesto?.nombre ?? '';
        sheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row + 1))
            .value = listVot[row].estado;
      }

      excel.save(fileName: "ReporteDataBase.xlsx");
    } catch (e) {
      Get.back();
      AwesomeDialog(
              width: 566,
              context: context,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              headerAnimationLoop: false,
              title: 'Error',
              desc: 'Ocurrio un error al generar el archivo $e',
              btnOkOnPress: () {},
              btnOkIcon: Icons.cancel,
              btnOkColor: const Color(0xff01b9ff))
          .show();
    }
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
