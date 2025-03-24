import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demandes/features/demandes/data/models/visa_demande.dart';

class VisasDemandesDatasource {
  final _visasDemandesCollection =
      FirebaseFirestore.instance.collection('visas_demandes');

  Future<void> logEvent(VisaDemande visa) async {
    _visasDemandesCollection.add(visa.toMap());
  }

  Future<void> deleteVisasDemande(String idDemande) async {
    final results = await _visasDemandesCollection
        .where('idDemande', isEqualTo: idDemande)
        .get();

    results.docs.forEach(deleteVisaDemande);
  }

  Future<void> deleteVisaDemande(QueryDocumentSnapshot doc) async {
    doc.reference.delete();
  }

  Future<QuerySnapshot> fetch(String idDemande, String role) async {
    return _visasDemandesCollection
        .where('idDemande', isEqualTo: idDemande)
        .where('role', isEqualTo: role)
        .get();
  }
}
