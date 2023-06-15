import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => RoutesScreenState();
}

class RoutesScreenState extends State<RoutesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            var file = './Consolidado_cargue_ernesto.xlsx';
            var bytes = File(file).readAsBytesSync();
            var excel = Excel.decodeBytes(bytes);

            for (var table in excel.tables.keys) {
              print(table); //sheet Name
              print(excel.tables[table]!.maxCols);
              print(excel.tables[table]!.maxRows);
              for (var row in excel.tables[table]!.rows) {
                print('$row');
              }
            }
          },
          child: Text('Subir Excel')),
    );
  }
}
