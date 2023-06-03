import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:registrovot/controller/mainController.dart';
import 'package:registrovot/model/leader.dart';

class ConsultarLideresScreen extends StatefulWidget {
  const ConsultarLideresScreen({super.key});

  @override
  State<ConsultarLideresScreen> createState() => ConsultarLideresScreenState();
}

MainController mainController = Get.find();

class ConsultarLideresScreenState extends State<ConsultarLideresScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: mainController.getLeaders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 150,
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: const Icon(Icons.rocket),
                        trailing: Text(
                          snapshot.data![index].name!,
                        ),
                      );
                    }),
              ),
            );
          } else {
            return LoadingAnimationWidget.newtonCradle(
                color: Colors.pink, size: 100);
          }
        });
  }
}
