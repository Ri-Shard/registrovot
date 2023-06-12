import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:registrovot/ui/screens/getdata/consultarLideres_screen.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AgendaRegister extends StatefulWidget {
  AgendaRegister({Key? key}) : super(key: key);

  @override
  State<AgendaRegister> createState() => _AgendaRegisterState();
}

class _AgendaRegisterState extends State<AgendaRegister> {
  TextEditingController titulo = TextEditingController();

  TextEditingController descripcion = TextEditingController();

  TextEditingController horainicio = TextEditingController();

  TextEditingController horafinal = TextEditingController();

  final formkey = GlobalKey<FormState>();

  List<Appointment> appointmentslist = <Appointment>[];

  @override
  Widget build(BuildContext context) {
    double localwidth = MediaQuery.of(context).size.width;
    double localHeigth = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: localwidth * 0.1, vertical: localHeigth * 0.1),
        child: Center(
            child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                    future: mainController.getAgendas(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return LoadingAnimationWidget.newtonCradle(
                            color: Colors.pink, size: 100);
                      }
                      for (Appointment e in snapshot.data!) {
                        int r = 0 + Random().nextInt((255 + 1) - 0);
                        int g = 0 + Random().nextInt((255 + 1) - 0);
                        int b = 0 + Random().nextInt((255 + 1) - 0);
                        if (appointmentslist.firstWhereOrNull(
                                (element) => element.id == e.id) ==
                            null) {
                          appointmentslist.add(Appointment(
                            id: e.id,
                            startTime: e.startTime,
                            endTime: e.endTime,
                            subject: e.subject,
                            notes: e.notes,
                            color: Color.fromARGB(255, r, g, b),
                            startTimeZone: 'SA Pacific Standard Time',
                            endTimeZone: 'SA Pacific Standard Time',
                          ));
                        }
                      }
                      return SfCalendar(
                        onTap: (CalendarTapDetails details) {
                          DateTime date = details.date!;
                          Appointment? appoint;
                          if (details.appointments != null) {
                            appoint =
                                details.appointments!.first as Appointment;
                          }
                          CalendarElement view = details.targetElement;
                          showDialog(
                              context: context,
                              builder: (_) {
                                if (appoint == null) {
                                  return Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 150,
                                        height: 250,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Spacer(),
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            ),
                                            _textFormField(
                                                'Titulo',
                                                TextInputType.text,
                                                titulo,
                                                1,
                                                true),
                                            _textFormField(
                                                'Descripcion',
                                                TextInputType.number,
                                                descripcion,
                                                3,
                                                false),
                                            const Spacer(),
                                            TextButton(
                                              onPressed: () {
                                                DateTime now = DateTime.now();
                                                int r = 0 +
                                                    Random()
                                                        .nextInt((255 + 1) - 0);
                                                int g = 0 +
                                                    Random()
                                                        .nextInt((255 + 1) - 0);
                                                int b = 0 +
                                                    Random()
                                                        .nextInt((255 + 1) - 0);

                                                setState(() {
                                                  appointmentslist
                                                      .add(Appointment(
                                                    id: now.toString(),
                                                    startTime: date,
                                                    endTime: date.add(
                                                        const Duration(
                                                            minutes: 30)),
                                                    subject: titulo.text,
                                                    notes: descripcion.text,
                                                    color: Color.fromARGB(
                                                        255, r, g, b),
                                                    startTimeZone: '',
                                                    endTimeZone: '',
                                                  ));
                                                });
                                                titulo.clear();
                                                descripcion.clear();
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xffff004e),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 20,
                                                  horizontal: 10,
                                                ),
                                              ),
                                              child: const Text(
                                                'Registrar cita',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  titulo.text = appoint.subject;
                                  descripcion.text = appoint.notes!;
                                  return Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 150,
                                        height: 250,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Spacer(),
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Icon(
                                                      Icons.close,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            ),
                                            _textFormField(
                                                'Titulo',
                                                TextInputType.text,
                                                titulo,
                                                1,
                                                true),
                                            _textFormField(
                                                'Descripcion',
                                                TextInputType.number,
                                                descripcion,
                                                3,
                                                false),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    _deletelist(
                                                        appoint!.id.toString());
                                                    int r = 0 +
                                                        Random().nextInt(
                                                            (255 + 1) - 0);
                                                    int g = 0 +
                                                        Random().nextInt(
                                                            (255 + 1) - 0);
                                                    int b = 0 +
                                                        Random().nextInt(
                                                            (255 + 1) - 0);

                                                    setState(() {
                                                      appointmentslist
                                                          .add(Appointment(
                                                        id: appoint!.id,
                                                        startTime: date,
                                                        endTime:
                                                            appoint.endTime,
                                                        subject: titulo.text,
                                                        notes: descripcion.text,
                                                        color: Color.fromARGB(
                                                            255, r, g, b),
                                                        startTimeZone: '',
                                                        endTimeZone: '',
                                                      ));
                                                    });
                                                    titulo.clear();
                                                    descripcion.clear();
                                                    Navigator.pop(context);
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff01b9ff),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 20,
                                                      horizontal: 10,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Actualizar cita',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    _deletelist(
                                                        appoint!.id.toString());
                                                    mainController
                                                        .deleteAgenda(appoint);
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  },
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xffff004e),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 20,
                                                      horizontal: 10,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Eliminar cita',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              }).whenComplete(() {
                            titulo.clear();
                            descripcion.clear();
                          });
                        },
                        allowDragAndDrop: false,
                        allowAppointmentResize: true,
                        showCurrentTimeIndicator: true,
                        view: CalendarView.week,
                        dataSource: _getCalendarDataSource(),
                      );
                    })),
            TextButton(
              onPressed: () async {
                _showloading();
                for (var e in appointmentslist) {
                  await mainController.addAgenda(e);
                }
                await Future.delayed(Duration(seconds: 1)).whenComplete(() {
                  _stoploading();
                });
                AwesomeDialog(
                        width: 566,
                        context: context,
                        dialogType: DialogType.success,
                        animType: AnimType.rightSlide,
                        headerAnimationLoop: false,
                        title: 'Correcto',
                        desc: 'La agenda fue registrada correctamente',
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.cancel,
                        btnOkColor: const Color(0xff01b9ff))
                    .show();
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xffff004e),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
              ),
              child: const Text(
                'Registrar Agenda',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _textFormField(String labelText, TextInputType input,
      TextEditingController controller, int maxlines, bool autofocus) {
    return TextFormField(
      autofocus: autofocus,
      decoration: InputDecoration(labelText: labelText),
      maxLines: maxlines,
      keyboardType: input,
      controller: controller,
      validator: (_) {
        if (_ == null || _.isEmpty) {
          return "Debe llenar este campo";
        }
      },
      onChanged: (_) {},
    );
  }

  void _deletelist(String id) {
    for (var element in appointmentslist) {
      if (element.id == id) {
        appointmentslist.remove(element);
      }
    }
  }

  void _showloading() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: LoadingAnimationWidget.newtonCradle(
                color: Colors.pink, size: 100)));
  }

  void _stoploading() {
    Navigator.pop(context);
  }

  DataSource _getCalendarDataSource() {
    return DataSource(appointmentslist);
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
