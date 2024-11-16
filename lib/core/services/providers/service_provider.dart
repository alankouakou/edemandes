import 'package:demandes/core/services/data/datasources.dart/service_datasource.dart';
import 'package:demandes/core/services/data/repository/service_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceDatasourceProvider = Provider<ServiceDataSource>((ref) {
  return ServiceDataSource();
});

final serviceRepositoryProvider = Provider<ServiceRepository>((ref) {
  return ServiceRepository(datasource: ref.watch(serviceDatasourceProvider));
});
