import 'dart:async';

import 'package:demandes/core/utils.dart';
import 'package:demandes/features/budget/data/data_sources/budget_datasource.dart';
import 'package:demandes/features/budget/data/models/budget.dart';
import 'package:demandes/features/budget/data/models/demande_budget.dart';
import 'package:demandes/features/budget/data/repositories/budget_repository.dart';
import 'package:demandes/features/budget/presentation/providers/demande_budget_notifier.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final BudgetDatasource budgetDS = BudgetDatasource();

final budgetIdProvider = StateProvider<String>((ref) => '');

final budgetFutureProvider = FutureProvider(
  (ref) async {
    final budgetRepo = ref.watch(budgetRepoProvider);
    final activeBudget = await budgetRepo.getCurrent();

    if (activeBudget != null) {
      ref.read(budgetIdProvider.notifier).state = activeBudget.id!;
    }
    return activeBudget;
  },
);

final budgetNotifierProvider =
    AutoDisposeAsyncNotifierProvider<BudgetNotifier, Budget?>(
  BudgetNotifier.new,
);

final budgetRepoProvider = Provider<BudgetRepository>((ref) {
  return BudgetRepository(budgetDS);
});

final demandeBudgetNotifierProvider =
    AutoDisposeAsyncNotifierProvider<DemandeBudgetNotifier, DemandeBudget?>(
  DemandeBudgetNotifier.new,
);

class BudgetNotifier extends AutoDisposeAsyncNotifier<Budget?> {
  @override
  FutureOr<Budget?> build() async {
    return await current();
  }

  Future<Budget?> current() async {
    final budgetRepo = ref.watch(budgetRepoProvider);
    return await budgetRepo.getCurrent();
  }

  Future<void> deduireDemande(DemandeModel demande) async {
    final budget = await current();

    final newSolde = budget!.solde - demande.montantPrevisionnel;
    final budgetNew = budget.copyWith(solde: newSolde);
    updateBudget(budget.id!, budgetNew);
    Utils.showSuccessMessage(message: 'Solde mis à jour');
  }

  Future<void> annulerDeduction(DemandeModel demande) async {
    final budget = await current();

    final newSolde = budget!.solde + demande.montantPrevisionnel;
    final budgetNew = budget.copyWith(solde: newSolde);
    updateBudget(budget.id!, budgetNew);
    Utils.showSuccessMessage(message: 'Solde mis à jour');
  }

  //TODO methode update demande à implementer
  Future<void> updateBudget(String docId, Budget budget) async {
    final budgetRepo = ref.watch(budgetRepoProvider);
    return await budgetRepo.update(docId, budget);
  }

//TODO implémenter getById(){}
}
