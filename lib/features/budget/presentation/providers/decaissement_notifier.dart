import 'dart:async';

import 'package:demandes/features/budget/data/models/decaissement.dart';
import 'package:demandes/features/budget/presentation/providers/budget_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final decaissementsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    DecaissementNotifier, List<DecaissementModel>>(DecaissementNotifier.new);

class DecaissementNotifier
    extends AutoDisposeAsyncNotifier<List<DecaissementModel>> {
  @override
  FutureOr<List<DecaissementModel>> build() async {
    return await fetchAll();
  }

  Future<List<DecaissementModel>> fetchAll() async {
    final budgetRepo = ref.watch(budgetRepoProvider);

    return await budgetRepo.getListeDecaissements();
  }
}
