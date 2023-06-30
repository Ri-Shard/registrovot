import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/favores.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../model/leader.dart';

// ignore: must_be_immutable
class FavoresRegister extends StatefulWidget {
  FavoresRegister({Key? key}) : super(key: key);

  @override
  State<FavoresRegister> createState() => _FavoresRegisterState();
}

class _FavoresRegisterState extends State<FavoresRegister> {
  TextEditingController nombre = TextEditingController();

  TextEditingController descripcion = TextEditingController();

  TextEditingController valueleader = TextEditingController();
  TextEditingController valuefavor = TextEditingController();

  TextEditingController fecha = TextEditingController();

  String? dropdownvalue;

  RxList<Leader> filterLeader = <Leader>[].obs;
  RxList<Favores> filterFavor = <Favores>[].obs;
  bool update = false;
  Leader? valueLeader2;
  String? idupdate;
  bool statusupdate = false;

  final formkey = GlobalKey<FormState>();

  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    double localHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StreamBuilder(
          stream: mainController.getFavor(),
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              mainController.filterFavores.clear();
              for (var i = 0; i < snapshot.data!.length; i++) {
                mainController.filterFavores.add(snapshot.data![i]);
              }
            }
            return Padding(
              padding: EdgeInsets.only(left: localwidth * 0.1),
              child: Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      // SizedBox(
                      //   width:
                      //       localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.33,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextButton(
                          onPressed: () {
                            _dialog1();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xffff004e),
                            padding: const EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 10,
                            ),
                          ),
                          child: const Text(
                            'Ver Compromisos',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                      width: localwidth >= 800
                          ? localwidth * 0.24
                          : localwidth * 0.67,
                      child: _textFormField(
                          'Nombre', TextInputType.text, nombre, 1)),
                  SizedBox(
                      width: localwidth >= 800
                          ? localwidth * 0.24
                          : localwidth * 0.67,
                      child: _textFormField(
                          'Descripcion', TextInputType.text, descripcion, 3)),
                  const SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (_) {
                    // if (valueleader == null) {
                    // }
                    filterLeader.clear();
                    for (var i = 0;
                        i < mainController.filterLeader.length;
                        i++) {
                      filterLeader.add(mainController.filterLeader[i]);
                    }
                    return Row(
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
                                                                      .contains(
                                                                          _.toLowerCase()))
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
                                                                          state
                                                                              .update([
                                                                            "dropLeaderView"
                                                                          ]);
                                                                          Get.back();
                                                                        },
                                                                        title: Text(filterLeader[index].name ??
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
                                                        SizedBox(
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
                    );
                  }),
                  SizedBox(
                    width: localwidth >= 800
                        ? localwidth * 0.24
                        : localwidth * 0.68,
                    child: TextFormField(
                      onTap: () {
                        _selectDate(context);
                      },
                      controller: fecha,
                      decoration: const InputDecoration(
                        labelText: 'Fecha',
                      ),
                      readOnly:
                          true, // Hacer que el campo de texto sea de solo lectura
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: localwidth >= 800
                            ? localwidth * 0.24
                            : localwidth * 0.25,
                      ),
                      TextButton(
                        onPressed: () {
                          if (update) {
                            Favores favor = Favores(
                                nombre: nombre.text,
                                id: idupdate,
                                descripcion: descripcion.text,
                                fechafavor: fecha.text,
                                estado: statusupdate,
                                leaderID: valueLeader2!.id!);
                            mainController.addFavor(favor);
                          } else {
                            String now = DateTime.now().toString();
                            Favores favor = Favores(
                                nombre: nombre.text,
                                id: now,
                                descripcion: descripcion.text,
                                fechafavor: fecha.text,
                                estado: false,
                                leaderID: valueLeader2!.id!);
                            mainController.addFavor(favor);
                          }
                          AwesomeDialog(
                                  width: 566,
                                  context: context,
                                  dialogType: DialogType.success,
                                  animType: AnimType.rightSlide,
                                  headerAnimationLoop: false,
                                  title: 'Registro exitoso',
                                  desc:
                                      'El compromiso fue registrado correctamente',
                                  btnOkOnPress: () {},
                                  btnOkIcon: Icons.cancel,
                                  btnOkColor: const Color(0xff01b9ff))
                              .show();
                          nombre.clear();
                          descripcion.clear();
                          valueleader.clear();
                          fecha.clear();
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xff01b9ff),
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                        ),
                        child: Text(
                          !update == true
                              ? 'Registrar Compromiso'
                              : 'Actualizar compromiso',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            );
          }),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: const Locale('es', ''),
      context: context,
      initialDate: DateTime.now(), // Fecha inicial del selector
      firstDate: DateTime(2000), // Fecha más temprana permitida
      lastDate: DateTime(2100), // Fecha más tardía permitida
    );

    if (picked != null) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formattedDate = formatter.format(picked);
      setState(() {
        fecha.text = formattedDate;
      });
    }
  }

  Widget _textFormField(String labelText, TextInputType input,
      TextEditingController controller, int lines) {
    return TextFormField(
      maxLength: labelText == 'Descripcion' ? 140 : null,
      maxLines: lines,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: input,
      controller: controller,
      validator: (_) {
        if (_ == null || _.isEmpty) {
          return "Debe llenar este campo";
        }
        return null;
      },
      onChanged: (_) {},
    );
  }

  _dialog1() {
    Get.dialog(Container(
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.2,
        horizontal: Get.width * 0.25,
      ),
      child: GetBuilder<MainController>(
          id: 'testss',
          builder: (__) {
            filterFavor.value = mainController.filterFavores;
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: mainController.filterFavores.isEmpty
                  ? const Center(
                      child: Text("No hay datos"),
                    )
                  : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            autofocus: true,
                            decoration:
                                const InputDecoration(hintText: "Nombre de.."),
                            controller: valuefavor,
                            onChanged: (_) {
                              filterFavor.value = mainController.filterFavores
                                  .where((element) => element.nombre!
                                      .toLowerCase()
                                      .contains(_.toLowerCase()))
                                  .toList();
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('Seleccionar Resultado'),
                        Expanded(
                            child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount: filterFavor.length,
                                itemBuilder: (b, index) {
                                  return ListTile(
                                    onTap: () {
                                      // Get.back();
                                    },
                                    title: Text(
                                        "${filterFavor[index].nombre}: ${filterFavor[index].descripcion}" ??
                                            "-"),
                                    subtitle:
                                        Text(filterFavor[index].fechafavor!),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              update = true;
                                              nombre.text =
                                                  filterFavor[index].nombre!;
                                              descripcion.text =
                                                  filterFavor[index]
                                                      .descripcion!;
                                              descripcion.text =
                                                  filterFavor[index]
                                                      .descripcion!;

                                              valueleader.text = filterLeader
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      filterFavor[index]
                                                          .leaderID)
                                                  .name
                                                  .toString();
                                              valueLeader2 = filterLeader
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      filterFavor[index]
                                                          .leaderID);
                                              fecha.text = filterFavor[index]
                                                  .fechafavor!;
                                              statusupdate =
                                                  filterFavor[index].estado;
                                              idupdate = filterFavor[index].id;
                                              Get.back();
                                              setState(() {});
                                            },
                                            child: const Icon(Icons.edit,
                                                size: 30,
                                                color: Color(0xff01b9ff))),
                                        Checkbox(
                                            value: filterFavor[index].estado,
                                            onChanged: (_) async {
                                              Favores favor = Favores(
                                                  nombre:
                                                      filterFavor[index].nombre,
                                                  id: filterFavor[index].id,
                                                  descripcion:
                                                      filterFavor[index]
                                                          .descripcion,
                                                  leaderID: filterFavor[index]
                                                      .leaderID,
                                                  fechafavor: filterFavor[index]
                                                      .fechafavor,
                                                  estado: _!);
                                              await mainController
                                                  .addFavor(favor);
                                              __.update(['testss']);
                                              Get.back();
                                              await Future.delayed(
                                                      const Duration(
                                                          microseconds: 500))
                                                  .whenComplete(() {
                                                filterFavor.value =
                                                    mainController
                                                        .filterFavores;
                                                Get.dialog(Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      vertical:
                                                          Get.height * 0.2,
                                                      horizontal:
                                                          Get.width * 0.25,
                                                    ),
                                                    child: Card(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: const Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10.0),
                                                            child:
                                                                const CircularProgressIndicator()))));
                                                Get.back();
                                              });
                                              _dialog1();
                                            }),
                                      ],
                                    ),
                                  );
                                })),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: TextButton.styleFrom(
                              fixedSize: const Size(120, 40),
                              backgroundColor: const Color(0xffff004e),
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
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
            );
          }),
    ));
  }
}
