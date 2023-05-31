// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/model/votante.dart';
import 'package:registrovot/ui/common/staticsFields.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 500,
                      child: _textFormField(
                          'Cedula', TextInputType.number, cedula, true)),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (cedula.text.isEmpty) {
                        AwesomeDialog(
                                width: 566,
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'Campos vacios',
                                desc: 'Digite una cedula',
                                btnOkOnPress: () {},
                                btnOkIcon: Icons.cancel,
                                btnOkColor: const Color(0xffff004e))
                            .show();
                      } else {
                        final response =
                            await mainController.getoneVotante(cedula.text);
                        if (response != null) {
                          setState(() {
                            enable = true;
                            update = true;

                            nombre.text = response.name;
                            cedula.text = response.id;
                            valuemunicipio.text = response.municipio;
                            filterBarrio.value = staticfields.getBarrios();
                            filterMunicipio.value =
                                staticfields.getMunicipios();
                            valueleader.text = filterLeader
                                .firstWhere((element) =>
                                    element.id == response.leaderID)
                                .name
                                .toString();
                            valuepuesto.text = filterPuestoPre
                                .firstWhere((element) =>
                                    element.id == response.puestoID)
                                .nombre
                                .toString();

                            telefono.text = response.phone;
                            direccion.text = response.direccion;
                            edad.text = response.edad;
                            if (response.municipio != 'Valledupar') {
                              valuebarrio.clear();
                            } else {
                              valuebarrio.text = response.barrio!;
                            }
                          });
                        } else {
                          setState(() {
                            enable = true;
                            filterBarrio.value = staticfields.getBarrios();
                            filterMunicipio.value =
                                staticfields.getMunicipios();
                            nombre.clear();
                            telefono.clear();
                            direccion.clear();
                            edad.clear();
                            valuebarrio.clear();
                            valueleader.clear();
                            valuemunicipio.clear();
                            valuepuesto.clear();
                            AwesomeDialog(
                                    width: 566,
                                    context: context,
                                    dialogType: DialogType.info,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: 'No existe',
                                    desc: 'El votante no ha sido registrado',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: const Color(0xffff004e))
                                .show();
                          });
                        }
                      }
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(120, 40),
                      backgroundColor: const Color(0xffff004e),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                    ),
                    child: const Text(
                      'Buscar',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
                        width: 500,
                        child: Form(
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
                                      onPressed: () {
                                        // state.searchDomi("");
                                        Get.dialog(Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.1,
                                            horizontal: Get.width * 0.2,
                                          ),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: filterMunicipio.isEmpty
                                                ? const Center(
                                                    child: Text("No hay datos"),
                                                  )
                                                : Obx(() {
                                                    return Column(
                                                      children: [
                                                        TextField(
                                                          autofocus: true,
                                                          decoration:
                                                              InputDecoration(
                                                                  hintText:
                                                                      "Nombre de.."),
                                                          controller:
                                                              valuemunicipio,
                                                          onChanged: (_) {
                                                            filterMunicipio.value = staticfields
                                                                .getMunicipios()
                                                                .where((element) => element
                                                                    .nombre!
                                                                    .toLowerCase()
                                                                    .contains(_
                                                                        .toLowerCase()))
                                                                .toList();
                                                            state.update([
                                                              "dropMunicipioView"
                                                            ]);
                                                          },
                                                        ),
                                                        Expanded(
                                                            child: ListView
                                                                .builder(
                                                                    itemCount:
                                                                        filterMunicipio
                                                                            .length,
                                                                    itemBuilder:
                                                                        (b, index) {
                                                                      return ListTile(
                                                                        onTap:
                                                                            () {
                                                                          valuemunicipio.text =
                                                                              filterMunicipio[index].nombre ?? "-";
                                                                          // valueLeader2 = filterMunicipio[index];
                                                                          state
                                                                              .update([
                                                                            "dropMunicipioView"
                                                                          ]);
                                                                          valuepuesto
                                                                              .clear();
                                                                          haspuesto.value =
                                                                              true;
                                                                          setState(
                                                                              () {});
                                                                          Get.back();
                                                                        },
                                                                        title: Text(filterMunicipio[index].nombre ??
                                                                            "-"),
                                                                      );
                                                                    })),
                                                        Center(
                                                          child: OutlinedButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                  "Cerrar")),
                                                        )
                                                      ],
                                                    );
                                                  }),
                                          ),
                                        ));
                                      },
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: Text(
                                            valuemunicipio.text,
                                            style:
                                                TextStyle(color: Colors.black),
                                          )));
                                }),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              valuemunicipio.text == 'Valledupar'
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
                            width: 500,
                            child: Form(
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
                                                vertical: Get.height * 0.1,
                                                horizontal: Get.width * 0.2,
                                              ),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: filterBarrio.isEmpty
                                                    ? const Center(
                                                        child: Text(
                                                            "No hay datos"),
                                                      )
                                                    : Obx(() {
                                                        return Column(
                                                          children: [
                                                            TextField(
                                                              autofocus: true,
                                                              decoration:
                                                                  InputDecoration(
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
                                                                              valuebarrio.text = filterBarrio[index].barrio ?? "-";
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
                                                              child:
                                                                  OutlinedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      child: const Text(
                                                                          "Cerrar")),
                                                            )
                                                          ],
                                                        );
                                                      }),
                                              ),
                                            ));
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(
                                                valuebarrio.text,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )));
                                    }),
                              ),
                            ))
                      ],
                    )
                  : const SizedBox(),
              SizedBox(
                width: 500,
                child: _textFormField(
                    'Nombres', TextInputType.text, nombre, enable),
              ),
              SizedBox(
                width: 500,
                child: _textFormField(
                    'Telefono', TextInputType.number, telefono, enable),
              ),
              SizedBox(
                width: 500,
                child: _textFormField(
                  'Edad',
                  TextInputType.number,
                  edad,
                  enable,
                ),
              ),
              Container(
                height: 40,
              ),
              FutureBuilder<List<Leader>>(
                  future: mainController.getLeaders(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    // if (valueleader == null) {
                    // }
                    filterLeader.clear();
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      filterLeader.add(snapshot.data![i]);
                    }
                    return Visibility(
                      visible: enable,
                      child: Row(
                        children: [
                          const Text(
                            'Lider',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: 500,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.transparent,
                              child: GetBuilder<MainController>(
                                  id: "dropLeaderView",
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
                                              vertical: Get.height * 0.1,
                                              horizontal: Get.width * 0.2,
                                            ),
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: filterLeader.isEmpty
                                                  ? const Center(
                                                      child:
                                                          Text("No hay datos"),
                                                    )
                                                  : Obx(() {
                                                      return Column(
                                                        children: [
                                                          TextField(
                                                            autofocus: true,
                                                            decoration:
                                                                InputDecoration(
                                                                    hintText:
                                                                        ""),
                                                            controller:
                                                                valueleader,
                                                            onChanged: (_) {
                                                              filterLeader.value = snapshot
                                                                  .data!
                                                                  .where((element) => element
                                                                      .name!
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          _.toLowerCase()))
                                                                  .toList();
                                                              state.update([
                                                                "dropLeaderView"
                                                              ]);
                                                            },
                                                          ),
                                                          Expanded(
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount:
                                                                          filterLeader
                                                                              .length,
                                                                      itemBuilder:
                                                                          (b, index) {
                                                                        return ListTile(
                                                                          onTap:
                                                                              () {
                                                                            valueleader.text =
                                                                                filterLeader[index].name ?? "-";
                                                                            valueLeader2 =
                                                                                filterLeader[index];
                                                                            state.update([
                                                                              "dropLeaderView"
                                                                            ]);
                                                                            Get.back();
                                                                          },
                                                                          title:
                                                                              Text(filterLeader[index].name ?? "-"),
                                                                        );
                                                                      })),
                                                          Center(
                                                            child:
                                                                OutlinedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Get.back();
                                                                    },
                                                                    child: const Text(
                                                                        "Cerrar")),
                                                          )
                                                        ],
                                                      );
                                                    }),
                                            ),
                                          ));
                                        },
                                        child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 20),
                                            child: Text(
                                              valueleader.text,
                                              style: TextStyle(
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
              FutureBuilder<List<Puesto>>(
                  future: mainController.getPuestos(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    filterPuestoPre.clear();
                    for (var i = 0; i < snapshot.data!.length; i++) {
                      filterPuestoPre.add(snapshot.data![i]);
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
                            width: 500,
                            child: Form(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                color: Colors.transparent,
                                child: GetBuilder<MainController>(
                                    id: "dropPuestoView",
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
                                                vertical: Get.height * 0.1,
                                                horizontal: Get.width * 0.2,
                                              ),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: filterPuesto.isEmpty
                                                    ? const Center(
                                                        child: Text(
                                                            "No hay datos"),
                                                      )
                                                    : Obx(() {
                                                        return Column(
                                                          children: [
                                                            TextField(
                                                              autofocus: true,
                                                              decoration:
                                                                  InputDecoration(
                                                                      hintText:
                                                                          "Nombre de.."),
                                                              controller:
                                                                  valuepuesto,
                                                              onChanged: (_) {
                                                                filterPuestoSearch.value = filterPuesto
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
                                                            Expanded(
                                                                child: ListView
                                                                    .builder(
                                                                        itemCount:
                                                                            filterPuestoSearch
                                                                                .length,
                                                                        itemBuilder:
                                                                            (b, index) {
                                                                          return ListTile(
                                                                            onTap:
                                                                                () {
                                                                              valuepuesto.text = filterPuestoSearch[index].nombre ?? "-";
                                                                              valuePuesto2 = filterPuestoSearch[index];
                                                                              state.update([
                                                                                "dropPuestoView"
                                                                              ]);
                                                                              Get.back();
                                                                            },
                                                                            title:
                                                                                Text(filterPuestoSearch[index].nombre ?? "-"),
                                                                          );
                                                                        })),
                                                            Center(
                                                              child:
                                                                  OutlinedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Get.back();
                                                                      },
                                                                      child: const Text(
                                                                          "Cerrar")),
                                                            )
                                                          ],
                                                        );
                                                      }),
                                              ),
                                            ));
                                          },
                                          child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              child: Text(
                                                valuepuesto.text,
                                                style: TextStyle(
                                                    color: Colors.black),
                                              )));
                                    }),
                              ),
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
                  const SizedBox(
                    width: 516,
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
                            puestoID: valuePuesto2!.id!,
                            direccion: direccion.text,
                            municipio: valuemunicipio.text,
                            barrio: valuebarrio.text,
                            edad: edad.text);
                        if (update) {
                          if (valuemunicipio.text != 'Valledupar') {
                            votante.barrio = null;
                          }
                          final response =
                              await mainController.updateVotante(votante);
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
                              await mainController.addVotante(votante);
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
                      backgroundColor: const Color(0xffff004e),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                    ),
                    child: const Text(
                      'Registrar usuario',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  )
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

  Widget _textFormField(String labelText, TextInputType input,
      TextEditingController controller, bool enable) {
    return TextFormField(
      enabled: enable,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      keyboardType: input,
      controller: controller,
      validator: (_) {
        if (_ == null || _.isEmpty) {
          return "Debe llenar este campo";
        }
        if (labelText == 'Edad') {
          if (int.parse(_) > 110 || int.parse(_) < 18) {
            return "número no válido";
          }
        }

        if (input == TextInputType.number && labelText != 'Edad') {
          if (_.length > 10) {
            return "número no válido";
          }
          if (_.length < 7) {
            return "número no válido";
          }
        }
      },
      onChanged: (_) {},
    );
  }
}
