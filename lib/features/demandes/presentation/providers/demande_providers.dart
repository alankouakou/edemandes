import 'package:demandes/features/demandes/data/data_sources/remote_datasource.dart';

import 'package:demandes/features/demandes/data/repositories/demande_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final RemoteDatasource remoteDS = RemoteDatasource();

final demandeRepoProvider = Provider<DemandeRepository>((ref) {
  return DemandeRepository(remoteDS);
});
