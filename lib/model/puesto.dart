class Puesto {
  Puesto({
    required this.name,
    required this.id,
    required this.latitud,
    required this.longitud,
    required this.municipio,
  });
  late final String name;
  late final String id;
  late final String latitud;
  late final String longitud;
  late final String municipio;

  Puesto.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    latitud = json['latitud'];
    longitud = json['longitud'];
    longitud = json['municipio'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['latitud'] = latitud;
    _data['longitud'] = longitud;
    _data['longitud'] = municipio;
    return _data;
  }
}
