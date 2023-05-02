import 'package:equatable/equatable.dart';

class Puesto extends Equatable {
  Puesto({
    required this.nombre,
    required this.id,
    required this.latitud,
    required this.longitud,
    required this.municipio,
    required this.direccion,
  });
  late final String nombre;
  late final String id;
  late final String latitud;
  late final String longitud;
  late final String municipio;
  late final String direccion;

  Puesto.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    id = json['id'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    municipio = json['municipio'];
    direccion = json['direccion'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['id'] = id;
    _data['latitud'] = latitud;
    _data['longitud'] = longitud;
    _data['municipio'] = municipio;
    _data['direccion'] = direccion;
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre, direccion];
}
