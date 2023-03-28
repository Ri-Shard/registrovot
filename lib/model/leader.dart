class Leader {
  Leader({
    required this.name,
    required this.id,
    required this.phone,
    required this.municipio,
  });
  late final String name;
  late final String id;
  late final String phone;
  late final String municipio;

  Leader.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    phone = json['phone'];
    municipio = json['municipio'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['id'] = id;
    _data['phone'] = phone;
    _data['municipio'] = municipio;
    return _data;
  }
}
