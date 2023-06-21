import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/ui/common/staticsFields.dart';

import '../../../controller/mainController.dart';

class PlacesRegister extends StatelessWidget {
  PlacesRegister({Key? key}) : super(key: key);

  TextEditingController nombre = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController latitud = TextEditingController();
  TextEditingController longitud = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  StaticFields staticfields = StaticFields();
  MainController mainController = Get.find();

  String? dropdownvalue;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    double localHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: localwidth * 0.1),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
              child: _textFormField('Nombre', TextInputType.text, nombre),
            ),
            SizedBox(
              width: localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
              child: _textFormField('Dirección', TextInputType.text, direccion),
            ),
            SizedBox(
              width: localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
              child: _textFormField('Latitud', TextInputType.number, latitud),
            ),
            SizedBox(
              width: localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
              child: _textFormField('Longitud', TextInputType.number, longitud),
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
                      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
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
                  width:
                      localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.30,
                ),
                TextButton(
                  onPressed: () async {
                    Puesto puesto = Puesto(
                        nombre: nombre.text,
                        id: dropdownvalue! + nombre.text,
                        latitud: latitud.text,
                        longitud: latitud.text,
                        municipio: dropdownvalue,
                        direccion: direccion.text);
                    await mainController.addPuesto(puesto);
                    AwesomeDialog(
                            width: 566,
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Registro exitoso',
                            desc: 'El puesto fue registrado correctamente',
                            btnOkOnPress: () {},
                            btnOkIcon: Icons.cancel,
                            btnOkColor: const Color(0xff01b9ff))
                        .show();
                    nombre.clear();
                    latitud.clear();
                    longitud.clear();
                    direccion.clear();

                    // for (var i = 0; i < staticfields.listapuestos.length; i++) {
                    //   mainController.anotheraddpuesto(
                    //       staticfields.listapuestos[i]['municipio']! +
                    //           staticfields.listapuestos[i]['nombre']!,
                    //       staticfields.listapuestos[i] as Map<String, String>);
                    // }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xff01b9ff),
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                  ),
                  child: const Text(
                    'Registrar puesto',
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
      },
      onChanged: (_) {},
    );
  }
}
