// ignore: file_names
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:registrovot/model/favores.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/model/votante.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:firebase_database/firebase_database.dart';

class MainController extends GetxController {
  FirebaseDatabase database = FirebaseDatabase.instance;
  final _auth = FirebaseAuth.instance;
  int indexMainPage = 0;
  List<bool> listviews = [];
  String? collection;
  String emailUser = '';
  RxList<Leader> filterLeader = <Leader>[].obs;
  RxList<Votante> filterVotante = <Votante>[].obs;
  RxList<Favores> filterFavores = <Favores>[].obs;
  List<Votante> auxvot = [];

  RxList<Puesto> filterPuesto = <Puesto>[].obs;

  Future<User?> getFirebaseUser() async {
    User? firebaseUser = _auth.currentUser;
    firebaseUser ??= await _auth.authStateChanges().first;

    if (firebaseUser != null) defineViews(firebaseUser.email!);
    return firebaseUser;
  }

  List<Votante> getEncuesta() {
    List<Votante> auxContSI = [];
    filterVotante.forEach((element) {
      if (element.encuesta == 'Si') {
        auxContSI.add(element);
      }
    });
    return auxContSI;
  }

  List<bool> defineViews(String email) {
    emailUser = email;
    collection = email.split('@').last.split('.').first;
    if (email.contains('candidato')) {
      listviews = [
        true,
        true,
        false,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true
      ];
      return listviews;
    } else if (email.contains('director')) {
      listviews = [
        true,
        true,
        false,
        true,
        true,
        true,
        false,
        true,
        false,
        true,
        true,
        true
      ];
      return listviews;
    } else if (email.contains('secre')) {
      listviews = [
        true,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        true,
        false,
        false
      ];
      return listviews;
    } else if (email.contains('userregistro.registro@quiroz.com')) {
      listviews = [
        true,
        true,
        false,
        true,
        true,
        true,
        true,
        false,
        false,
        false,
        true,
        true
      ];
      return listviews;
    } else if (email.contains('griselda.registro@registro.com') ||
        email.contains('melissa.registro@quiroz.com') ||
        email.contains('paola.registro@asambleapana.com')) {
      listviews = [
        true,
        true,
        false,
        true,
        true,
        true,
        true,
        false,
        false,
        false,
        false,
        true
      ];
      return listviews;
    } else if (email.contains('regcallcom')) {
      listviews = [
        true,
        false,
        false,
        true,
        false,
        true,
        false,
        false,
        false,
        true,
        true,
        false
      ];
      return listviews;
    } else if (email.contains('regcall')) {
      listviews = [
        true,
        true,
        false,
        true,
        true,
        true,
        true,
        false,
        false,
        false,
        true,
        false
      ];
      return listviews;
    } else if (email.contains('registro')) {
      listviews = [
        true,
        false,
        false,
        true,
        false,
        true,
        false,
        false,
        false,
        false,
        false,
        false
      ];
      return listviews;
    } else if (email.contains('gerente')) {
      listviews = [
        true,
        true,
        false,
        true,
        true,
        true,
        true,
        true,
        false,
        true,
        true,
        true
      ];
      return listviews;
    } else if (email.contains('asistente')) {
      listviews = [
        true,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        true,
        false,
        false
      ];
      return listviews;
    } else if (email.contains('callcenter')) {
      listviews = [
        true,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        true,
        false
      ];
      return listviews;
    } else if (email.contains('coordinador')) {
      listviews = [
        true,
        true,
        false,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true
      ];
      return listviews;
    }
    return listviews;
  }

//LEADER METHODS
  Future<String?> addLeader(Leader leader) async {
    String response = '';
    CollectionReference colection;
    final exist = await getoneLeader(leader.id!);
    if (exist != null) {
      response = 'Ya Existe';
      return response;
    } else {
      colection = FirebaseFirestore.instance.collection(collection!);
      colection.doc('lideres').set(
        {
          leader.id.toString(): {
            'id': leader.id.toString(),
            'name': leader.name,
            'phone': leader.phone,
            'municipio': leader.municipio,
            'coordinador': leader.coordinador,
            'estado': 'activo'
          }
        },
        SetOptions(merge: true),
      ).then((value) {
        response = "Lider registrado";
        return response;
      }).catchError((error) {
        response = "Error al agregar el lider: $error";
        return response;
      });
    }

    return response;
  }

  Future<String?> updateLeader(Leader leader) async {
    String response = '';
    CollectionReference colection;
    try {
      colection = FirebaseFirestore.instance.collection(collection!);
      colection.doc('lideres').set(
        {
          leader.id.toString(): {
            'id': leader.id.toString(),
            'name': leader.name,
            'phone': leader.phone,
            'municipio': leader.municipio,
            'estado': 'activo',
            'coordinador': leader.coordinador,
          }
        },
        SetOptions(merge: true),
      );
      response = "Lider Actualizado";
      return response;
    } catch (e) {
      response = "Error al actualizar el lider: $e";
      return response;
    }
  }

  Stream<List<Leader>> getLeaders() {
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    return colection.doc('lideres').snapshots().asyncMap((event) {
      List<Leader> leaderAux = [];
      Map<dynamic, dynamic> data = event.data() as Map<dynamic, dynamic>;
      data.forEach((key, value) {
        if (value['estado'] == 'activo') {
          Leader leader = Leader(
              name: value['name'],
              id: value['id'],
              phone: value['phone'],
              municipio: value['municipio'],
              coordinador: value['coordinador'],
              estado: value['estado']);
          leaderAux.add(leader);
        }
      });
      return leaderAux;
    });
  }

  Leader? getoneLeader(String idLeader) {
    Leader? leader;
    if (filterLeader.isNotEmpty) {
      leader =
          filterLeader.firstWhereOrNull((element) => element.id == idLeader);
      return leader;
    }
    return leader;
  }

  String? deleteLeaders(String id) {
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    colection.doc('lideres').update({id: FieldValue.delete()}).then((value) {
      return "Eliminado con exito";
    }).catchError((error) {
      return "Error al eliminar";
    });
    return 'null';
  }

  //USER METHODS
  Future<String> addVotante(Votante votante) async {
    String response = '';
    CollectionReference colection;
    Votante? exist = getoneVotante(votante.id);
    if (exist != null) {
      response = 'Ya Existe';
      return response;
    } else {
      try {
        colection = FirebaseFirestore.instance.collection(collection!);
        await colection.doc('usuarios').set(
          {
            votante.id.toString(): {
              'id': votante.id.toString(),
              'name': votante.name,
              'phone': votante.phone,
              'leaderID': votante.leaderID,
              'puestoID': votante.puestoID,
              'direccion': votante.direccion,
              'edad': votante.edad,
              'municipio': votante.municipio,
              'barrio': votante.barrio,
              'estado': 'activo',
              'encuesta': 'No',
            }
          },
          SetOptions(merge: true),
        );
        response = "Usuario registrado";
      } catch (e) {
        auxvot.add(votante);
        response = "Error al agregar el Usuario: $e";
      }
    }

    return response;
  }

  Future<String?> updateVotante(Votante votante) async {
    String response = '';
    CollectionReference colection;

    colection = FirebaseFirestore.instance.collection(collection!);
    colection.doc('usuarios').set(
      {
        votante.id: {
          'id': votante.id,
          'name': votante.name,
          'phone': votante.phone,
          'leaderID': votante.leaderID,
          'puestoID': votante.puestoID,
          'direccion': votante.direccion,
          'edad': votante.edad,
          'municipio': votante.municipio,
          'barrio': votante.barrio,
          'estado': votante.estado,
          'encuesta': votante.encuesta,
        }
      },
      SetOptions(merge: true),
    ).then((value) {
      response = "Usuario actualizado";
      return response;
    }).catchError((error) {
      response = "Error al actualizar  el Usuario: $error";
      return response;
    });

    return response;
  }

  getVotantes() {
    // CollectionReference colection;
    DatabaseReference ref =
        FirebaseDatabase.instance.ref().child('$collection');
    // colection = FirebaseFirestore.instance.collection(collection!);
    // return colection.doc('usuarios').snapshots().asyncMap((event)
    try {
      return ref.onValue.listen((event) {
        Map<dynamic, dynamic>? dataid =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (dataid != null) {
          filterVotante.clear();
          dataid.forEach((key, value) {
            if (value['estado'] == 'activo') {
              Votante votante = Votante(
                  name: value['name'],
                  id: value['id'],
                  phone: value['phone'],
                  leaderID: value['leaderID'],
                  direccion: value['direccion'],
                  edad: value['edad'],
                  municipio: value['municipio'],
                  barrio: value['barrio'],
                  puestoID: value['puestoID'],
                  estado: value['estado'],
                  encuesta: value['encuesta'],
                  mesa: value['mesa'],
                  sexo: value['sexo'],
                  segmento: value['segmento'],
                  responsable: value['responsable']);
              filterVotante.add(votante);
            }
          });
        }
      });
    } catch (e) {}
  }

  Votante? getoneVotante(String idVotante) {
    Votante? votanteaux;
    if (filterVotante.isNotEmpty) {
      votanteaux =
          filterVotante.firstWhereOrNull((element) => element.id == idVotante);
      return votanteaux;
    }
    return votanteaux;
  }

//USER REALTIME TRY
  Future<String?> updateVotante2(Votante votante) async {
    String response = '';

    try {
      DatabaseReference ref = FirebaseDatabase.instance
          .ref()
          .child('$collection/${votante.id.toString()}');
      await ref.update({
        'name': votante.name,
        'phone': votante.phone,
        'leaderID': votante.leaderID,
        'puestoID': votante.puestoID,
        'direccion': votante.direccion,
        'edad': votante.edad,
        'municipio': votante.municipio,
        'barrio': votante.barrio,
        'estado': 'activo',
        'id': votante.id.toString(),
        'encuesta': votante.encuesta,
        'responsable': getResponsable(votante.responsable),
        'mesa': votante.mesa,
        'sexo': votante.sexo,
        'segmento': votante.segmento,
      });
    } catch (e) {
      response = "Error al Actualizar el Usuario: $e";
    }
  }

  updateEncuesta(String id, String encuesta, Votante votante) async {
    String response = '';

    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child('$collection/${id.toString()}');
      await ref.update({
        'encuesta': encuesta,
        'responsable': getResponsable(votante.responsable),
      });

      response = "Encuesta actualizada";
    } catch (e) {
      // auxvot.add(votante);
      response = "Error al Actualizar el Usuario: $e";
    }

    return response;
  }

  void try3() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.remove();
  }

  Future<String> addVotante2(Votante votante) async {
    String response = '';
    String dateNow =
        '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}-${DateTime.now().hour}:${DateTime.now().minute}';
    Votante? exist = getoneVotante(votante.id);
    if (exist != null) {
      response = 'Ya Existe';
      return response;
    } else {
      try {
        DatabaseReference ref = FirebaseDatabase.instance
            .ref()
            .child('$collection/${votante.id.toString()}');
        await ref.set({
          'id': votante.id.toString(),
          'name': votante.name,
          'phone': votante.phone,
          'leaderID': votante.leaderID,
          'puestoID': votante.puestoID,
          'direccion': votante.direccion,
          'edad': votante.edad,
          'municipio': votante.municipio,
          'barrio': votante.barrio,
          'estado': 'activo',
          'encuesta': votante.encuesta,
          'responsable': '$emailUser#$dateNow)',
          'mesa': votante.mesa,
          'sexo': votante.sexo,
          'segmento': votante.segmento,
        });

        response = "Usuario registrado";
      } catch (e) {
        // auxvot.add(votante);
        response = "Error al agregar el Usuario: $e";
      }

      return response;
    }
  }

//PUESTO METHODS
  Future<String?> addPuesto(Puesto puesto) async {
    String response = '';
    CollectionReference colection;
    final exist = getonePuesto(puesto.id!);
    if (exist != null) {
      response = 'Ya Existe';
      return response;
    } else {
      colection = emailUser.contains('@edil.com')
          ? FirebaseFirestore.instance.collection('locationCarta')
          : FirebaseFirestore.instance.collection('location');
      colection.doc('puestos').set(
        {
          puesto.id.toString(): {
            'id': puesto.id.toString(),
            'nombre': puesto.nombre,
            'latitud': puesto.latitud,
            'longitud': puesto.longitud,
            'municipio': puesto.municipio,
            'direccion': puesto.direccion,
            'estado': puesto.estado,
          }
        },
        SetOptions(merge: true),
      ).then((_) {
        response = "Usuario registrado";
        return response;
      }).catchError((error) {
        response = "Error al agregar el Usuario: $error";
        return response;
      });
    }

    return response;
  }

  Stream<List<Puesto>> getPuestos() {
    CollectionReference colection;
    colection = emailUser.contains('@edil.com')
        ? FirebaseFirestore.instance.collection('locationCarta')
        : FirebaseFirestore.instance.collection('location');
    return colection.doc('puestos').snapshots().asyncMap((event) {
      List<Puesto> aux = [];
      Map<dynamic, dynamic> dataid = event.data() as Map<dynamic, dynamic>;
      dataid.forEach((key, value) {
        Puesto puesto = Puesto(
            nombre: value['nombre'],
            id: key.toString(),
            latitud: value?['latitud'],
            longitud: value['longitud'],
            direccion: value['direccion'],
            municipio: value['municipio'],
            estado: value['estado'] ?? "-");

        aux.add(puesto);
      });
      return aux;
    });
  }

  Puesto? getonePuesto(String idPuesto) {
    Puesto? puesto;
    if (filterPuesto.isNotEmpty) {
      puesto =
          filterPuesto.firstWhereOrNull((element) => element.id == idPuesto);
      return puesto;
    }
    return puesto;
  }

  void anotheraddpuesto(String id, Map puesto) async {
    CollectionReference colection;

    colection = FirebaseFirestore.instance.collection('locationCarta');
    colection
        .doc('puestos')
        .set(
          {id: puesto},
          SetOptions(merge: true),
        )
        .then((value) {})
        .catchError((error) {});
  }

  //Agenda Methods
  Future<String?> addAgenda(Appointment appointment) async {
    String response = '';
    // User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    colection.doc('agenda').set(
      {
        appointment.id.toString(): {
          'id': appointment.id.toString(),
          'titulo': appointment.subject,
          'descripcion': appointment.notes,
          'horainicio': appointment.startTime.toString(),
          'horafinal': appointment.endTime.toString(),
          'estado': "activo",
        }
      },
      SetOptions(merge: true),
    ).then((value) {
      response = "Agenda registrada";
      return response;
    }).catchError((error) {
      response = "Error al agregar la agenda: $error";
      return response;
    });

    return response;
  }

  Future<List<Appointment>> getAgendas() async {
    List<Appointment> aux = [];
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    final agendadata = await colection.doc('agenda').get();
    Map<dynamic, dynamic> dataid = agendadata.data() as Map<dynamic, dynamic>;
    dataid.forEach((key, value) {
      if (value["estado"] == 'activo') {
        Appointment appointment = Appointment(
          id: value['id'],
          subject: value['titulo'],
          notes: value['descripcion'],
          startTime: DateTime.parse(value['horainicio']),
          endTime: DateTime.parse(value['horafinal']),
        );
        aux.add(appointment);
      }
    });

    return aux;
  }

  Future<String?> deleteAgenda(Appointment appointment) async {
    String response = '';
    // User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    colection.doc('agenda').set(
      {
        appointment.id.toString(): {
          'estado': "inactivo",
        }
      },
      SetOptions(merge: true),
    ).then((value) {
      response = "Agenda registrada";
      return response;
    }).catchError((error) {
      response = "Error al agregar la agenda: $error";
      return response;
    });

    return response;
  }

  //FAVORES METHODS
  Future<String?> addFavor(Favores favores) async {
    String response = '';
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    colection.doc('favores').set(
      {
        favores.id.toString(): {
          'id': favores.id.toString(),
          'nombre': favores.nombre,
          'descripcion': favores.descripcion,
          'leaderID': favores.leaderID,
          'fecha': favores.fechafavor,
          'estado': favores.estado,
        }
      },
      SetOptions(merge: true),
    ).then((value) {
      response = "Favor registrado";
      return response;
    }).catchError((error) {
      response = "Error al agregar el Favor: $error";
      return response;
    });

    return response;
  }

  Stream<List<Favores>> getFavor() {
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    return colection.doc('favores').snapshots().asyncMap((event) {
      List<Favores> favoresAux = [];
      Map<String, dynamic> data = event.data() as Map<String, dynamic>;
      data.forEach((key, value) {
        Favores favor = Favores(
            nombre: value['nombre'],
            descripcion: value['descripcion'],
            leaderID: value['leaderID'],
            id: value['id'],
            fechafavor: value['fecha'],
            estado: value['estado'],
            telefonoContacto: value['telefonoContacto']);
        favoresAux.add(favor);
      });
      this.update(['testss']);
      return favoresAux;
    });
  }

  String getResponsable(String? responsable) {
    String response = '';
    String dateNow = DateTime.now().toString();
    // '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}-${DateTime.now().hour}:${DateTime.now().minute}';
    if (responsable == null) {
      response = '$emailUser#$dateNow';
    } else if (responsable.length > 4 && !responsable.contains(')')) {
      response = '$responsable)$emailUser#$dateNow';
    } else if (responsable.split(')')[1].isEmpty) {
      response = '$responsable$emailUser#$dateNow';
    } else if (responsable.split(')')[1].isNotEmpty) {
      List<String> responsableAux = responsable.split(')');
      responsableAux.removeAt(0);
      int index = responsableAux.lastIndexWhere(
          (element) => element.toLowerCase().contains(emailUser.toLowerCase()));
      if (index == -1) {
        responsable += (')' + emailUser + '#' + dateNow);
        response = responsable;
      } else {
        String changeDate = responsableAux[index].split('#')[0];
        changeDate += ('#' + dateNow);
        responsableAux.removeAt(index);
        responsableAux.add(changeDate);
        String auxaux = responsable.split(')')[0] + ')';
        print(auxaux);
        for (var element in responsableAux) {
          auxaux += (element + ')');
        }
        print(auxaux);

        response = auxaux.replaceFirst(')', '', auxaux.length - 2);
      }
      // for (var element in responsableAux) {
      //   if (responsableAux.contains(element)) {
      //     element.split('#').last = dateNow;
      //     index=
      //   }else{

      //   }
      // }
    }
    return response;
  }

  Future<void> exportToExcel(List<Votante> listVot) async {
    try {
      final excel = Excel.createExcel();
      final Sheet sheet = excel[excel.getDefaultSheet()!];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = 'Cedula';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
          .value = 'Nombre';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
          .value = 'Telefono';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          .value = 'Edad';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0))
          .value = 'Sexo';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0))
          .value = 'Segmento';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: 0))
          .value = 'Municipio';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: 0))
          .value = 'Barrio';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: 0))
          .value = 'Direccion';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: 0))
          .value = 'Lider';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: 0))
          .value = 'Coordinador';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: 0))
          .value = 'Encuesta';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: 0))
          .value = 'Puesto de Votacion';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: 0))
          .value = 'Mesa';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: 0))
          .value = 'Estado';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: 0))
          .value = 'Creador';
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: 0))
          .value = 'Editor';
      for (var row = 0; row < listVot.length; row++) {
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
            .value = listVot[row].id;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
            .value = listVot[row].name;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
            .value = listVot[row].phone;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1))
            .value = listVot[row].edad;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1))
            .value = listVot[row].sexo;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1))
            .value = listVot[row].segmento;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: row + 1))
            .value = listVot[row].municipio;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: row + 1))
            .value = listVot[row].barrio;
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: row + 1))
            .value = listVot[row].direccion;
        Leader? leader = getoneLeader(listVot[row].leaderID);
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: row + 1))
            .value = leader?.name ?? '';
        sheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: row + 1))
            .value = leader?.coordinador ?? '';
        String? encuesta;
        if (listVot[row].encuesta == true) {
          encuesta = 'Si';
        } else {
          encuesta = (listVot[row].encuesta == false ? 'No' : 'No responde');
        }

        if (listVot[row].encuesta == true ||
            listVot[row].encuesta == false ||
            listVot[row].encuesta == null) {
          if (listVot[row].encuesta == true) {
            encuesta = 'Si';
          } else {
            encuesta = (listVot[row].encuesta == false ? 'No' : 'No contesto');
          }
        } else {
          if (listVot[row].encuesta == 'Si') {
            encuesta = 'Si';
          } else if (listVot[row].encuesta == 'No') {
            encuesta = 'No';
          } else if (listVot[row].encuesta == 'No contesto') {
            encuesta = 'No contesto';
          } else if (listVot[row].encuesta == 'Llamar mas tarde') {
            encuesta = 'Llamar mas tarde';
          } else if (listVot[row].encuesta == 'Apagado') {
            encuesta = 'Apagado';
          } else if (listVot[row].encuesta == 'Numero no activo') {
            encuesta = 'Numero no activo';
          } else if (listVot[row].encuesta == 'Numero incorrecto') {
            encuesta = 'Numero incorrecto';
          }
        }
        sheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: row + 1))
            .value = encuesta;
        Puesto? puesto = getonePuesto(listVot[row].puestoID);

        sheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: row + 1))
            .value = puesto?.nombre ?? '';
        sheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: row + 1))
            .value = listVot[row].mesa ?? '';
        sheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: row + 1))
            .value = listVot[row].estado;
        sheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: row + 1))
            .value = (listVot[row]
                .responsable
                ?.split(')')[0]
                .replaceAll('#', '-')) ??
            "-";
        sheet
            .cell(
                CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: row + 1))
            .value = (listVot[row]
                .responsable
                ?.split(')')
                .last
                .replaceAll('#', '-')) ??
            "-";
      }

      excel.save(fileName: "ReporteDataBase.xlsx");
    } catch (e) {
      Get.back();
    }
  }
}
