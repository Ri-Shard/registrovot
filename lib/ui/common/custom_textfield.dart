import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  String labelText;
  TextInputType input;
  TextEditingController controller;
  bool enable;

  CustomTextForm({
    Key? key,
    required this.labelText,
    required this.input,
    required this.controller,
    required this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _textFormField(labelText, input, controller, enable);
  }
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
    // validator: (_) {
    //   if (_ == null || _.isEmpty && labelText != 'Edad') {
    //     return "Debe llenar este campo";
    //   }
    //   if (labelText == 'Edad' && _.isNotEmpty) {
    //     if (int.parse(_) > 110 || int.parse(_) < 18) {
    //       return "número no válido";
    //     }
    //   }

    //   if (input == TextInputType.number && labelText != 'Edad') {
    //     if (_.length > 10) {
    //       return "número no válido";
    //     }
    //     if (_.length < 7) {
    //       return "número no válido";
    //     }
    //   }
    // },
    onChanged: (_) {},
  );
}
