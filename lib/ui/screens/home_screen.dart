import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrovot/service/authentication.dart';
import 'package:registrovot/ui/common/layouts/logindesktop_screen.dart';
import 'package:registrovot/ui/common/leftpannel/left_pane_widget.dart';
import 'package:registrovot/ui/screens/Map/map_screen.dart';
import 'package:registrovot/ui/screens/Map/routes_screen.dart';
import 'package:registrovot/ui/screens/getdata/consultarLideres_screen.dart';
import 'package:registrovot/ui/screens/getdata/consultarPuestos_screen.dart';
import 'package:registrovot/ui/screens/getdata/downloadDB_screen.dart';
import 'package:registrovot/ui/screens/register/agenda_register.dart';
import 'package:registrovot/ui/screens/register/favores_register.dart';
import 'package:registrovot/ui/screens/register/leaders_register.dart';
import 'package:registrovot/ui/screens/register/places_register.dart';
import 'package:registrovot/ui/screens/register/user_register.dart';

import '../../controller/mainController.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  MainController mainController = Get.find();

  Authentication authentication = Authentication();
  List<Widget> views = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 10),
                  height: 80,
                  width: 250,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(40)),
                    color: Colors.black,
                  ),
                  child: Image.asset('assets/images/vco_logo.png'),
                ),
                Builder(builder: (context) {
                  return Expanded(
                    child: Container(
                        decoration: const BoxDecoration(color: Colors.black),
                        width: 250,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                _materialButton('Registro Base de Datos',
                                    Icons.person_2_outlined, 0),
                                _materialButton('Descargar Archivo BD',
                                    Icons.download_outlined, 1),
                                _materialButton('Agenda', Icons.date_range, 2),
                                _materialButton('Registro de Lideres',
                                    Icons.rocket_launch_outlined, 3),
                                _materialButton('Informacion Lideres',
                                    Icons.info_outline, 4),
                                _materialButton('Registro de Puestos',
                                    Icons.place_outlined, 5),
                                _materialButton('Informacion de Puestos',
                                    Icons.info_outline, 6),
                                _materialButton(
                                    'Rutas', Icons.route_outlined, 7),
                                _materialButton('Mapas', Icons.map_outlined, 8),
                                _materialButton('Favores',
                                    Icons.featured_video_outlined, 9),
                                const Spacer(),
                                MaterialButton(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  color: const Color(0xffff004e),
                                  onPressed: () {
                                    AwesomeDialog(
                                            width: 566,
                                            context: context,
                                            dialogType: DialogType.info,
                                            animType: AnimType.rightSlide,
                                            headerAnimationLoop: false,
                                            title: '¿Seguro que desea salir?',
                                            desc: 'asd',
                                            btnCancelOnPress: () {
                                              Navigator.pop(context);
                                            },
                                            btnOkOnPress: () {
                                              authentication.signOut();
                                              Navigator.pushReplacement(context,
                                                  CupertinoPageRoute(
                                                      builder: (_) {
                                                return const LoginScreen();
                                              }));
                                            },
                                            btnOkIcon: Icons.cancel,
                                            btnOkColor: const Color(0xffff004e))
                                        .show();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      Icon(
                                        Icons.logout_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Cerrar Sesion',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                          ],
                        )),
                  );
                }),
              ],
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(40)),
                    color: Colors.black,
                  ),
                  height: 80,
                  child: Row(),
                ),
                Expanded(
                    child: Center(
                  child: views[index],
                ))
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _materialButton(String text, IconData icon, int indx) {
    return Visibility(
        child: MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      color: index == indx ? const Color(0xffff004e) : null,
      onPressed: () {
        index = indx;
        setState(() {});
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ));
  }
}
