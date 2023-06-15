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
    double localwidth = MediaQuery.of(context).size.width;
    double fontSize = localwidth >= 800 ? 20 : 14;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  localwidth >= 800
                      ? 'Nombre Lider o Responsable'
                      : 'Nombre Lider',
                  style: TextStyle(
                    fontSize: fontSize,
                  )),
              Text('Cantidad Registros', style: TextStyle(fontSize: fontSize)),
              Text('Opcion ver', style: TextStyle(fontSize: fontSize)),
            ],
          ),
        ),
        const Divider(
          color: Color(0xffff004e),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: mainController.filterLeader.length,
              itemBuilder: (_, index) {
                Map aux = {};
                int cont = 0;
                for (var leader in mainController.filterLeader) {
                  for (var votante in mainController.filterVotante) {
                    if (leader.id == votante.leaderID) {
                      cont += 1;
                    }
                    aux[leader.id] = cont;
                  }
                  cont = 0;
                }
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mainController.filterLeader[index].name!,
                        textAlign: TextAlign.right,
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            right: localwidth >= 800
                                ? localwidth * 0.3
                                : localwidth * 0.3),
                        child: Text(
                          aux[mainController.filterLeader[index].id!]
                              .toString(),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          fixedSize: const Size(50, 40),
                          backgroundColor: const Color(0xffff004e),
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                        ),
                        child: const SizedBox(
                          child: Text(
                            'Ver',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
