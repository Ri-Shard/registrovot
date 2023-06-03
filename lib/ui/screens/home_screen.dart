import 'dart:ui';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrovot/service/authentication.dart';
import 'package:registrovot/ui/common/layouts/logindesktop_screen.dart';
import 'package:registrovot/ui/screens/Map/map_screen.dart';
import 'package:registrovot/ui/screens/Map/routes_screen.dart';
import 'package:registrovot/ui/screens/getdata/consultarLideres_screen.dart';
import 'package:registrovot/ui/screens/getdata/consultarPuestos_screen.dart';
import 'package:registrovot/ui/screens/getdata/downloadDB_screen.dart';
import 'package:registrovot/ui/screens/register/agenda_register.dart';
import 'package:registrovot/ui/screens/register/encuesta_register.dart';
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
  List<bool> buttons = [];
  List<Widget> views = [
    UserRegister(),
    const DownloadDBScreen(),
    AgendaRegister(),
    LeadersRegister(),
    const ConsultarLideresScreen(),
    PlacesRegister(),
    const ConsultarPuestosScreen(),
    const RoutesScreen(),
    const MapScreen(),
    FavoresRegister(),
    EncuestaView()
  ];

  @override
  Widget build(BuildContext context) {
    buttons = mainController.listviews;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StreamBuilder(
                    stream: mainController.getLeaders(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        mainController.filterLeader.clear();
                        for (var i = 0; i < snapshot.data!.length; i++) {
                          mainController.filterLeader.add(snapshot.data![i]);
                        }
                      }

                      return Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        // margin: const EdgeInsets.only(top: 10),
                        height: 60,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                        ),
                        child: Image.asset('assets/images/vco_logo.png'),
                      );
                    }),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade100),
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
                                  Icons.person, 0, buttons[0]),
                              _materialButton('Descargar Archivo BD',
                                  Icons.download_outlined, 1, buttons[1]),
                              _materialButton(
                                  'Agenda', Icons.date_range, 2, buttons[2]),
                              _materialButton('Registro de Lideres',
                                  Icons.rocket_launch_outlined, 3, buttons[3]),
                              _materialButton('Informacion Lideres',
                                  Icons.info_outline, 4, buttons[4]),
                              _materialButton('Registro de Puestos',
                                  Icons.place_outlined, 5, buttons[5]),
                              _materialButton('Informacion de Puestos',
                                  Icons.info_outline, 6, buttons[6]),
                              _materialButton(
                                  'Rutas', Icons.route_outlined, 7, buttons[7]),
                              _materialButton(
                                  'Mapas', Icons.map_outlined, 8, buttons[8]),
                              _materialButton('Favores',
                                  Icons.featured_video_outlined, 9, buttons[9]),
                              _materialButton(
                                  'Call Center',
                                  Icons.featured_video_outlined,
                                  10,
                                  buttons[10]),
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
                                          title:
                                              '¿Seguro que desea cerrar sesion?',
                                          btnCancelText: 'Cancelar',
                                          btnOkText: 'Salir',
                                          btnCancelOnPress: () {},
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
                                child: const Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
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
                )
              ],
            ),
            Expanded(
                child: Column(
              children: [
                Container(
                  // margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  height: 60,
                  child: Row(
                    children: [
                      StreamBuilder(
                          stream: mainController.getVotantes(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              mainController.filterVotante.clear();
                              for (var i = 0; i < snapshot.data!.length; i++) {
                                mainController.filterVotante
                                    .add(snapshot.data![i]);
                              }
                            }
                            return SizedBox();
                          })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
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

  Widget _materialButton(String text, IconData icon, int indx, bool visible) {
    return Visibility(
        visible: visible,
        child: MaterialButton(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          color: index == indx ? Colors.grey.shade300 : null,
          onPressed: () {
            index = indx;
            setState(() {});
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                icon,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ));
  }
}
