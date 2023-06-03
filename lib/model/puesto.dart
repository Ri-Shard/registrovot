import 'package:equatable/equatable.dart';

class Puesto extends Equatable {
  Puesto(
      {required this.nombre,
      required this.id,
      required this.latitud,
      required this.longitud,
      required this.municipio,
      required this.direccion,
      this.estado});
  String? nombre;
  String? id;
  String? latitud;
  String? longitud;
  String? municipio;
  String? direccion;
  String? estado = "activo";

  Puesto.fromJson(Map<String, dynamic> json) {
    nombre = json['nombre'];
    id = json['id'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    municipio = json['municipio'];
    direccion = json['direccion'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nombre'] = nombre;
    _data['id'] = id;
    _data['latitud'] = latitud;
    _data['longitud'] = longitud;
    _data['municipio'] = municipio;
    _data['direccion'] = direccion;
    _data['estado'] = estado;
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, nombre, direccion];
}
