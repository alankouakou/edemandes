class Service {
  final String id; //user_uid
  final String libelle;

  const Service({
    required this.id,
    required this.libelle,
  });

  Service.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        libelle = json['libelle'] as String;

  Map<String, dynamic> toJson(Service service) {
    return {'id': service.id, 'libelle': service.libelle};
  }
}
