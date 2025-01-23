import 'dart:async';

import 'package:demandes/core/statuts.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/features/budget/data/data_sources/budget_datasource.dart';
import 'package:demandes/features/budget/data/models/budget.dart';
import 'package:demandes/features/budget/data/models/decaissement.dart';
import 'package:demandes/features/budget/data/models/demande_budget.dart';
import 'package:demandes/features/budget/data/repositories/budget_repository.dart';
import 'package:demandes/features/budget/presentation/providers/demande_budget_notifier.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';
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

  Future<bool> validerDecaissement(String role, DemandeModel demande) async {
    final budget = await current();

    if (budget != null) {
      if (role == 'RAF' && demande.statut == Statut.pendingVisaRAF) {
        if (demande.montantPrevisionnel > budget.soldeTheorique) {
          Utils.showErrorMessage(message: 'Solde budget insuffisant!');
          return false;
        } else {
          // Maj solde
          final newSolde = budget.soldeTheorique - demande.montantPrevisionnel;
          final budgetNew = budget.copyWith(soldeTheorique: newSolde);
          updateBudget(budget.id!, budgetNew);
        }
      }
      if (role == 'COMPTABLE' && demande.statut == Statut.approved) {
        // Maj Solde reel
        final newSoldeReel = budget.soldeReel - demande.montantPrevisionnel;
        final cumuldeCaisse =
            budget.cumulDecaisse + demande.montantPrevisionnel;
        final budgetNew = budget.copyWith(
            soldeReel: newSoldeReel, cumulDecaisse: cumuldeCaisse);
        updateBudget(budget.id!, budgetNew);

        final decaissement = DecaissementModel(
            dateDecaissement: DateTime.timestamp(),
            cumulDecaisse: cumuldeCaisse,
            montantDefinitif: demande.montantDefinitif,
            montantPrevisionnel: demande.montantPrevisionnel,
            objetDemande: demande.objet,
            idDemande: demande.docId,
            solde: newSoldeReel);
        ref.read(budgetRepoProvider).addDecaissement(decaissement);
      }
      final statut = Statut.accept(demande.statut);
      await ref.read(demandeRepoProvider).updateDemande(demande.docId!,
          demande.copyWith(dateUpdated: DateTime.timestamp(), statut: statut));

      Utils.showSuccessMessage(message: 'Demande validée');
      return true;
    } else {
      Utils.showErrorMessage(message: 'Budget inexistant!');
      return false;
    }
  }

  Future<bool> rejeterDecaissement(String role, DemandeModel demande) async {
    final budget = await current();

    if (budget != null) {
      ref.read(demandeRepoProvider).updateDemande(
          demande.docId!,
          demande.copyWith(
              objet: 'REFUS $role  - ${demande.objet}',
              dateUpdated: DateTime.timestamp(),
              statut: Statut.rejected));
      if (role == 'COORDONNATEUR') {
        final newSolde = budget.soldeTheorique + demande.montantPrevisionnel;
        final budgetNew = budget.copyWith(soldeTheorique: newSolde);
        updateBudget(budget.id!, budgetNew);
        // Utils.showSuccessMessage(message: 'Solde théorique mis à jour');
      }
      return true;
    } else {
      Utils.showErrorMessage(message: 'Budget inexistant!');
      return false;
    }
  }

  //TODO methode update demande à implementer
  Future<void> updateBudget(String docId, Budget budget) async {
    final budgetRepo = ref.watch(budgetRepoProvider);
    return await budgetRepo.update(docId, budget);
  }

//TODO implémenter getById(){}
}
