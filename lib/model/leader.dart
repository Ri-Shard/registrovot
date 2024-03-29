import 'package:equatable/equatable.dart';

class Leader extends Equatable {
  Leader(
      {required this.name,
      required this.id,
      required this.phone,
      required this.municipio,
      this.estado,
      this.coordinador});
  String? name;
  String? id;
  String? phone;
  String? municipio;
  String? estado = "activo";
  String? coordinador;
  Leader.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    phone = json['phone'];
    municipio = json['municipio'];
    estado = json['estado'];
    coordinador = json['coordinador'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['phone'] = phone;
    _data['municipio'] = municipio;
    _data['estado'] = estado;
    _data['coordinador'] = coordinador;
    return _data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name, id, phone];
}
