import 'package:equatable/equatable.dart';

class Favores extends Equatable {
  Favores({
    required this.nombre,
    required this.id,
    required this.descripcion,
    required this.leaderID,
    required this.fechafavor,
    required this.estado,
    required this.telefonoContacto,
  });
  String? nombre;
  String? id;
  String? descripcion;
  String? leaderID;
  String? fechafavor;
  bool estado = false;
  String? telefonoContacto;

  Favores.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    id = json['id'];
    descripcion = json['descripcion'];
    leaderID = json['leaderID'];
    fechafavor = json['fechafavor'];
    estado = json['estado'];
    telefonoContacto = json['telefonoContacto'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['id'] = id;
    _data['descripcion'] = descripcion;
    _data['leaderID'] = leaderID;
    _data['fechafavor'] = fechafavor;
    _data['estado'] = estado;
    _data['telefonoContacto'] = telefonoContacto;

    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre];
}
