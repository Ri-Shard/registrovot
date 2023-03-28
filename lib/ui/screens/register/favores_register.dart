import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:registrovot/ui/common/staticsFields.dart';

class FavoresRegister extends StatelessWidget {
  FavoresRegister({Key? key}) : super(key: key);

  TextEditingController nombre = TextEditingController();
  TextEditingController latitud = TextEditingController();
  TextEditingController longitud = TextEditingController();
  TextEditingController textEditingController = TextEditingController();
  StaticFields municipios = StaticFields();
  String? dropdownvalue;

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 40),
    //     child: Center(
    //         child: Column(
    //       children: [
    //         _textFormField('Nombre', TextInputType.text, nombre),
    //         _textFormField('Latitud', TextInputType.number, latitud),
    //         _textFormField('Longitud', TextInputType.number, longitud),
    //         const SizedBox(
    //           height: 20,
    //         ),
    //         Row(
    //           children: [
    //             const Text(
    //               'Municipio',
    //               style: TextStyle(
    //                 fontSize: 15,
    //               ),
    //             ),
    //             const SizedBox(
    //               width: 40,
    //             ),
    //             StatefulBuilder(builder: (context, setState) {
    //               return DropdownButtonHideUnderline(
    //                 child: DropdownButton2(
    //                   isExpanded: true,
    //                   hint: Row(
    //                     children: const [
    //                       Icon(
    //                         Icons.list,
    //                         size: 16,
    //                         color: Colors.grey,
    //                       ),
    //                       SizedBox(
    //                         width: 4,
    //                       ),
    //                       Expanded(
    //                         child: Text(
    //                           'Seleccione',
    //                           style: TextStyle(
    //                             fontSize: 14,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.grey,
    //                           ),
    //                           overflow: TextOverflow.ellipsis,
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   items: municipios
    //                       .getMunicipios()
    //                       .map((item) => DropdownMenuItem<String>(
    //                             value: item.nombre,
    //                             child: Text(
    //                               item.nombre!,
    //                               style: const TextStyle(
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.bold,
    //                                 color: Colors.grey,
    //                               ),
    //                               overflow: TextOverflow.ellipsis,
    //                             ),
    //                           ))
    //                       .toList(),
    //                   value: dropdownvalue,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       dropdownvalue = value as String;
    //                     });
    //                   },
    //                   icon: const Icon(
    //                     Icons.arrow_forward_ios_outlined,
    //                   ),
    //                   searchController: textEditingController,
    //                   searchInnerWidgetHeight: 50,
    //                   searchInnerWidget: Container(
    //                     height: 50,
    //                     padding: const EdgeInsets.only(
    //                       top: 8,
    //                       bottom: 4,
    //                       right: 8,
    //                       left: 8,
    //                     ),
    //                     child: TextFormField(
    //                       expands: true,
    //                       maxLines: null,
    //                       controller: textEditingController,
    //                       decoration: InputDecoration(
    //                         isDense: true,
    //                         contentPadding: const EdgeInsets.symmetric(
    //                           horizontal: 10,
    //                           vertical: 8,
    //                         ),
    //                         hintText: 'Busca un municipio',
    //                         hintStyle: const TextStyle(fontSize: 12),
    //                         border: OutlineInputBorder(
    //                           borderRadius: BorderRadius.circular(8),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   searchMatchFn: (item, searchValue) {
    //                     return (item.value.toString().contains(searchValue));
    //                   },

    //                   //This to clear the search value when you close the menu
    //                   onMenuStateChange: (isOpen) {
    //                     if (!isOpen) {
    //                       textEditingController.clear();
    //                     }
    //                   },
    //                   iconSize: 14,
    //                   iconEnabledColor: Colors.grey,
    //                   iconDisabledColor: Colors.grey,
    //                   buttonHeight: 50,
    //                   buttonWidth: 300,
    //                   buttonPadding: const EdgeInsets.only(left: 14, right: 14),
    //                   buttonDecoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(14),
    //                     border: Border.all(
    //                       color: Colors.black26,
    //                     ),
    //                     color: Colors.white,
    //                   ),
    //                   buttonElevation: 2,
    //                   itemHeight: 40,
    //                   itemPadding: const EdgeInsets.only(left: 14, right: 14),
    //                   dropdownMaxHeight: 200,
    //                   dropdownWidth: 200,
    //                   dropdownPadding: null,
    //                   dropdownDecoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(14),
    //                     color: Colors.white,
    //                   ),
    //                   dropdownElevation: 8,
    //                   scrollbarRadius: const Radius.circular(40),
    //                   scrollbarThickness: 6,
    //                   scrollbarAlwaysShow: true,
    //                   offset: const Offset(-20, 0),
    //                 ),
    //               );
    //             }),
    //           ],
    //         ),
    //         const SizedBox(
    //           height: 20,
    //         ),
    //         TextButton(
    //           onPressed: () {},
    //           style: TextButton.styleFrom(
    //             backgroundColor: const Color(0xffff004e),
    //             padding: const EdgeInsets.symmetric(
    //               vertical: 20,
    //               horizontal: 10,
    //             ),
    //           ),
    //           child: const Text(
    //             'Registrar puesto',
    //             style: TextStyle(
    //               fontSize: 15,
    //               color: Colors.white,
    //               fontWeight: FontWeight.w600,
    //             ),
    //           ),
    //         ),
    //       ],
    //     )),
    //   ),
    // );
    return const Center(
      child: Text('Registro Favores'),
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
