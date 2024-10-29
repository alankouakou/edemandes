import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demandes/features/demandes/data/models/demande.dart';

class RemoteDatasource {
  final _demandesCollection = FirebaseFirestore.instance.collection('demandes');

  Future<void> add(Demande demande) async {
    _demandesCollection.add(demande.toMap());
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
        .snapshots();
  }
}
