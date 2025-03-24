import 'package:demandes/core/statuts.dart';
import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:demandes/features/budget/presentation/providers/budget_provider.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';
import 'package:demandes/features/demandes/domain/entities/demande.dart';
import 'package:demandes/features/demandes/presentation/pages/main_menu.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';
import 'package:demandes/features/demandes/presentation/widgets/appbar_title.dart';
import 'package:demandes/features/demandes/presentation/widgets/display_field.dart';
import 'package:demandes/features/demandes/presentation/widgets/statut_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

final _formKey = GlobalKey<FormState>();

class ClotureDemandePage extends ConsumerStatefulWidget {
  final String docId;
  final DemandeModel demande;
  const ClotureDemandePage(
      {super.key, required this.docId, required this.demande});

  static Route route(String docId, DemandeModel demande) {
    return MaterialPageRoute(
        builder: (_) => ClotureDemandePage(docId: docId, demande: demande));
  }

  @override
  ConsumerState<ClotureDemandePage> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<ClotureDemandePage> {
  final _montantDefinitifController = TextEditingController();

  bool isVisible = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    isSaving = false;
  }

  void toggleVisibility() {
    setState(
      () {
        isVisible = !isVisible;
      },
    );
  }

  void clearFields() {
    _montantDefinitifController.clear();
  }

  int defineStatutDemande(String userService) {
    int statutDemande = switch (userService) {
      'RAF' => Statut.pendingVisaRAF,
      _ => Statut.pendingVisaManager
    };
    return statutDemande;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(title: const AppBarTitle()),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Expanded(
                    child: ListView(children: [
                  const Text('Montant définitif',
                      style: AppTheme.pageTitleStyle),
                  const Gap(10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Gap(10),
                        StatutDemandeWidget(statut: widget.demande.statut)
                      ]),
                  const Gap(10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: DisplayFieldWidget(
                        title: 'Objet de la demande :',
                        text: widget.demande.objet),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: DisplayFieldWidget(
                        title: 'Montant prévisionnel :',
                        text: widget.demande.montantPrevisionnel.toString()),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8)
                      ],
                      controller: _montantDefinitifController,
                      validator: (value) =>
                          value!.isEmpty ? 'Renseignez le montant' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Renseignez le Montant définitif',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none),
                          fillColor: Colors.yellow.shade50,
                          filled: true,
                          suffixText: 'F CFA'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: DisplayFieldWidget(
                        title: 'Nom de demandeur :', text: widget.demande.user),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: DisplayFieldWidget(
                        title: 'Service', text: widget.demande.service),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: DisplayFieldWidget(
                        title: 'Date de la demande:',
                        text:
                            Utils.dateFull.format(widget.demande.dateCreated)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: DisplayFieldWidget(
                        title: 'Date de la dernière mise à jour:',
                        text:
                            Utils.dateFull.format(widget.demande.dateUpdated)),
                  ),
                ])),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              //minimumSize: const Size(double.infinity, 50),

                              foregroundColor: Colors.white,
                              backgroundColor: AppPalette.errorMessageColor,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(8.0))),
                          child: const Text('Annuler')),
                      const Gap(20),
                      ElevatedButton(
                        onPressed: () async {
                          final nv = Navigator.of(context);
                          if (_formKey.currentState!.validate()) {
                            setState(() => isSaving = true);
                            final now = DateTime.now();
                            final mtDefinitif =
                                double.parse(_montantDefinitifController.text);
                            // Enregistrer la demande
                            if (mtDefinitif != 0) {
                              DemandeModel demandeUpdated = DemandeModel(
                                  objet: widget.demande.objet,
                                  dateCreated: widget.demande.dateCreated,
                                  dateUpdated: now,
                                  montantDefinitif: mtDefinitif,
                                  montantPrevisionnel:
                                      widget.demande.montantPrevisionnel,
                                  service: widget.demande.service,
                                  statut: widget.demande.statut,
                                  user: widget.demande.user,
                                  userUid: widget.demande.userUid);
                              //print('Demande updated: $demandeUpdated');

                              await ref
                                  .read(demandeRepoProvider)
                                  .updateDemande(widget.docId, demandeUpdated);

                              final budget = await ref
                                  .read(budgetRepoProvider)
                                  .getCurrent();
                              if (budget != null) {
                                if (demandeUpdated.montantDefinitif !=
                                    widget.demande.montantPrevisionnel) {
                                  final newSoldeTheorique =
                                      budget.soldeTheorique -
                                          mtDefinitif +
                                          widget.demande.montantPrevisionnel;
                                  final newSoldeReel = budget.soldeReel -
                                      mtDefinitif +
                                      widget.demande.montantPrevisionnel;

                                  final newBudget = budget.copyWith(
                                      soldeReel: newSoldeReel,
                                      soldeTheorique: newSoldeTheorique);

                                  print('newBudget: $newBudget');

                                  await ref
                                      .read(budgetRepoProvider)
                                      .update(budget.id!, newBudget);
                                } else {
                                  print('Budget non modifié');
                                }
                              } else {
                                print('Ligne non trouvée!');
                              }

                              setState(() => isSaving = false);
                              Utils.showSuccessMessage(
                                  message: 'Demande clôturée!');
                              ref.invalidate(demandeRepoProvider);
                            } else {
                              print(
                                  'Aucune modif. Mt Definitif non renseigné!');
                            }
                            nv.pop();
                            //clearFields();
                          } else {
                            Utils.showErrorMessage(
                                message: 'Veuillez renseigner tous les champs');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            //minimumSize: const Size(double.infinity, 50),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                side: BorderSide.none,
                                borderRadius: BorderRadius.circular(8.0))),
                        child: isSaving == true
                            ? const Loading()
                            : const Text('Enregistrer',
                                style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ));
  }

  passwordValidator(String? value) {
    var resultCheck = value!.isEmpty
        ? null
        : value.length < 4
            ? 'Le mot de passe doit comporter au minimum 4 caractères'
            : null;

    return resultCheck;
  }
}


/*
 print('Montant Définitif: $mtDefinitif');
                                    print(
                                        'Montant Prévisionnel: ${widget.demande.montantPrevisionnel}');
                                    print(
                                        'Ecart: ${widget.demande.montantPrevisionnel - mtDefinitif}');
                                    print(
                                        'Ancien solde réel: ${budget.soldeReel}');
                                    print(
                                        'Nouveau Solde réel: ${budget.soldeReel + widget.demande.montantPrevisionnel - mtDefinitif}');
*/