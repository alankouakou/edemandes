import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/budget/presentation/pages/new_demande_budget_page.dart';
import 'package:demandes/features/budget/presentation/pages/widgets/solde_widget.dart';
import 'package:demandes/features/budget/presentation/providers/budget_provider.dart';
import 'package:demandes/features/demandes/presentation/widgets/display_field.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class BudgetPage extends ConsumerWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asvDemande = ref.watch(demandeBudgetNotifierProvider);
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: asvDemande.when(
              data: (data) {
                final demande = data;
                if (demande == null) {
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: SoldeWidget(),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Text('Aucune demande en cours')),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context, NewDemandeBudgetPage.route());
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              foregroundColor: Colors.white,
                              backgroundColor: AppPalette.buttonBackgroundColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8.0))),
                          child: const Text(
                            'Nouvelle demande',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(children: [
                    const Gap(20),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text('Budget', style: AppTheme.pageTitleStyle),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: SoldeWidget(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: DisplayFieldWidget(
                          title: 'Demande en attente de validation',
                          text: Utils.formatCFA(demande.montant)),
                    ),
                  ]);
                }
              },
              error: (e, s) => null,
              loading: () => const Loading())),
    );
  }
}
