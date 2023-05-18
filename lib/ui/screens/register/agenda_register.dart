import 'dart:async';
import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 40),
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
                          dynamic appointments = details.appointments;
                          CalendarElement view = details.targetElement;
                          showDialog(
                              context: context,
                              builder: (_) {
                                return Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 150,
                                      height: 200,
                                      child: Column(
                                        children: [
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
                                          TextButton(
                                            onPressed: () {
                                              String now =
                                                  DateTime.now().toString();

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
                                                  id: now,
                                                  startTime: date,
                                                  endTime: date.add(
                                                      const Duration(hours: 1)),
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
                                              'Registrar agenda',
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
                              });
                        },
                        allowDragAndDrop: true,
                        allowAppointmentResize: true,
                        showCurrentTimeIndicator: true,
                        view: CalendarView.week,
                        dataSource: _getCalendarDataSource(),
                      );
                    })),
            TextButton(
              onPressed: () {
                _showloading();
                Timer(const Duration(seconds: 1), () => _stoploading());
                for (var e in appointmentslist) {
                  mainController.addAgenda(e);
                }
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
                'Registrar Todas',
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
