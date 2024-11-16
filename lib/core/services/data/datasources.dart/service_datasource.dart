import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demandes/core/services/data/model/service_model.dart';

class ServiceDataSource {
  final _serviceCollection = FirebaseFirestore.instance.collection('services');

  Future<void> add(ServiceModel service) async {
    _serviceCollection.add(service.toMap());
  }

  Future<void> update(String docId, ServiceModel service) async {
    _serviceCollection.doc(docId).update(service.toMap());
  }

  Future<void> delete(String docId) async {
    _serviceCollection.doc(docId).delete();
  }

  Future<ServiceModel> get(String docId) async {
    final doc = await _serviceCollection.doc(docId).get();
    return ServiceModel.fromFirestore(doc);
  }

  Future<List<ServiceModel>> fetchAll() async {
    final result = await _serviceCollection.orderBy('libelle').get();
    return result.docs.map((item) => ServiceModel.fromFirestore(item)).toList();
  }
}
