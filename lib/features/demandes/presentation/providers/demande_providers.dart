import 'dart:async';

import 'package:demandes/features/demandes/data/data_sources/remote_datasource.dart';
import 'package:demandes/features/demandes/data/models/demande.dart';
import 'package:demandes/features/demandes/data/repositories/demande_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final RemoteDatasource remoteDS = RemoteDatasource();

final demandeRepoProvider = Provider<DemandeRepository>((ref) {
  return DemandeRepository(remoteDS);
});

final demandeStreamProvider = StreamProvider(
  (ref) {
    final demandeRepo = DemandeRepository(remoteDS);
    return demandeRepo.fetchStream();
  },
);

class AsyncDemandeNotifier extends AutoDisposeAsyncNotifier<List<Demande>> {
  final DemandeRepository demandeRepo;
  AsyncDemandeNotifier(this.demandeRepo);
  @override
  FutureOr<List<Demande>> build() async {
    return await demandeRepo.fetchAll();
  }
}
