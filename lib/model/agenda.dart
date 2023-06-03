import 'package:equatable/equatable.dart';

class Agenda extends Equatable {
  Agenda(
      {required this.id,
      required this.titulo,
      required this.descripcion,
      required this.horainicio,
      required this.horafinal,
      this.estado});
  late final String id;
  late final String titulo;
  late final String descripcion;
  late final String horainicio;
  late final String horafinal;
  String? estado = "activo";

  Agenda.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titulo = json['titulo'];
    descripcion = json['descripcion'];
    horainicio = json['horainicio'];
    horafinal = json['horafinal'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['descripcion'] = descripcion;
    _data['horainicio'] = horainicio;
    _data['horafinal'] = horafinal;

    _data['estado'] = estado;
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [titulo, descripcion, id];
}
