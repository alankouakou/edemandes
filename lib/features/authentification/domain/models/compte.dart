class Compte {
  final int id;
  final String name;

  String? email;
  String? telephone;
  DateTime? dateMaj;

  Compte({
    required this.id,
    required this.name,
  }) {
    email = '';
    telephone = '';
    dateMaj = null;
  }
}
