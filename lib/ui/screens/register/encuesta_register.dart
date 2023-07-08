import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/votante.dart';

class EncuestaView extends StatefulWidget {
  EncuestaView({super.key});

  @override
  State<EncuestaView> createState() => _EncuestaViewState();
}

class _EncuestaViewState extends State<EncuestaView> {
  final mainController = Get.find<MainController>();
  TextEditingController cedula = TextEditingController();
  RxList<Votante> filterVotanteAux = <Votante>[].obs;

  String? valuefilter;
  @override
  Widget build(BuildContext context) {
    filterVotanteAux.value = mainController.filterVotante;
    double localwidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: localwidth * 0.1, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width:
                      localwidth >= 800 ? localwidth * 0.2 : localwidth * 0.3,
                  child: TextFormField(
                    enabled: true,
                    decoration: const InputDecoration(
                      labelText: 'Buscar',
                    ),
                    controller: cedula,
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
                        filterVotanteAux.value = mainController.filterVotante;
                      } else {
                        filterVotanteAux.value = mainController.filterVotante
                            .where((p0) => p0
                                .toJson()
                                .toString()
                                .toLowerCase()
                                .contains(_.toLowerCase()))
                            .toList();
                      }
                      mainController.update(['dropCallcenter']);
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GetBuilder<MainController>(
                    id: 'filterSelect',
                    builder: (sta) {
                      return SizedBox(
                        width: localwidth >= 800
                            ? localwidth * 0.2
                            : localwidth * 0.3,
                        child: DropdownButtonHideUnderline(
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
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            items: ['Si', 'No', 'No responde']
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ))
                                .toList(),
                            value: valuefilter,
                            onChanged: (value) async {
                              Get.dialog(LoadingAnimationWidget.newtonCradle(
                                  color: Colors.pink, size: 100));
                              bool? auxval = value == 'Si'
                                  ? true
                                  : (value == 'No' ? false : null);
                              filterVotanteAux.value = mainController
                                  .filterVotante
                                  .where((p0) => p0.encuesta == auxval)
                                  .toList();

                              valuefilter = value!;
                              sta.update(["filterSelect"]);
                              mainController.update(["dropCallcenter"]);
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_outlined,
                            ),
                            //This to clear the search value when you close the menu
                            iconSize: 12,
                            iconEnabledColor: Colors.grey,
                            iconDisabledColor: Colors.grey,
                            buttonHeight: 50,
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
                            itemHeight: 36,
                            itemPadding:
                                const EdgeInsets.only(left: 14, right: 14),
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
                      );
                    }),
                const Spacer(),
                Text('Total Registros: ${filterVotanteAux.length}     ')
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: localwidth * 0.001, vertical: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Informacion BD',
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('Respuesta Llamada ', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            const Divider(
              color: Color(0xffff004e),
            ),
            GetBuilder<MainController>(
                id: 'dropCallcenter',
                builder: (state) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: filterVotanteAux.length,
                      itemBuilder: (_, index) {
                        String? dropdownvalue;
                        if (filterVotanteAux[index].encuesta == true) {
                          dropdownvalue = 'Si';
                        } else {
                          dropdownvalue =
                              (filterVotanteAux[index].encuesta == false
                                  ? 'No'
                                  : 'No responde');
                        }

                        return ListTile(
                            subtitle: const Text('Telefono            Nombre'),
                            minVerticalPadding: 10,
                            leading: Text((index + 1).toString()),
                            title: Text(
                                "${filterVotanteAux[index].phone} ${filterVotanteAux[index].name}"),
                            trailing: SizedBox(
                              width: localwidth >= 800
                                  ? localwidth * 0.1
                                  : localwidth * 0.3,
                              child: DropdownButtonHideUnderline(
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
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: ['Si', 'No', 'No responde']
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  value: dropdownvalue,
                                  onChanged: (value) async {
                                    Get.dialog(
                                        LoadingAnimationWidget.newtonCradle(
                                            color: Colors.pink, size: 100));

                                    await mainController.updateEncuesta(
                                        filterVotanteAux[index].id,
                                        value == 'Si'
                                            ? true
                                            : (value == 'No' ? false : null));
                                    for (Votante element
                                        in mainController.filterVotante) {
                                      if (element.id ==
                                          filterVotanteAux[index].id) {
                                        filterVotanteAux[index].encuesta =
                                            element.encuesta;
                                      }
                                    }
                                    if (valuefilter != null) {
                                      bool? auxval = valuefilter == 'Si'
                                          ? true
                                          : (valuefilter == 'No'
                                              ? false
                                              : null);
                                      filterVotanteAux.value = mainController
                                          .filterVotante
                                          .where((p0) => p0.encuesta == auxval)
                                          .toList();
                                    }

                                    dropdownvalue = value!;
                                    state.update(["dropCallcenter"]);
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                  ),
                                  //This to clear the search value when you close the menu

                                  iconSize: 12,
                                  iconEnabledColor: Colors.grey,
                                  iconDisabledColor: Colors.grey,
                                  buttonHeight: 50,
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
                                  itemHeight: 36,
                                  itemPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
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
                            ));
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
