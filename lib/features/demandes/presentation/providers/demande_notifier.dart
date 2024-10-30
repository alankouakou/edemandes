import 'dart:async';

import 'package:demandes/features/demandes/data/models/demande.dart';
import 'package:demandes/features/demandes/data/repositories/demande_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncDemandeNotifier extends AutoDisposeAsyncNotifier<List<Demande>> {
  final DemandeRepository demandeRepo;
  AsyncDemandeNotifier(this.demandeRepo);
  @override
  FutureOr<List<Demande>> build() async {
    return await demandeRepo.fetchAll();
  }

  Future<void> edit(Demande demande, String docId) async {}
  Future<void> rejeter(String docId) async {}
  Future<void> approuver(String docId) async {}
  Future<void> fetchAll() async {}
}
