import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/core/statuts.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:demandes/features/budget/data/models/demande_budget.dart';
import 'package:demandes/features/budget/presentation/pages/widgets/solde_widget.dart';
import 'package:demandes/features/budget/presentation/providers/budget_provider.dart';
import 'package:demandes/features/demandes/presentation/pages/main_menu.dart';
import 'package:demandes/features/demandes/presentation/widgets/appbar_title.dart';
import 'package:demandes/features/demandes/presentation/widgets/display_field.dart';
import 'package:demandes/features/demandes/presentation/widgets/statut_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ValidationDemandeBudgetPage extends ConsumerWidget {
  const ValidationDemandeBudgetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TODO Valeur en dur. A récuperer dans Firestore
    final asvDemandeBudget = ref.watch(demandeBudgetNotifierProvider);
    //final user = ref.watch(userNotifierProvider);
    final role = ref.watch(roleProvider);
    final activeBudget = ref.watch(budgetFutureProvider);

    print('*** Role : $role ***');
    /* final demande = DemandeBudget(
        dateCreated: DateTime.now(),
        idDemande: '',
        montant: 0.0,
        memo: 'bla bla bla',
        statut: Statut.pendingVisaCoordonnateur); */

    return Scaffold(
        body: asvDemandeBudget.when(
      data: (data) {
        if (data != null) {
          final demande = data;
          final demandeId = demande.id;
          final bool statusLocked =
              [Statut.approved, Statut.rejected].contains(demande.statut);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: ListView(
                  children: [
                    const Text('Demande de budget additionnel',
                        style: AppTheme.pageTitleStyle),
                    const Gap(10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          StatutDemandeWidget(statut: demande.statut)
                        ]),
                    const Gap(10),
                    const SoldeWidget(),
                    const Gap(20),
                    DisplayFieldWidget(
                        title: 'Montant additionnel demandé',
                        text: Utils.formatCFA(demande.montant)),
                    const Gap(20),
                    DisplayFieldWidget(
                        title: 'Notes', text: demande.memo ?? ''),
                    const Gap(20),
                    DisplayFieldWidget(
                        title: 'Date de la demande:',
                        text: Utils.dateFull.format(demande.dateCreated)),
                    const Gap(20),
                  ],
                )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: statusLocked
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Fermer',
                                )),
                            const Gap(20.0),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: statusLocked
                                    ? null
                                    : () {
                                        ref
                                            .read(budgetRepoProvider)
                                            .updateDemande(
                                                demandeId!,
                                                demande.copyWith(
                                                    statut: Statut.rejected));
                                        ref
                                            .read(pageIndexProvider.notifier)
                                            .state = 1;
                                      },
                                child: const Text(
                                  'Rejeter',
                                )),
                            const Gap(20.0),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: statusLocked
                                    ? null
                                    : () async {
                                        final statut =
                                            Statut.accept(demande.statut);
                                        //TODO A adapter à Budget Demande
                                        final activeBudget = await ref
                                            .read(budgetRepoProvider)
                                            .getCurrent();
                                        if (activeBudget != null) {
                                          print(
                                              '*** Debug Demande id: ${demande.id} ***');
                                          ref
                                              .read(budgetRepoProvider)
                                              .acceptDemande(
                                                  demandeId!,
                                                  activeBudget,
                                                  demande.copyWith(
                                                      id: demande.id!,
                                                      dateUpdated:
                                                          DateTime.now(),
                                                      statut: statut));
                                          ref
                                              .read(pageIndexProvider.notifier)
                                              .state = 1;

                                          // Navigator.pop(context);
                                        } else {
                                          Utils.showErrorMessage(message: '');
                                        }
                                      },
                                child: const Text(
                                  'Approuver',
                                )),
                          ],
                        ),
                )
              ],
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: [
              SoldeWidget(),
              Gap(20),
              Center(child: Text('Aucune demande en attente!')),
            ]),
          );
        }
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => const Loading(),
    ));
  }
}
