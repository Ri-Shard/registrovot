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
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  bool mobile = false;

  MainController mainController = Get.find();

  String _label = 'Registro Base de Datos';

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
  List<String> labels = [
    'Registro Base de Datos',
    'Descargar Archivo BD',
    'Agenda',
    'Registro de Lideres',
    'Informacion Lideres',
    'Registro de Puestos',
    'Informacion de Puestos',
    'Rutas',
    'Mapas',
    'Compromisos',
    'Call Center'
  ];

  @override
  void initState() {
    super.initState();
    buttons = mainController.listviews;
    index = buttons.indexWhere((element) => element);
    _label = labels[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 1,
                  child: StreamBuilder(
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
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    // margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    height: 60,
                    child: Row(
                      children: [
                        GetBuilder<MainController>(
                            id: 'principalView',
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Text(
                                  _label,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              );
                            }),
                        StreamBuilder(
                            stream: mainController.getPuestos(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                mainController.filterPuesto.clear();
                                for (var i = 0;
                                    i < snapshot.data!.length;
                                    i++) {
                                  mainController.filterPuesto
                                      .add(snapshot.data![i]);
                                }
                                mainController.getVotantes();
                              }
                              return const SizedBox();
                            }),
                        const Spacer(),
                        MediaQuery.of(context).size.width < 800
                            ? IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  mobile = true;
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext con) {
                                      return Dialog(
                                        child: _menu(con),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.menu))
                            : const SizedBox()
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  MediaQuery.of(context).size.width >= 800
                      ? Expanded(flex: 1, child: _menu(context))
                      : const SizedBox(height: 10),
                  Expanded(
                    flex: 4,
                    child: GetBuilder<MainController>(
                        id: 'principalView',
                        builder: (context) {
                          return Center(
                            child: views[index],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _materialButton(String text, IconData icon, int indx, bool visible) {
    return Visibility(
      visible: visible,
      child: InkWell(
        onTap: () {
          _ontapButton(text, indx);
        },
        child: Container(
          height: 55,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          color: index == indx ? Colors.grey.shade300 : null,
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _menu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade100),
      width: 250,
      child: GetBuilder<MainController>(
          id: 'principalView',
          builder: (_) {
            return ListView(
              children: [
                const SizedBox(height: 30),
                _materialButton(labels[0], Icons.person, 0, buttons[0]),
                _materialButton(
                    labels[1], Icons.download_outlined, 1, buttons[1]),
                _materialButton(labels[2], Icons.date_range, 2, buttons[2]),
                _materialButton(
                    labels[3], Icons.rocket_launch_outlined, 3, buttons[3]),
                _materialButton(labels[4], Icons.info_outline, 4, buttons[4]),
                _materialButton(labels[5], Icons.place_outlined, 5, buttons[5]),
                _materialButton(labels[6], Icons.info_outline, 6, buttons[6]),
                _materialButton(labels[7], Icons.route_outlined, 7, buttons[7]),
                _materialButton(labels[8], Icons.map_outlined, 8, buttons[8]),
                _materialButton(
                    labels[9], Icons.featured_video_outlined, 9, buttons[9]),
                _materialButton(labels[10], Icons.phone, 10, buttons[10]),
                MaterialButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  color: const Color(0xffff004e),
                  onPressed: () {
                    AwesomeDialog(
                      width: 566,
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      headerAnimationLoop: false,
                      title: '¿Seguro que desea cerrar sesion?',
                      btnCancelText: 'Cancelar',
                      btnOkText: 'Salir',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {
                        authentication.signOut();
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(builder: (_) {
                            return const LoginScreen();
                          }),
                        );
                      },
                      btnOkIcon: Icons.cancel,
                      btnOkColor: const Color(0xffff004e),
                    ).show();
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Cerrar Sesion',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }

  _ontapButton(String text, int indx) {
    _label = text;
    index = indx;
    if (mobile) {
      Get.back();
    }
    mainController.update(['principalView']);
  }
}
