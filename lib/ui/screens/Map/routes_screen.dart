import 'package:flutter/material.dart';

class RoutesScreen extends StatefulWidget {
  const RoutesScreen({super.key});

  @override
  State<RoutesScreen> createState() => RoutesScreenState();
}

class RoutesScreenState extends State<RoutesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Routes Screen'),
    );
  }
}
