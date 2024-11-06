class Demande {
  final String? docId;
  final String objet;
  final double montantPrevisionnel;
  final double montantDefinitif;
  final String service;
  final String user;
  final String userUid;
  final int statut;
  final DateTime dateCreated;
  final DateTime dateUpdated;

  Demande({
    this.docId,
    required this.objet,
    required this.montantPrevisionnel,
    required this.montantDefinitif,
    required this.service,
    required this.user,
    required this.userUid,
    required this.statut,
    required this.dateCreated,
    required this.dateUpdated,
  });
}
