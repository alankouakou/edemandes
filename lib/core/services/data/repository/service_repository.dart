import 'package:demandes/core/services/data/datasources.dart/service_datasource.dart';
import 'package:demandes/core/services/data/model/service_model.dart';

class ServiceRepository {
  final ServiceDataSource datasource;

  const ServiceRepository({required this.datasource});
  Future<void> add(ServiceModel service) async {
    datasource.add(service);
  }

  Future<void> update(String docId, ServiceModel service) async {
    datasource.update(docId, service);
  }

  Future<void> delete(String docId) async {
    datasource.delete(docId);
  }

  Future<ServiceModel> get(String docId) async {
    return await datasource.get(docId);
  }

  Future<List<ServiceModel>> fetchAll() async {
    return await datasource.fetchAll();
  }
}
