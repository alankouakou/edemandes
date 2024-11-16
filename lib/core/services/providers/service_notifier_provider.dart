import 'dart:async';

import 'package:demandes/core/services/data/model/service_model.dart';
import 'package:demandes/core/services/data/repository/service_repository.dart';
import 'package:demandes/core/services/providers/service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ServiceNotifier, List<ServiceModel>>(
  ServiceNotifier.new,
);

class ServiceNotifier extends AutoDisposeAsyncNotifier<List<ServiceModel>> {
  @override
  FutureOr<List<ServiceModel>> build() async {
    return await fetchAll();
  }

  Future<List<ServiceModel>> fetchAll() async {
    return await ref.watch(serviceRepositoryProvider).fetchAll();
  }
}
