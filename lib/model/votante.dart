import 'dart:math';

class Votante {
  Votante(
      {required this.name,
      required this.id,
      required this.leaderID,
      required this.phone,
      required this.puestoID,
      required this.direccion,
      this.edad,
      required this.municipio,
      this.barrio,
      this.estado,
      this.encuesta,
      this.responsable,
      this.mesa,
      this.sexo,
      this.segmento});

  late final String name;
  late final String id;
  late final String leaderID;
  late final String phone;
  late final String puestoID;
  late final String direccion;
  String? edad;
  String? sexo;

  String? segmento;

  late final String municipio;
  late String? barrio;
  String? estado = "activo";
  dynamic encuesta;
  String? responsable;
  String? mesa;

  Votante.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    leaderID = json['leaderID'];
    phone = json['phone'];
    puestoID = json['puntoID'];
    direccion = json['direccion'];
    edad = json['edad'];
    municipio = json['municipio'];
    barrio = json['barrio'];
    estado = json['estado'];
    encuesta = json['encuesta'];
    responsable = json['responsable'];
    mesa = json['mesa'];
    sexo = json['sexo'];
    segmento = json['segmento'];
  }
  Votante.fromJsonExcel(Map<String, dynamic> json) {
    name = json['Nombre'];
    id = json['Cedula'];
    leaderID = '11111111';
    phone = json['Celular'];
    puestoID = json['Puesto de Votacion'];
    direccion = json['Direccion'];
    edad = '';
    municipio = 'Valledupar';
    barrio = json['Barrio'];
    estado = 'Activo';
    encuesta = false;
    responsable = json['responsable'];
    mesa = json['mesa'];
    sexo = json['sexo'];
    segmento = json['segmento'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['leaderID'] = leaderID;
    _data['phone'] = phone;
    _data['puntoID'] = puestoID;
    _data['direccion'] = direccion;
    _data['edad'] = edad;
    _data['barrio'] = barrio;
    _data['municipio'] = municipio;
    _data['estado'] = estado;
    _data['encuesta'] = encuesta;
    _data['responsable'] = responsable;
    _data['mesa'] = mesa;
    _data['sexo'] = sexo;
    _data['segmento'] = segmento;

    return _data;
  }
}
