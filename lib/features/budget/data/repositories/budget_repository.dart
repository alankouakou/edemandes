import 'package:demandes/core/statuts.dart';

import 'package:demandes/features/budget/data/data_sources/budget_datasource.dart';
import 'package:demandes/features/budget/data/models/budget.dart';
import 'package:demandes/features/budget/data/models/decaissement.dart';
import 'package:demandes/features/budget/data/models/demande_budget.dart';

class BudgetRepository {
  final BudgetDatasource budgetDataSource;

  BudgetRepository(this.budgetDataSource);

  Future<void> addDecaissement(DecaissementModel decaissement) async {
    budgetDataSource.addDecaissement(decaissement);
  }

  Future<void> udpdateDecaissement(
      String docId, DecaissementModel decaissement) async {
    budgetDataSource.updateDecaissement(docId, decaissement);
  }

  Future<void> add(Budget budget) async {
    budgetDataSource.add(budget);
  }

  Future<void> addDemande(DemandeBudget demandeBudget) async {
    budgetDataSource.addDemande(demandeBudget);
  }

  Future<Budget?> getCurrent() async {
    final budgetDocument = await budgetDataSource.getCurrent();
    return Budget.fromSnapshot(budgetDocument);
  }

  Future<List<DemandeBudget>> getListDemande() async {
    return await budgetDataSource.getListDemande();
  }

  Future<List<DecaissementModel>> getListeDecaissements() async {
    return await budgetDataSource.fetchDecaissements();
  }

  Future<DemandeBudget?> getPending() async {
    return await budgetDataSource.getPending();
  }

  Future<void> update(String docId, Budget budget) async {
    budgetDataSource.update(docId, budget);
  }

  Future<void> updateDemande(String docId, DemandeBudget demandeBudget) async {
    budgetDataSource.updateDemande(docId, demandeBudget);
  }

  void acceptDemande(
      // accpeter la demande et mettre a jour le budget et la DemandeBudget
      String docId,
      Budget budget,
      DemandeBudget demandeBudget) async {
    await budgetDataSource.updateDemande(
        docId,
        demandeBudget.copyWith(
            statut: Statut.approved, dateUpdated: DateTime.now()));
    final newSoldeTheorique = budget.soldeTheorique + demandeBudget.montant;
    final newSoldeReel = budget.soldeReel + demandeBudget.montant;
    final newBudget = budget.copyWith(
        soldeReel: newSoldeReel, soldeTheorique: newSoldeTheorique);
    budgetDataSource.update(budget.id!, newBudget);
  }
}
