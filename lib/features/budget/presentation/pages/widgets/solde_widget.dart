import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/budget/data/models/demande_budget.dart';
import 'package:demandes/features/budget/presentation/providers/budget_provider.dart';
import 'package:demandes/features/demandes/presentation/widgets/display_field.dart';
import 'package:demandes/features/demandes/presentation/widgets/statut_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SoldeWidget extends ConsumerWidget {
  const SoldeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budgetRepo = ref.watch(budgetNotifierProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Gap(20),
        budgetRepo.when(
            data: (data) => DisplayFieldWidget(
                title: 'Solde résiduel',
                text: Utils.formatCFA(data!.solde),
                color: Colors.blue.shade800),
            error: (e, s) {
              print(e.toString());
              return Center(child: Text(e.toString()));
            },
            loading: () => const Loading())
      ],
    );
  }
}
