// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  TextEditingController textEditingController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  List<Leader> aux = [];
  List<String> leadersname = [];
  MainController mainController = Get.find();
  StaticFields staticfields = StaticFields();

  bool enable = false;
  bool update = false;
  String? valueleader;
  String? valuepuesto;
  String? valuemunicipio;
  String? valuebarrio;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Leader>>(
        future: mainController.getLeaders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                              child: _textFormField('Cedula',
                                  TextInputType.number, cedula, !enable)),
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
                                final response = await mainController
                                    .getoneVotante(cedula.text);
                                if (response != null) {
                                  setState(() {
                                    AwesomeDialog(
                                            width: 566,
                                            context: context,
                                            dialogType: DialogType.success,
                                            animType: AnimType.rightSlide,
                                            headerAnimationLoop: false,
                                            title: 'Ya esta registrado',
                                            desc:
                                                'El votante fue registrado anteriormente',
                                            btnOkOnPress: () {},
                                            btnOkIcon: Icons.cancel,
                                            btnOkColor: const Color(0xff01b9ff))
                                        .show();
                                    nombre.text = response.name;
                                    cedula.text = response.id;
                                    valueleader = response.leaderID;
                                    valuepuesto = response.puestoID;
                                    telefono.text = response.phone;
                                    direccion.text = response.direccion;
                                    edad.text = response.edad;
                                    valuemunicipio = response.municipio;
                                    if (response.municipio != 'Valledupar') {
                                      valuebarrio = null;
                                    } else {
                                      valuebarrio = response.barrio;
                                    }
                                    enable = true;
                                    update = true;
                                  });
                                } else {
                                  setState(() {
                                    enable = true;
                                    AwesomeDialog(
                                            width: 566,
                                            context: context,
                                            dialogType: DialogType.info,
                                            animType: AnimType.rightSlide,
                                            headerAnimationLoop: false,
                                            title: 'No existe',
                                            desc:
                                                'El votante no ha sido registrado',
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
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                hint: Row(
                                  children: const [
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
                                items: staticfields
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
                                value: valuemunicipio,
                                onChanged: (value) {
                                  setState(() {
                                    valuemunicipio = value as String;
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                  return (item.value
                                      .toString()
                                      .contains(searchValue));
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
                                buttonWidth: 300,
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
                                itemPadding:
                                    const EdgeInsets.only(left: 14, right: 14),
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
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      valuemunicipio == 'Valledupar'
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
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
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
                                    items: staticfields
                                        .getBarrios()
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item.barrio,
                                              child: Text(
                                                item.barrio!,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: valuebarrio,
                                    onChanged: (value) {
                                      setState(() {
                                        valuebarrio = value as String;
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
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Busca un Barrio',
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      return (item.value
                                          .toString()
                                          .contains(searchValue));
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
                                    buttonWidth: 300,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.white,
                                    ),
                                    buttonElevation: 2,
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
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
                                ),
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
                      Row(
                        children: [
                          const Text(
                            'Lider',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 55,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Row(
                                children: const [
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
                              items: snapshot.data!
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item.id,
                                        child: Text(
                                          item.name,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              value: valueleader,
                              onChanged: (value) {
                                setState(() {
                                  valueleader = value as String;
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
                                    hintText: 'Busca un Lider',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                return (item.value
                                    .toString()
                                    .contains(searchValue));
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
                              buttonWidth: 300,
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
                              itemPadding:
                                  const EdgeInsets.only(left: 14, right: 14),
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
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                      ),
                      FutureBuilder<List<Puesto>>(
                          future: null,
                          builder: (context, snapshot) {
                            return Row(
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
                                DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                    isExpanded: true,
                                    hint: Row(
                                      children: const [
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
                                    items: leadersname
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ))
                                        .toList(),
                                    value: valuepuesto,
                                    onChanged: (value) {
                                      setState(() {
                                        valuepuesto = value as String;
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
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 8,
                                          ),
                                          hintText: 'Busca un puesto',
                                          hintStyle:
                                              const TextStyle(fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    ),
                                    searchMatchFn: (item, searchValue) {
                                      return (item.value
                                          .toString()
                                          .contains(searchValue));
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
                                    buttonWidth: 300,
                                    buttonPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.black26,
                                      ),
                                      color: Colors.white,
                                    ),
                                    buttonElevation: 2,
                                    itemHeight: 40,
                                    itemPadding: const EdgeInsets.only(
                                        left: 14, right: 14),
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
                                ),
                              ],
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
                                    leaderID: valueleader!,
                                    phone: telefono.text,
                                    puestoID: 'valuepuesto!',
                                    direccion: direccion.text,
                                    municipio: valuemunicipio!,
                                    barrio: valuebarrio,
                                    edad: edad.text);
                                if (update) {
                                  if (valuemunicipio != 'Valledupar') {
                                    votante.barrio = null;
                                  }
                                  final response = await mainController
                                      .updateVotante(votante);
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
                                  valuebarrio = null;
                                  valueleader = null;
                                  valuemunicipio = null;
                                  valuepuesto = null;
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
                                            desc:
                                                'El votante ya se encuentra creado',
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
                                    valuebarrio = null;
                                    valueleader = null;
                                    valuemunicipio = null;
                                    valuepuesto = null;
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
          } else {
            return LoadingAnimationWidget.newtonCradle(
                color: Colors.pink, size: 100);
          }
        });
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