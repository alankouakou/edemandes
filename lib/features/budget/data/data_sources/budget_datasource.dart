import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demandes/features/budget/data/models/budget.dart';
import 'package:demandes/features/budget/data/models/decaissement.dart';
import 'package:demandes/features/budget/data/models/demande_budget.dart';

class BudgetDatasource {
  final _budgetCollection = FirebaseFirestore.instance.collection('budget');
  final _demandeBudgetCollection =
      FirebaseFirestore.instance.collection('demande_budget');

  final _decaisssementsCollection =
      FirebaseFirestore.instance.collection('decaissements');

  Future<void> addDecaissement(DecaissementModel decaissement) async {
    _decaisssementsCollection.add(decaissement.toMap());
  }

  Future<void> updateDecaissement(
      String docId, DecaissementModel decaissement) async {
    _decaisssementsCollection.doc(docId).update(decaissement.toMap());
  }

  Future<List<DecaissementModel>> fetchDecaissements() async {
    final results = await _decaisssementsCollection
        .orderBy('dateDecaissement', descending: true)
        .get();

    print(' budgetDataSourcefetchDecaissements: ${results.docs.length}');
    return results.docs.map((item) {
      return DecaissementModel.fromSnapshot(item);
    }).toList();
  }

  Future<void> addDemande(DemandeBudget demandeBudget) async {
    _demandeBudgetCollection.add(demandeBudget.toMap());
  }

  Future<void> updateDemande(String docId, DemandeBudget demandeBudget) async {
    await _demandeBudgetCollection.doc(docId).update(demandeBudget.toMap());

    print('Update demande *** - $docId - ***');
  }

  Future<void> add(Budget budget) async {
    _budgetCollection.add(budget.toMap());
  }

  Future<void> update(String docId, Budget budget) async {
    try {
      _budgetCollection.doc(docId).update(budget.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<QuerySnapshot> fetchAll() {
    return _budgetCollection.orderBy('date_maj', descending: true).snapshots();
  }

  Future<QueryDocumentSnapshot<Map<String, dynamic>>> getCurrent() async {
    final qrySnapshot = await _budgetCollection
        .orderBy('date_maj', descending: true)
        .where('actif', isEqualTo: true)
        .get();

    return qrySnapshot.docs.first;
  }

  Future<List<DemandeBudget>> getListDemande() async {
    final qrySnapshot = await _demandeBudgetCollection
        .orderBy('dateCreated', descending: true)
        .where('statut', isEqualTo: 3)
        .get();

    if (qrySnapshot.docs.isNotEmpty) {
      final result = qrySnapshot.docs.map((doc) {
        print('***** ${doc.data()} *****');
        return DemandeBudget.fromFirestore(doc);
      }).toList();

      return result;
    } else {
      return [];
    }
  }

  Future<DemandeBudget?> getPending() async {
    final qrySnapshot = await _demandeBudgetCollection
        .orderBy('dateCreated', descending: true)
        .where('statut', isEqualTo: 3)
        .get();

    if (qrySnapshot.docs.isEmpty) {
      return null;
    } else {
      return DemandeBudget.fromFirestore(qrySnapshot.docs.first);
    }
  }
}
