import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/votante.dart';

class EncuestaView extends StatefulWidget {
  EncuestaView({super.key});

  @override
  State<EncuestaView> createState() => _EncuestaViewState();
}

class _EncuestaViewState extends State<EncuestaView> {
  final mainController = Get.find<MainController>();
  RxList<Votante> searchvotante = <Votante>[].obs;
  RxList<Votante> listaaux = <Votante>[].obs;
  TextEditingController cedula = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    double localHeigth = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Informacion BD',
                  style: TextStyle(fontSize: 20),
                ),
                Text('Respuesta Llamada', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          SizedBox(
              width: localwidth >= 800 ? localwidth * 0.24 : localwidth * 0.67,
              child: Container(
                child: GetBuilder<MainController>(
                    id: 'dropCedulaView',
                    builder: (state) {
                      return InkWell(
                        onTap: () {
                          // searchvotante.clear();
                          searchvotante.value = mainController.filterVotante;
                          Get.dialog(Container(
                            margin: EdgeInsets.symmetric(
                              vertical: localHeigth * 0.2,
                              horizontal: localwidth * 0.1,
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Obx(() {
                                return Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: TextField(
                                        autofocus: true,
                                        decoration: const InputDecoration(
                                            hintText: "Nombre de.."),
                                        controller: cedula,
                                        onChanged: (_) {
                                          searchvotante.value = mainController
                                              .filterVotante
                                              .where((element) => element
                                                  .toJson()
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(_.toLowerCase()))
                                              .toList();
                                          state.update(["dropCedulaView"]);
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text('Seleccionar Resultado'),
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount: (searchvotante.isEmpty &&
                                                    cedula.text.isNum &&
                                                    cedula.text.length >= 6 &&
                                                    cedula.text.length <= 11)
                                                ? 1
                                                : searchvotante.length,
                                            itemBuilder: (b, index) {
                                              if (searchvotante.isEmpty &&
                                                  cedula.text.isNum &&
                                                  cedula.text.length >= 6) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 20),
                                                      width: 200,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        style: TextButton
                                                            .styleFrom(
                                                          fixedSize: const Size(
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
                                                            'Agregar',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
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
                                                  listaaux.clear();
                                                  cedula.text =
                                                      searchvotante[index].id;
                                                  // valueLeader2 = filterMunicipio[index];
                                                  listaaux.add(
                                                      searchvotante[index]);
                                                  state.update(
                                                      ["dropCedulaView"]);
                                                  Get.back();
                                                },
                                                title: Text(
                                                    "${searchvotante[index].id} ${searchvotante[index].name}"),
                                              );
                                            })),
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        style: TextButton.styleFrom(
                                          fixedSize: const Size(120, 40),
                                          backgroundColor:
                                              const Color(0xffff004e),
                                          padding: const EdgeInsets.symmetric(
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
                                              fontWeight: FontWeight.w600,
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

                            if (_.length > 10) {
                              return "número no válido";
                            }
                            if (_.length < 7) {
                              return "número no válido";
                            }
                          },
                          onChanged: (_) {},
                        ),
                      );
                    }),
              )),
          const Divider(
            color: Color(0xffff004e),
          ),
          GetBuilder<MainController>(
              id: 'dropCedulaView',
              builder: (state) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: listaaux.length,
                    itemBuilder: (__, index) {
                      String dropdownvalue =
                          listaaux[index].encuesta! ? 'Si' : 'No';
                      return ListTile(
                          subtitle: const Text('Telefono            Nombre'),
                          minVerticalPadding: 10,
                          title: Text(
                              "${listaaux[index].phone} ${listaaux[index].name}"),
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
                                items: ['Si', 'No']
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
                                  Get.dialog(const Dialog());
                                  await mainController.updateEncuesta(
                                      listaaux[index].id,
                                      value == 'Si' ? true : false);
                                  dropdownvalue = value!;
                                  state.update(["dropCedulaView"]);
                                  // Get.dialog(Container());
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
                          ));
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
