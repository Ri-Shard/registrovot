// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/ui/common/staticsFields.dart';

class LeadersRegister extends StatefulWidget {
  LeadersRegister({Key? key}) : super(key: key);

  @override
  State<LeadersRegister> createState() => _LeadersRegisterState();
}

class _LeadersRegisterState extends State<LeadersRegister> {
  TextEditingController cedula = TextEditingController();

  TextEditingController nombre = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController textEditingController = TextEditingController();
  RxList<Leader> filterLeader = <Leader>[].obs;

  MainController mainController = Get.find();

  StaticFields municipios = StaticFields();

  final formkey = GlobalKey<FormState>();

  RxList<Leader> searchLeader = <Leader>[].obs;

  String? dropdownvalue;

  bool hasalcaldia = false;

  bool update = false;

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    double localHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: localwidth * 0.1, vertical: 20),
        child: Form(
          key: formkey,
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width:
                      localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
                  child: Container(
                    child: GetBuilder<MainController>(
                        id: 'CedulaLeader',
                        builder: (state) {
                          return InkWell(
                            onTap: () {
                              hasalcaldia = true;

                              // searchvotante.clear();
                              searchLeader.value = mainController.filterLeader;
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
                                              padding: const EdgeInsets.all(20),
                                              child: TextField(
                                                autofocus: true,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Nombre de.."),
                                                controller: cedula,
                                                onChanged: (_) {
                                                  searchLeader.value = mainController
                                                      .filterLeader
                                                      .where((element) => element
                                                          .toJson()
                                                          .toString()
                                                          .toLowerCase()
                                                          .contains(
                                                              _.toLowerCase()))
                                                      .toList();
                                                  state
                                                      .update(["CedulaLeader"]);
                                                },
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            const Text('Seleccionar Resultado'),
                                            Expanded(
                                                child: ListView.builder(
                                                    itemCount: (searchLeader
                                                                .isEmpty &&
                                                            cedula.text.isNum &&
                                                            cedula.text
                                                                    .length >=
                                                                6 &&
                                                            cedula.text
                                                                    .length <=
                                                                11)
                                                        ? 1
                                                        : searchLeader.length,
                                                    itemBuilder: (b, index) {
                                                      if (searchLeader
                                                              .isEmpty &&
                                                          cedula.text.isNum &&
                                                          cedula.text.length >=
                                                              6) {
                                                        return Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 20),
                                                              width: 200,
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    update =
                                                                        false;
                                                                    nombre
                                                                        .clear();
                                                                    phone
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
                                                                  width: 200,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'Agregar',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
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
                                                          filterLeader.clear();
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
                                                              searchLeader[
                                                                      index]
                                                                  .id!;
                                                          // valueLeader2 = filterMunicipio[index];
                                                          state.update(
                                                              ["CedulaLeader"]);
                                                          setState(() {
                                                            update = true;

                                                            nombre.text =
                                                                searchLeader[
                                                                        index]
                                                                    .name!;
                                                            cedula.text =
                                                                searchLeader[
                                                                        index]
                                                                    .id!;
                                                            dropdownvalue =
                                                                searchLeader[
                                                                        index]
                                                                    .municipio!;
                                                            phone.text =
                                                                searchLeader[
                                                                        index]
                                                                    .phone!;
                                                          });
                                                          Get.back();
                                                        },
                                                        title: Text(
                                                            "${searchLeader[index].id} ${searchLeader[index].name}"),
                                                      );
                                                    })),
                                            Center(
                                              child: TextButton(
                                                onPressed: () {
                                                  nombre.clear();
                                                  cedula.clear();
                                                  phone.clear();
                                                  dropdownvalue = null;
                                                  setState(() {});
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
                                                child: SizedBox(
                                                  width: localwidth * 0.5,
                                                  child: const Text(
                                                    'Cerrar',
                                                    textAlign: TextAlign.center,
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
              SizedBox(
                width:
                    localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
                child: _textFormField('Nombre', TextInputType.text, nombre),
              ),
              SizedBox(
                width:
                    localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
                child: _textFormField('Telefono', TextInputType.number, phone),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    'Municipio',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  StatefulBuilder(builder: (context, setState) {
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Seleccione',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: municipios
                            .getMunicipios()
                            .map((item) => DropdownMenuItem<String>(
                                  value: item.nombre,
                                  child: Text(
                                    item.nombre!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: dropdownvalue,
                        onChanged: (value) {
                          setState(() {
                            dropdownvalue = value as String;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        searchController: textEditingController,
                        searchInnerWidgetHeight: 50,
                        searchInnerWidget: Container(
                          height: 50,
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            expands: true,
                            maxLines: null,
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Busca un municipio',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return (item.value.toString().contains(searchValue));
                        },

                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingController.clear();
                          }
                        },
                        iconSize: 14,
                        iconEnabledColor: Colors.grey,
                        iconDisabledColor: Colors.grey,
                        buttonHeight: 50,
                        buttonWidth: localwidth >= 800
                            ? localwidth * 0.18
                            : localwidth * 0.39,
                        buttonPadding:
                            const EdgeInsets.only(left: 14, right: 14),
                        buttonDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: Colors.white,
                        ),
                        buttonElevation: 2,
                        itemHeight: 40,
                        itemPadding: const EdgeInsets.only(left: 14, right: 14),
                        dropdownMaxHeight: 200,
                        dropdownWidth: 200,
                        dropdownPadding: null,
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: Colors.white,
                        ),
                        dropdownElevation: 8,
                        scrollbarRadius: const Radius.circular(40),
                        scrollbarThickness: 6,
                        scrollbarAlwaysShow: true,
                        offset: const Offset(-20, 0),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: localwidth >= 800
                        ? localwidth * 0.24
                        : localwidth * 0.35,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        Leader leader = Leader(
                            name: nombre.text,
                            id: cedula.text,
                            phone: phone.text,
                            municipio: dropdownvalue!);

                        if (update) {
                          final response =
                              await mainController.updateLeader(leader);
                          if (response == 'Lider Actualizado') {
                            AwesomeDialog(
                                    width: 566,
                                    context: context,
                                    dialogType: DialogType.success,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: response,
                                    desc:
                                        'El lider fue actualizado correctamente',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: const Color(0xff01b9ff))
                                .show();
                            nombre.clear();
                            cedula.clear();
                            phone.clear();
                            dropdownvalue = null;
                            setState(() {});
                          } else {
                            AwesomeDialog(
                                    width: 566,
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: response,
                                    desc: 'Error al actualizar',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: const Color(0xffff004e))
                                .show();
                          }
                        } else {
                          final response =
                              await mainController.addLeader(leader);

                          if (response == 'Ya Existe') {
                            AwesomeDialog(
                                    width: 566,
                                    context: context,
                                    dialogType: DialogType.error,
                                    animType: AnimType.rightSlide,
                                    headerAnimationLoop: false,
                                    title: response,
                                    desc: 'El lider ya se encuentra creado',
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
                                        'El lider fue registrado correctamente',
                                    btnOkOnPress: () {},
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: const Color(0xff01b9ff))
                                .show();
                            nombre.clear();
                            cedula.clear();
                            phone.clear();
                            dropdownvalue = null;
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
                      !update ? 'Registrar lider' : 'Actualizar Lider',
                      style: const TextStyle(
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
        ),
      ),
    );
  }

  Widget _textFormField(
      String labelText, TextInputType input, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      keyboardType: input,
      controller: controller,
      validator: (_) {
        if (_ == null || _.isEmpty) {
          return "Debe llenar este campo";
        }
        if (input == TextInputType.number) {
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
