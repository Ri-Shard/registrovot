import 'package:flutter/material.dart';

class DownloadDBScreen extends StatefulWidget {
  const DownloadDBScreen({super.key});

  @override
  State<DownloadDBScreen> createState() => DownloadDBScreenState();
}

class DownloadDBScreenState extends State<DownloadDBScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Descargar BD'),
    );
  }
}
