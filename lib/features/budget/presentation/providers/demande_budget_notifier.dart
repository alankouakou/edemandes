import 'dart:async';

import 'package:demandes/features/budget/data/models/demande_budget.dart';
import 'package:demandes/features/budget/data/repositories/budget_repository.dart';
import 'package:demandes/features/budget/presentation/providers/budget_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemandeBudgetNotifier extends AutoDisposeAsyncNotifier<DemandeBudget?> {
  @override
  FutureOr<DemandeBudget?> build() async {
    final budgetRepo = ref.watch(budgetRepoProvider);

    return await budgetRepo.getPending();
    //getListDemande();
  }

  //TODO methode update demande à implementer

//TODO implémenter getById(){}
}
