class Votante {
  Votante({
    required this.name,
    required this.id,
    required this.leaderID,
    required this.phone,
    required this.puestoID,
    required this.direccion,
    required this.edad,
    required this.municipio,
    this.barrio,
  });
  late final String name;
  late final String id;
  late final String leaderID;
  late final String phone;
  late final String puestoID;
  late final String direccion;
  late final String edad;
  late final String municipio;
  late String? barrio;

  Votante.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    leaderID = json['leaderID'];
    phone = json['phone'];
    puestoID = json['puntoID'];
    puestoID = json['direccion'];
    puestoID = json['edad'];
    puestoID = json['municipio'];
    puestoID = json['barrio'];
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
    return _data;
  }
}
