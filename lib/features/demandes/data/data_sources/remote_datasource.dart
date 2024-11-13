import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demandes/core/statuts.dart';
import 'package:demandes/features/authentification/domain/models/user.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';

class RemoteDatasource {
  final _demandesCollection = FirebaseFirestore.instance.collection('demandes');

  Future<void> add(DemandeModel demande) async {
    _demandesCollection.add(demande.toMap());
  }

  Future<void> edit(String docId, DemandeModel demande) async {
    _demandesCollection.doc(docId).update(demande.toMap());
  }

  Stream<QuerySnapshot> fetchAll() {
    return _demandesCollection
        .orderBy('date_created', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchByService(String serviceName) {
    return _demandesCollection
        .orderBy('date_created', descending: true)
        .where('service', isEqualTo: serviceName)
        .where('statut', isEqualTo: Statut.pendingVisaManager)
        .snapshots();
  }

  Stream<QuerySnapshot> fetchByStatus(int statut) {
    print('statut: $statut');
    return _demandesCollection
        .orderBy('date_created', descending: true)
        .where('statut', isEqualTo: statut)
        .snapshots();
  }

  Future<QuerySnapshot> fetchByUserUid(String userUid) async {
    final result = await _demandesCollection
        .orderBy('date_created', descending: true)
        .where('userUid', isEqualTo: userUid)
        .get();
    print(result.toString());
    return result;
  }
}
