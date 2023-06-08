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

  TextEditingController fecha = TextEditingController();

  String? dropdownvalue;

  RxList<Leader> filterLeader = <Leader>[].obs;

  Leader? valueLeader2;

  final formkey = GlobalKey<FormState>();

  MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 40),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: 475,
                child: _textFormField('Nombre', TextInputType.text, nombre, 1)),
            SizedBox(
                width: 475,
                child: _textFormField(
                    'Descripcion', TextInputType.text, descripcion, 3)),
            const SizedBox(
              height: 20,
            ),
            Builder(builder: (_) {
              // if (valueleader == null) {
              // }
              filterLeader.clear();
              for (var i = 0; i < mainController.filterLeader.length; i++) {
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
                    width: 420,
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
                                                style: BorderStyle.solid)))),
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
                                      child: mainController.filterLeader.isEmpty
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
                                                        filterLeader.value = mainController
                                                            .filterLeader
                                                            .where((element) =>
                                                                element.name!
                                                                    .toLowerCase()
                                                                    .contains(_
                                                                        .toLowerCase()))
                                                            .toList();
                                                        state.update(
                                                            ["dropLeaderView"]);
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                      'Seleccionar Resultado'),
                                                  Expanded(
                                                      child: ListView.builder(
                                                          itemCount:
                                                              filterLeader
                                                                  .length,
                                                          itemBuilder:
                                                              (b, index) {
                                                            return ListTile(
                                                              onTap: () {
                                                                valueleader
                                                                        .text =
                                                                    filterLeader[index]
                                                                            .name ??
                                                                        "-";
                                                                valueLeader2 =
                                                                    filterLeader[
                                                                        index];
                                                                state.update([
                                                                  "dropLeaderView"
                                                                ]);
                                                                Get.back();
                                                              },
                                                              title: Text(
                                                                  filterLeader[
                                                                              index]
                                                                          .name ??
                                                                      "-"),
                                                            );
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
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )));
                          }),
                    ),
                  )
                ],
              );
            }),
            SizedBox(
              width: 470,
              child: TextFormField(
                onTap: () {
                  _selectDate(context);
                },
                controller: fecha,
                decoration: InputDecoration(
                  labelText: 'Fecha',
                ),
                readOnly:
                    true, // Hacer que el campo de texto sea de solo lectura
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                String now = DateTime.now().toString();
                Favores favor = Favores(
                    nombre: nombre.text,
                    id: now,
                    descripcion: descripcion.text,
                    fechafavor: fecha.text,
                    leaderID: valueLeader2!.id!);
                mainController.addFavor(favor);
                AwesomeDialog(
                        width: 566,
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: false,
                        title: 'Registro exitoso',
                        desc: 'El favor fue registrado correctamente',
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
                backgroundColor: const Color(0xffff004e),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
              ),
              child: const Text(
                'Registrar Favor',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        )),
      ),
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
}
