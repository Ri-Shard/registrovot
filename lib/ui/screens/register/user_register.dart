// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/model/votante.dart';
import 'package:registrovot/ui/common/staticsFields.dart';

import '../../common/custom_textfield.dart';

class UserRegister extends StatefulWidget {
  UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  TextEditingController cedula = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController edad = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController municipioTextEditingController =
      TextEditingController();
  TextEditingController barrioTextEditingController = TextEditingController();
  TextEditingController liderTextEditingController = TextEditingController();
  TextEditingController puestoTextEditingController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  List<Leader> aux = [];
  List<String> leadersname = [];
  List<String> puestoname = [];
  List<Puesto> filterPuestoPre = [];

  RxList<Votante> searchvotante = <Votante>[].obs;
  RxList<Leader> filterLeader = <Leader>[].obs;
  RxList<Municipio> filterMunicipio = <Municipio>[].obs;
  RxList<Barrio> filterBarrio = <Barrio>[].obs;
  RxList<Puesto> filterPuesto = <Puesto>[].obs;
  RxList<Puesto> filterPuestoSearch = <Puesto>[].obs;

  MainController mainController = Get.find();
  StaticFields staticfields = StaticFields();

  RxBool haspuesto = false.obs;
  bool enable = false;
  bool update = false;
  bool hasalcaldia = false;
  String? valueIDleader;
  Leader? valueLeader2;
  Puesto? valuePuesto2;
  TextEditingController valuemunicipio = TextEditingController();
  TextEditingController valuebarrio = TextEditingController();
  TextEditingController valueleader = TextEditingController();
  TextEditingController valuepuesto = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String colection =
        mainController.emailUser.split('@').last.split('.').first;
    valuemunicipio.text =
        mainController.emailUser.toLowerCase().contains('alcaldia') ||
                mainController.emailUser.toLowerCase().contains('consejo') ||
                colection.toLowerCase().contains('registro')
            ? 'Valledupar'
            : '';
    filterPuestoPre.clear();
    for (var i = 0; i < mainController.filterPuesto.length; i++) {
      filterPuestoPre.add(mainController.filterPuesto[i]);
    }
    filterPuesto.clear();
    for (var i = 0; i < filterPuestoPre.length; i++) {
      if (filterPuestoPre[i].municipio!.toLowerCase() ==
          valuemunicipio.text.toLowerCase()) {
        filterPuesto.add(filterPuestoPre[i]);
      }
    }
    filterPuestoSearch.clear();
    for (var element in filterPuesto) {
      filterPuestoSearch.add(element);
    }
    double localwidth = MediaQuery.of(context).size.width;
    double localHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: localwidth * 0.1, vertical: 20),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: localwidth >= 800
                          ? localwidth * 0.24
                          : localwidth * 0.67,
                      child: Container(
                        child: GetBuilder<MainController>(
                            id: 'dropCedulaView',
                            builder: (state) {
                              return InkWell(
                                onTap: () {
                                  hasalcaldia = true;
                                  filterPuestoPre.clear();
                                  for (var i = 0;
                                      i < mainController.filterPuesto.length;
                                      i++) {
                                    filterPuestoPre
                                        .add(mainController.filterPuesto[i]);
                                  }
                                  filterPuesto.clear();
                                  for (var i = 0;
                                      i < filterPuestoPre.length;
                                      i++) {
                                    if (filterPuestoPre[i]
                                            .municipio!
                                            .toLowerCase() ==
                                        valuemunicipio.text.toLowerCase()) {
                                      filterPuesto.add(filterPuestoPre[i]);
                                    }
                                  }
                                  filterPuestoSearch.clear();
                                  for (var element in filterPuesto) {
                                    filterPuestoSearch.add(element);
                                  }
                                  // searchvotante.clear();
                                  searchvotante.value =
                                      mainController.filterVotante.value;
                                  Get.dialog(
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: localHeigth * 0.2,
                                          horizontal: localwidth * 0.1,
                                        ),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Obx(() {
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
                                                    controller: cedula,
                                                    onChanged: (_) {
                                                      searchvotante.value =
                                                          mainController
                                                              .filterVotante
                                                              .where((element) => element
                                                                  .toJson()
                                                                  .toString()
                                                                  .toLowerCase()
                                                                  .contains(_
                                                                      .toLowerCase()))
                                                              .toList();
                                                      state.update(
                                                          ["dropCedulaView"]);
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                const Text(
                                                    'Seleccionar Resultado'),
                                                Expanded(
                                                    child: ListView.builder(
                                                        itemCount: (searchvotante
                                                                    .isEmpty &&
                                                                cedula.text
                                                                    .isNum &&
                                                                cedula.text
                                                                        .length >=
                                                                    6 &&
                                                                cedula.text
                                                                        .length <=
                                                                    11)
                                                            ? 1
                                                            : searchvotante
                                                                .length,
                                                        itemBuilder:
                                                            (b, index) {
                                                          if (searchvotante
                                                                  .isEmpty &&
                                                              cedula
                                                                  .text.isNum &&
                                                              cedula.text
                                                                      .length >=
                                                                  6) {
                                                            return Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top: 20),
                                                                  width: 200,
                                                                  child:
                                                                      TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      setState(
                                                                          () {
                                                                        update =
                                                                            false;
                                                                        enable =
                                                                            true;
                                                                        filterBarrio.value =
                                                                            staticfields.getBarrios();
                                                                        filterMunicipio.value =
                                                                            staticfields.getMunicipios();
                                                                        nombre
                                                                            .clear();
                                                                        telefono
                                                                            .clear();
                                                                        direccion
                                                                            .clear();
                                                                        edad.clear();
                                                                        valuebarrio
                                                                            .clear();
                                                                        valueleader
                                                                            .clear();
                                                                        valuemunicipio
                                                                            .clear();
                                                                        valuepuesto
                                                                            .clear();
                                                                        Get.back();
                                                                      });
                                                                    },
                                                                    style: TextButton
                                                                        .styleFrom(
                                                                      fixedSize:
                                                                          const Size(
                                                                              120,
                                                                              40),
                                                                      backgroundColor:
                                                                          const Color(
                                                                              0xffff004e),
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        vertical:
                                                                            20,
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        const SizedBox(
                                                                      width:
                                                                          200,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'Agregar',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }
                                                          return ListTile(
                                                            onTap: () {
                                                              filterLeader
                                                                  .clear();
                                                              for (var i = 0;
                                                                  i <
                                                                      mainController
                                                                          .filterLeader
                                                                          .length;
                                                                  i++) {
                                                                filterLeader.add(
                                                                    mainController
                                                                        .filterLeader[i]);
                                                              }
                                                              cedula.text =
                                                                  searchvotante[
                                                                          index]
                                                                      .id;
                                                              // valueLeader2 = filterMunicipio[index];
                                                              state.update([
                                                                "dropCedulaView"
                                                              ]);
                                                              setState(() {
                                                                enable = true;
                                                                update = true;

                                                                nombre.text =
                                                                    searchvotante[
                                                                            index]
                                                                        .name;
                                                                cedula.text =
                                                                    searchvotante[
                                                                            index]
                                                                        .id;
                                                                valuemunicipio
                                                                        .text =
                                                                    searchvotante[
                                                                            index]
                                                                        .municipio;
                                                                filterBarrio
                                                                        .value =
                                                                    staticfields
                                                                        .getBarrios();
                                                                filterMunicipio
                                                                        .value =
                                                                    staticfields
                                                                        .getMunicipios();
                                                                valueleader.text = filterLeader
                                                                    .firstWhere((element) =>
                                                                        element
                                                                            .id ==
                                                                        searchvotante[index]
                                                                            .leaderID)
                                                                    .name
                                                                    .toString();
                                                                valueLeader2 = filterLeader.firstWhere((element) =>
                                                                    element
                                                                        .id ==
                                                                    searchvotante[
                                                                            index]
                                                                        .leaderID);
                                                                valuepuesto.text = filterPuestoPre
                                                                    .firstWhere((element) =>
                                                                        element
                                                                            .id ==
                                                                        searchvotante[index]
                                                                            .puestoID)
                                                                    .nombre
                                                                    .toString();
                                                                valuePuesto2 = filterPuestoPre.firstWhere((element) =>
                                                                    element
                                                                        .id ==
                                                                    searchvotante[
                                                                            index]
                                                                        .puestoID);

                                                                telefono.text =
                                                                    searchvotante[
                                                                            index]
                                                                        .phone;
                                                                direccion.text =
                                                                    searchvotante[
                                                                            index]
                                                                        .direccion;
                                                                edad.text =
                                                                    searchvotante[
                                                                            index]
                                                                        .edad;
                                                                if (searchvotante[
                                                                            index]
                                                                        .municipio !=
                                                                    'Valledupar') {
                                                                  valuebarrio
                                                                      .clear();
                                                                } else {
                                                                  valuebarrio
                                                                      .text = searchvotante[
                                                                          index]
                                                                      .barrio!;
                                                                }
                                                              });
                                                              Get.back();
                                                            },
                                                            title: Text(
                                                                "${searchvotante[index].id} ${searchvotante[index].name}"),
                                                          );
                                                        })),
                                                Center(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      cedula.clear();
                                                      Get.back();
                                                    },
                                                    style: TextButton.styleFrom(
                                                      fixedSize:
                                                          const Size(120, 40),
                                                      backgroundColor:
                                                          const Color(
                                                              0xffff004e),
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 20,
                                                        horizontal: 10,
                                                      ),
                                                    ),
                                                    child: SizedBox(
                                                      width: localwidth * 0.5,
                                                      child: const Text(
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
                                      ),
                                      barrierDismissible: false);
                                },
                                child: TextFormField(
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    labelText: 'Cedula',
                                  ),
                                  keyboardType: TextInputType.number,
                                  controller: cedula,
                                  validator: (_) {
                                    if (_ == null || _.isEmpty) {
                                      return "Debe llenar este campo";
                                    }

                                    if (_.length >= 11) {
                                      return "número no válido";
                                    }
                                    if (_.length < 6) {
                                      return "número no válido";
                                    }
                                  },
                                  onChanged: (_) {},
                                ),
                              );
                            }),
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Visibility(
                visible: enable,
                child: Row(
                  children: [
                    const Text(
                      'Municipio',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    SizedBox(
                        width: localwidth >= 800
                            ? localwidth * 0.2
                            : localwidth * 0.5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.transparent,
                          child: GetBuilder<MainController>(
                              id: "dropMunicipioView",
                              builder: (state) {
                                return OutlinedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                    width: 2.0,
                                                    style:
                                                        BorderStyle.solid)))),
                                    onPressed:
                                        mainController.emailUser
                                                    .toLowerCase()
                                                    .contains('alcaldia') ||
                                                mainController.emailUser
                                                    .toLowerCase()
                                                    .contains('consejo') ||
                                                colection
                                                    .toLowerCase()
                                                    .contains('registro')
                                            ? null
                                            : () {
                                                // state.searchDomi("");
                                                Get.dialog(Container(
                                                  margin: EdgeInsets.symmetric(
                                                    vertical: Get.height * 0.2,
                                                    horizontal:
                                                        Get.width * 0.25,
                                                  ),
                                                  child: Card(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    child:
                                                        filterMunicipio.isEmpty
                                                            ? const Center(
                                                                child: Text(
                                                                    "No hay datos"),
                                                              )
                                                            : Obx(() {
                                                                return Column(
                                                                  children: [
                                                                    Container(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              20),
                                                                      child:
                                                                          TextField(
                                                                        autofocus:
                                                                            true,
                                                                        decoration:
                                                                            const InputDecoration(hintText: "Nombre de.."),
                                                                        controller:
                                                                            valuemunicipio,
                                                                        onChanged:
                                                                            (_) {
                                                                          filterMunicipio.value = staticfields
                                                                              .getMunicipios()
                                                                              .where((element) => element.nombre!.toLowerCase().contains(_.toLowerCase()))
                                                                              .toList();
                                                                          state
                                                                              .update([
                                                                            "dropMunicipioView"
                                                                          ]);
                                                                        },
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    const Text(
                                                                        'Seleccionar Resultado'),
                                                                    Expanded(
                                                                        child: ListView.builder(
                                                                            itemCount: filterMunicipio.length,
                                                                            itemBuilder: (b, index) {
                                                                              return ListTile(
                                                                                onTap: () {
                                                                                  valuemunicipio.text = filterMunicipio[index].nombre ?? "-";
                                                                                  // valueLeader2 = filterMunicipio[index];
                                                                                  filterPuestoPre.clear();
                                                                                  for (var i = 0; i < mainController.filterPuesto.length; i++) {
                                                                                    filterPuestoPre.add(mainController.filterPuesto[i]);
                                                                                  }
                                                                                  filterPuesto.clear();
                                                                                  for (var i = 0; i < filterPuestoPre.length; i++) {
                                                                                    if (filterPuestoPre[i].municipio!.toLowerCase() == valuemunicipio.text.toLowerCase()) {
                                                                                      filterPuesto.add(filterPuestoPre[i]);
                                                                                    }
                                                                                  }
                                                                                  filterPuestoSearch.clear();
                                                                                  for (var element in filterPuesto) {
                                                                                    filterPuestoSearch.add(element);
                                                                                  }

                                                                                  state.update([
                                                                                    "dropMunicipioView"
                                                                                  ]);
                                                                                  valuepuesto.clear();
                                                                                  haspuesto.value = true;
                                                                                  Get.back();
                                                                                },
                                                                                title: Text(filterMunicipio[index].nombre ?? "-"),
                                                                              );
                                                                            })),
                                                                    Center(
                                                                      child:
                                                                          TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Get.back();
                                                                        },
                                                                        style: TextButton
                                                                            .styleFrom(
                                                                          fixedSize: const Size(
                                                                              120,
                                                                              40),
                                                                          backgroundColor:
                                                                              const Color(0xffff004e),
                                                                          padding:
                                                                              const EdgeInsets.symmetric(
                                                                            vertical:
                                                                                20,
                                                                            horizontal:
                                                                                10,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            const SizedBox(
                                                                          width:
                                                                              200,
                                                                          child:
                                                                              Text(
                                                                            'Cerrar',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 15,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    )
                                                                  ],
                                                                );
                                                              }),
                                                  ),
                                                ));
                                              },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Text(
                                          valuemunicipio.text,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )));
                              }),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              valuemunicipio.text == 'Valledupar' && hasalcaldia
                  ? Row(
                      children: [
                        const Text(
                          'Barrio',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        SizedBox(
                            width: localwidth >= 800
                                ? localwidth * 0.2
                                : localwidth * 0.5,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.transparent,
                              child: GetBuilder<MainController>(
                                  id: "dropBarrioView",
                                  builder: (state) {
                                    return OutlinedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: const BorderSide(
                                                        width: 2.0,
                                                        style: BorderStyle
                                                            .solid)))),
                                        onPressed: () {
                                          // state.searchDomi("");
                                          Get.dialog(Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: Get.height * 0.2,
                                              horizontal: Get.width * 0.25,
                                            ),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: filterBarrio.isEmpty
                                                  ? const Center(
                                                      child:
                                                          Text("No hay datos"),
                                                    )
                                                  : Obx(() {
                                                      return Column(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: TextField(
                                                              autofocus: true,
                                                              decoration:
                                                                  const InputDecoration(
                                                                      hintText:
                                                                          "Nombre de.."),
                                                              controller:
                                                                  valuebarrio,
                                                              onChanged: (_) {
                                                                filterBarrio.value = staticfields
                                                                    .getBarrios()
                                                                    .where((element) => element
                                                                        .barrio!
                                                                        .toLowerCase()
                                                                        .contains(
                                                                            _.toLowerCase()))
                                                                    .toList();
                                                                state.update([
                                                                  "dropBarrioView"
                                                                ]);
                                                              },
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          const Text(
                                                              'Seleccionar Resultado'),
                                                          Expanded(
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount:
                                                                          filterBarrio
                                                                              .length,
                                                                      itemBuilder:
                                                                          (b, index) {
                                                                        return ListTile(
                                                                          onTap:
                                                                              () {
                                                                            valuebarrio.text =
                                                                                filterBarrio[index].barrio ?? "-";
                                                                            // valueLeader2 = filterMunicipio[index];
                                                                            state.update([
                                                                              "dropBarrioView"
                                                                            ]);
                                                                            Get.back();
                                                                          },
                                                                          title:
                                                                              Text(filterBarrio[index].barrio ?? "-"),
                                                                        );
                                                                      })),
                                                          Center(
                                                            child: TextButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              style: TextButton
                                                                  .styleFrom(
                                                                fixedSize:
                                                                    const Size(
                                                                        120,
                                                                        40),
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xffff004e),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 20,
                                                                  horizontal:
                                                                      10,
                                                                ),
                                                              ),
                                                              child:
                                                                  const SizedBox(
                                                                width: 200,
                                                                child: Text(
                                                                  'Cerrar',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                        child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text(
                                              valuebarrio.text,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            )));
                                  }),
                            ))
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                  width:
                      localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
                  child: CustomTextForm(
                      labelText: 'Nombres y Apellidos',
                      input: TextInputType.text,
                      controller: nombre,
                      enable: enable)),
              SizedBox(
                  width:
                      localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
                  child: CustomTextForm(
                      labelText: 'Direccion',
                      input: TextInputType.text,
                      controller: direccion,
                      enable: enable)),
              SizedBox(
                  width:
                      localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
                  child: CustomTextForm(
                      labelText: 'Telefono',
                      input: TextInputType.number,
                      controller: telefono,
                      enable: enable)),
              // SizedBox(
              //     width:
              //         localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
              //     child: CustomTextForm(
              //         labelText: 'Edad',
              //         input: TextInputType.number,
              //         controller: edad,
              //         enable: enable)),
              Container(
                height: 40,
              ),
              Builder(builder: (_) {
                // if (valueleader == null) {
                // }
                filterLeader.clear();
                for (var i = 0; i < mainController.filterLeader.length; i++) {
                  filterLeader.add(mainController.filterLeader[i]);
                }
                return Visibility(
                  visible: enable,
                  child: Row(
                    children: [
                      const Text(
                        'Lider   ',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      SizedBox(
                        width: localwidth >= 800
                            ? localwidth * 0.2
                            : localwidth * 0.5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.transparent,
                          child: GetBuilder<MainController>(
                              id: "dropLeaderView",
                              builder: (state) {
                                return OutlinedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                    width: 2.0,
                                                    style:
                                                        BorderStyle.solid)))),
                                    onPressed: () {
                                      Get.dialog(Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.2,
                                          horizontal: Get.width * 0.25,
                                        ),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: mainController
                                                  .filterLeader.isEmpty
                                              ? const Center(
                                                  child: Text("No hay datos"),
                                                )
                                              : Obx(() {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: TextField(
                                                          autofocus: true,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      "Nombre de.."),
                                                          controller:
                                                              valueleader,
                                                          onChanged: (_) {
                                                            filterLeader.value = mainController
                                                                .filterLeader
                                                                .where((element) => element
                                                                    .name!
                                                                    .toLowerCase()
                                                                    .contains(_
                                                                        .toLowerCase()))
                                                                .toList();
                                                            state.update([
                                                              "dropLeaderView"
                                                            ]);
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      const Text(
                                                          'Seleccionar Resultado'),
                                                      Expanded(
                                                          child:
                                                              ListView.builder(
                                                                  itemCount:
                                                                      filterLeader
                                                                          .length,
                                                                  itemBuilder:
                                                                      (b, index) {
                                                                    return ListTile(
                                                                      onTap:
                                                                          () {
                                                                        valueleader
                                                                            .text = filterLeader[index]
                                                                                .name ??
                                                                            "-";
                                                                        valueLeader2 =
                                                                            filterLeader[index];
                                                                        state
                                                                            .update([
                                                                          "dropLeaderView"
                                                                        ]);
                                                                        Get.back();
                                                                      },
                                                                      title: Text(
                                                                          filterLeader[index].name ??
                                                                              "-"),
                                                                    );
                                                                  })),
                                                      Center(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            fixedSize:
                                                                const Size(
                                                                    120, 40),
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
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Text(
                                          valueleader.text,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )));
                              }),
                        ),
                      )
                    ],
                  ),
                );
              }),
              Container(
                height: 40,
              ),
              Builder(builder: (_) {
                if (mainController.filterPuesto.isEmpty) {
                  return Container();
                }

                return Visibility(
                  visible: enable,
                  child: Row(
                    children: [
                      const Text(
                        'Puesto',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      SizedBox(
                        width: localwidth >= 800
                            ? localwidth * 0.2
                            : localwidth * 0.5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.transparent,
                          child: GetBuilder<MainController>(
                              id: "dropPuestoView",
                              builder: (state) {
                                return OutlinedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: const BorderSide(
                                                    width: 2.0,
                                                    style:
                                                        BorderStyle.solid)))),
                                    onPressed: () {
                                      // state.searchDomi("");
                                      Get.dialog(Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: Get.height * 0.2,
                                          horizontal: Get.width * 0.25,
                                        ),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: filterPuesto.isEmpty
                                              ? const Center(
                                                  child: Text("No hay datos"),
                                                )
                                              : Obx(() {
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: TextField(
                                                          autofocus: true,
                                                          decoration:
                                                              const InputDecoration(
                                                                  hintText:
                                                                      "Nombre de.."),
                                                          controller:
                                                              valuepuesto,
                                                          onChanged: (_) {
                                                            filterPuestoSearch
                                                                    .value =
                                                                filterPuesto
                                                                    .where((element) => element
                                                                        .nombre!
                                                                        .toLowerCase()
                                                                        .contains(
                                                                            _.toLowerCase()))
                                                                    .toList();
                                                            state.update([
                                                              "dropPuestoView"
                                                            ]);
                                                          },
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      const Text(
                                                          'Seleccionar Resultado'),
                                                      Expanded(
                                                          child:
                                                              ListView.builder(
                                                                  itemCount:
                                                                      filterPuestoSearch
                                                                          .length,
                                                                  itemBuilder:
                                                                      (b, index) {
                                                                    return ListTile(
                                                                      onTap:
                                                                          () {
                                                                        valuepuesto
                                                                            .text = filterPuestoSearch[index]
                                                                                .nombre ??
                                                                            "-";
                                                                        valuePuesto2 =
                                                                            filterPuestoSearch[index];
                                                                        state
                                                                            .update([
                                                                          "dropPuestoView"
                                                                        ]);
                                                                        Get.back();
                                                                      },
                                                                      title: Text(
                                                                          filterPuestoSearch[index].nombre ??
                                                                              "-"),
                                                                    );
                                                                  })),
                                                      Center(
                                                        child: TextButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          style: TextButton
                                                              .styleFrom(
                                                            fixedSize:
                                                                const Size(
                                                                    120, 40),
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
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 20),
                                        child: Text(
                                          valuepuesto.text,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )));
                              }),
                        ),
                      )
                    ],
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: localwidth >= 800
                        ? localwidth * 0.24
                        : localwidth * 0.27,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        enable = false;
                        Votante votante = Votante(
                            name: nombre.text,
                            id: cedula.text,
                            leaderID: valueLeader2!.id!,
                            phone: telefono.text,
                            puestoID: valuePuesto2 == null
                                ? 'Sin Puesto'
                                : valuePuesto2!.id!,
                            direccion: direccion.text,
                            municipio: valuemunicipio.text,
                            encuesta: false,
                            estado: 'activo',
                            barrio: valuebarrio.text == ""
                                ? 'Sin Barrio'
                                : valuebarrio.text,
                            edad: edad.text);
                        if (update) {
                          if (valuemunicipio.text != 'Valledupar') {
                            votante.barrio = null;
                          }
                          final response =
                              await mainController.updateVotante2(votante);
                          AwesomeDialog(
                                  width: 566,
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  headerAnimationLoop: false,
                                  title: response,
                                  desc:
                                      'El votante fue actualizado correctamente',
                                  btnOkOnPress: () {},
                                  btnOkIcon: Icons.cancel,
                                  btnOkColor: const Color(0xff01b9ff))
                              .show();
                          nombre.clear();
                          cedula.clear();
                          telefono.clear();
                          direccion.clear();
                          edad.clear();
                          valuebarrio.clear();
                          valueleader.clear();
                          valuemunicipio.clear();
                          valuepuesto.clear();
                          setState(() {});
                        } else {
                          final response =
                              await mainController.addVotante2(votante);
                          if (response == 'Ya Existe') {
                            AwesomeDialog(
                                    width: 566,
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: response,
                                    desc: 'El votante ya se encuentra creado',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: const Color(0xffff004e))
                                .show();
                          } else {
                            AwesomeDialog(
                                    width: 566,
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: response,
                                    desc:
                                        'El votante fue registrado correctamente',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: const Color(0xff01b9ff))
                                .show();
                            nombre.clear();
                            cedula.clear();
                            telefono.clear();
                            direccion.clear();
                            edad.clear();
                            valuebarrio.clear();
                            valueleader.clear();
                            valuemunicipio.clear();
                            valuepuesto.clear();
                            setState(() {});
                          }
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff01b9ff),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                    ),
                    child: Text(
                      !update ? 'Registrar usuario' : 'Actualizar usuario',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
