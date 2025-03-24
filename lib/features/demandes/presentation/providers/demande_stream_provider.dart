import 'package:demandes/core/statuts.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:demandes/features/demandes/data/data_sources/remote_datasource.dart';
import 'package:demandes/features/demandes/data/repositories/demande_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final RemoteDatasource remoteDS = RemoteDatasource();

final statusProvider = StateProviderFamily<int, String>((ref, role) {
  return switch (role) {
    'CHEF_SERVICE' => Statut.pendingVisaManager,
    'RAF' => Statut.pendingVisaRAF,
    'COORDONNATEUR' => Statut.pendingVisaCoordonnateur,
    'COMPTABLE' => Statut.approved,
    _ => 0
  };
});

final demandeStreamProvider = StreamProvider(
  (ref) {
    final demandeRepo = DemandeRepository(remoteDS);
    return demandeRepo.fetchStream();
  },
);

final serviceStreamProvider = StreamProviderFamily(
  (ref, String service) {
    final demandeRepo = DemandeRepository(remoteDS);
    return demandeRepo.fetchByService(service);
  },
);

final rafStreamProvider = StreamProvider(
  (ref) {
    final demandeRepo = DemandeRepository(remoteDS);
    return demandeRepo.fetchByStatus(Statut.pendingVisaRAF);
  },
);

final coordoStreamProvider = StreamProvider(
  (ref) {
    final demandeRepo = DemandeRepository(remoteDS);
    return demandeRepo.fetchByStatus(Statut.pendingVisaCoordonnateur);
  },
);

final comptaStreamProvider = StreamProvider(
  (ref) {
    final demandeRepo = DemandeRepository(remoteDS);
    return demandeRepo.fetchByStatus(Statut.approved);
  },
);

final decaisseStreamProvider = StreamProvider(
  (ref) {
    final demandeRepo = DemandeRepository(remoteDS);
    return demandeRepo.fetchByStatus(Statut.paid);
  },
);
