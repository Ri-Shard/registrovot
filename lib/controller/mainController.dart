// ignore: file_names
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  List<bool> defineViews(String email) {
    emailUser = email;
    collection = email.split('@').last.split('.').first;
    if (email.contains('candidato')) {
      listviews = [
        true,
        true,
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
        true,
        true,
        true,
        true,
        false,
        true,
        false,
        true,
        true
      ];
      return listviews;
    } else if (email.contains('secre')) {
      listviews = [
        true,
        false,
        true,
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
        false
      ];
      return listviews;
    } else if (email.contains('gerente')) {
      listviews = [
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        false,
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
        false
      ];
      return listviews;
    } else if (email.contains('callcenter')) {
      listviews = [
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
        false,
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
              'encuesta': false,
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
                  encuesta: value['encuesta']);
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
      });
    } catch (e) {
      response = "Error al Actualizar el Usuario: $e";
    }
  }

  updateEncuesta(String id, bool? encuesta) async {
    String response = '';

    try {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref().child('$collection/${id.toString()}');
      await ref.update({'encuesta': encuesta});

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
          'encuesta': false
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
      colection = FirebaseFirestore.instance.collection('location');
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
    colection = FirebaseFirestore.instance.collection('location');
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

    colection = FirebaseFirestore.instance.collection('location');
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
            estado: value['estado']);
        favoresAux.add(favor);
      });
      this.update(['testss']);
      return favoresAux;
    });
  }
}
