import 'package:demandes/core/statuts.dart';
import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/budget/data/models/demande_budget.dart';
import 'package:demandes/features/budget/presentation/providers/budget_provider.dart';
import 'package:demandes/features/demandes/presentation/pages/main_menu.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewDemandeBudgetPage extends ConsumerStatefulWidget {
  const NewDemandeBudgetPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const NewDemandeBudgetPage());
  }

  @override
  ConsumerState<NewDemandeBudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends ConsumerState<NewDemandeBudgetPage> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  final _montantController = TextEditingController();
  bool isSaving = false;
  bool isActif = false;

  void clearFields() {
    _noteController.clear();
    _montantController.clear();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _montantController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Text('Demande budget', style: AppTheme.pageTitleStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11)
                  ],
                  controller: _montantController,
                  validator: (value) =>
                      value!.isEmpty ? 'Renseignez le montant' : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Montant à valider',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      suffixText: 'F CFA'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  controller: _noteController,
                  maxLines: 5,
                  validator: (value) => value!.isEmpty
                      ? 'Ajoutez un memo'
                      : null, // Le login doit être unique
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      hintText: 'Observations...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final now = DateTime.now();
                      final demandeBudget = DemandeBudget(
                        montant: double.parse(_montantController.text),
                        memo: _noteController.text,
                        idDemande: '',
                        statut: Statut.pendingVisaCoordonnateur,
                        dateCreated: now,
                        dateUpdated: now,
                      );

                      //TODO Enregistrer la demande budget
                      ref.read(budgetRepoProvider).addDemande(demandeBudget);
                      Utils.showSuccessMessage(
                          message: 'Demande soumise pour validation');
                      ref.read(pageIndexProvider.notifier).state = 0;
                      Navigator.pop(context);
                    } else {
                      Utils.showErrorMessage(
                          message: 'Veuillez renseigner tous les champs');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      foregroundColor: Colors.white,
                      backgroundColor: AppPalette.buttonBackgroundColor,
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.circular(8.0))),
                  child: isSaving == true
                      ? const Loading()
                      : const Text('Enregistrer',
                          style: TextStyle(fontSize: 16)),
                ),
              )
            ]),
          ),
        ));
  }
}
