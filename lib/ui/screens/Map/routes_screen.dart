import 'dart:html';

import 'package:excel/excel.dart';
import 'package:excel_to_json/excel_to_json.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => RoutesScreenState();
}

class RoutesScreenState extends State<RoutesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text("PRESS TO UPLOAD EXCEL AND CONVERT TO JSON"),
        onPressed: () async {
          String? excel = await ExcelToJson().convert();

          print(excel);
        },
      ),
    );
  }
}
