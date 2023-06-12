import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrovot/controller/mainController.dart';

class EncuestaView extends StatefulWidget {
  EncuestaView({super.key});

  @override
  State<EncuestaView> createState() => _EncuestaViewState();
}

class _EncuestaViewState extends State<EncuestaView> {
  final mainController = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: const Row(
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
          const Divider(
            color: Color(0xffff004e),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: mainController.filterVotante.length,
              itemBuilder: (_, index) {
                String dropdownvalue =
                    mainController.filterVotante[index].encuesta! ? 'Si' : 'No';
                return ListTile(
                    subtitle: Text('Telefono            Nombre'),
                    minVerticalPadding: 10,
                    title: Text(
                        "${mainController.filterVotante[index].phone} ${mainController.filterVotante[index].name}"),
                    trailing: Container(
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
                                mainController.filterVotante[index].id,
                                value == 'Si' ? true : false);
                            // Get.dialog(Container());
                            Get.back();
                            setState(() {
                              dropdownvalue = value!;
                            });
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
          ),
        ],
      ),
    );
  }
}
