import 'dart:async';

import 'package:demandes/features/demandes/data/models/demande_model.dart';
import 'package:demandes/features/demandes/data/repositories/demande_repository.dart';
import 'package:demandes/features/demandes/domain/entities/demande.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncDemandeNotifier
    extends AutoDisposeAsyncNotifier<List<DemandeModel>> {
  final DemandeRepository demandeRepo;
  AsyncDemandeNotifier(this.demandeRepo);
  @override
  FutureOr<List<DemandeModel>> build() async {
    return await demandeRepo.fetchAll();
  }

  Future<void> edit(DemandeModel demande, String docId) async {}
  Future<void> reject(String docId) async {}
  Future<void> approve(String docId) async {}
  Future<void> get(String docId) async {}
  Future<void> fetchAll() async {}
}
