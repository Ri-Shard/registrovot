import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registrovot/model/leader.dart';
import 'package:registrovot/model/puesto.dart';
import 'package:registrovot/model/votante.dart';
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

class MainController extends GetxController {
  final _auth = FirebaseAuth.instance;
  List<bool> listviews = [];
  String? collection;
  Future<User?> getFirebaseUser() async {
    User? firebaseUser = _auth.currentUser;
    firebaseUser ??= await _auth.authStateChanges().first;

    if (firebaseUser != null) defineViews(firebaseUser.email!);
    return firebaseUser;
  }

  List<bool> defineViews(String email) {
    collection = email.split('@').last.split('.').first;
    if (email.contains('candidato')) {
      listviews = [true, true, true, true, true, true, true, true, true, true];
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
        true
      ];
      return listviews;
    } else if (email.contains('gerente')) {
      listviews = [true, true, true, true, true, true, true, true, false, true];
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
        true
      ];
      return listviews;
    }
    return listviews;
  }

//LEADER METHODS
  Future<String?> addLeader(Leader leader) async {
    String response = '';
    User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    final exist = await getoneLeader(leader.id);
    if (exist != null) {
      response = 'Ya Existe';
      return response;
    } else {
      colection = FirebaseFirestore.instance.collection(collection!);
      colection.doc('lideres').set(
        {
          leader.id: {
            'id': leader.id,
            'name': leader.name,
            'phone': leader.phone,
            'municipio': leader.municipio
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

  Future<List<Leader>> getLeaders() async {
    List<Leader> prueba = [];
    User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    final lideresdata = await colection.doc('lideres').get();
    Map<dynamic, dynamic> data = lideresdata.data() as Map<dynamic, dynamic>;
    data.forEach((key, value) {
      Leader leader = Leader(
          name: value['name'],
          id: value['id'],
          phone: value['phone'],
          municipio: value['municipio']);
      prueba.add(leader);
    });
    return prueba;
  }

  Future<Leader?> getoneLeader(String idLeader) async {
    Leader? leader;
    User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    final lideresdata = await colection.doc('lideres').get();
    Map<dynamic, dynamic> dataid = lideresdata.data() as Map<dynamic, dynamic>;
    dataid.forEach((key, value) {
      if (key == idLeader) {
        Leader leaderaux = Leader(
            name: value['name'],
            id: value['id'],
            phone: value['phone'],
            municipio: value['municipio']);
        leader = leaderaux;
      }
    });
    return leader;
  }

  String? deleteLeaders(String id) {
    User? firebaseUser = _auth.currentUser;
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
  Future<String?> addVotante(Votante votante) async {
    String response = '';
    User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    final exist = await getoneVotante(votante.id);
    if (exist != null) {
      response = 'Ya Existe';
      return response;
    } else {
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
          }
        },
        SetOptions(merge: true),
      ).then((value) {
        response = "Usuario registrado";
        return response;
      }).catchError((error) {
        response = "Error al agregar el Usuario: $error";
        return response;
      });
    }

    return response;
  }

  Future<String?> updateVotante(Votante votante) async {
    String response = '';
    User? firebaseUser = _auth.currentUser;
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

  Future<List<Votante>> getVotantes() async {
    List<Votante> aux = [];
    User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    final votantesdata = await colection.doc('usuarios').get();
    Map<dynamic, dynamic> dataid = votantesdata.data() as Map<dynamic, dynamic>;
    dataid.forEach((key, value) {
      Votante votante = Votante(
          name: value['name'],
          id: value['id'],
          phone: value['phone'],
          leaderID: value['leaderID'],
          direccion: value['direccion'],
          edad: value['edad'],
          municipio: value['municipio'],
          barrio: value['barrio'],
          puestoID: value['puestoID']);
      aux.add(votante);
    });
    return aux;
  }

  Future<Votante?> getoneVotante(String idVotante) async {
    Votante? votanteaux;
    User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection(collection!);
    final votantesdata = await colection.doc('usuarios').get();
    Map<dynamic, dynamic> dataid = votantesdata.data() as Map<dynamic, dynamic>;
    dataid.forEach((key, value) {
      if (key == idVotante) {
        Votante votante = Votante(
            name: value['name'],
            id: value['id'],
            phone: value['phone'],
            leaderID: value['leaderID'],
            direccion: value['direccion'],
            edad: value['edad'],
            municipio: value['municipio'],
            barrio: value['barrio'],
            puestoID: value['puestoID']);
        votanteaux = votante;
      }
    });
    return votanteaux;
  }

//PUESTO METHODS
  Future<String?> addPuesto(Puesto puesto) async {
    String response = '';
    CollectionReference colection;
    final exist = await getonePuesto(puesto.id);
    if (exist != null) {
      response = 'Ya Existe';
      return response;
    } else {
      colection = FirebaseFirestore.instance.collection('location');
      colection.doc('puntos').set(
        {
          puesto.id: {
            'name': puesto.name,
            'lat': puesto.latitud,
            'lang': puesto.longitud,
            'municipio': puesto.municipio,
          }
        },
        SetOptions(merge: true),
      ).then((value) {
        response = "Usuario registrado";
        return response;
      }).catchError((error) {
        response = "Error al agregar el Usuario: $error";
        return response;
      });
    }

    return response;
  }

  Future<List<Puesto>> getPuestos() async {
    List<Puesto> aux = [];
    User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection('location');
    final puntosdata = await colection.doc('puntos').get();
    Map<dynamic, dynamic> dataid = puntosdata.data() as Map<dynamic, dynamic>;
    dataid.forEach((key, value) {
      Puesto puesto = Puesto(
          name: value['name'],
          id: key.toString(),
          latitud: value['lat'],
          longitud: value[['long']],
          municipio: value[['municipio']]);
      aux.add(puesto);
    });

    return aux;
  }

  Future<Puesto?> getonePuesto(String idPuesto) async {
    Puesto? puesto;
    User? firebaseUser = _auth.currentUser;
    CollectionReference colection;
    colection = FirebaseFirestore.instance.collection('location');
    final puestosdata = await colection.doc('puntos').get();
    Map<dynamic, dynamic> dataid = puestosdata.data() as Map<dynamic, dynamic>;
    dataid.forEach((key, value) {
      if (key == idPuesto) {
        Puesto puestoaux = Puesto(
            name: value['name'],
            id: key.toString(),
            latitud: value['lat'],
            longitud: value[['long']],
            municipio: value[['municipio']]);
        puesto = puestoaux;
      }
    });

    return puesto;
  }
}
