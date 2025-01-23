import 'package:demandes/core/statuts.dart';
import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';
import 'package:demandes/features/demandes/domain/entities/demande.dart';
import 'package:demandes/features/demandes/presentation/pages/main_menu.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';
import 'package:demandes/features/demandes/presentation/widgets/display_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _formKey = GlobalKey<FormState>();

class EditDemandePage extends ConsumerStatefulWidget {
  final String docId;
  final DemandeModel demande;
  const EditDemandePage(
      {super.key, required this.docId, required this.demande});

  static Route route(String docId, DemandeModel demande) {
    return MaterialPageRoute(
        builder: (_) => EditDemandePage(docId: docId, demande: demande));
  }

  @override
  ConsumerState<EditDemandePage> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<EditDemandePage> {
  final _objetController = TextEditingController();
  final _montantPrevisionnelController = TextEditingController();

  bool isVisible = true;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    isSaving = false;
    _objetController.text = widget.demande.objet;
    _montantPrevisionnelController.text =
        widget.demande.montantPrevisionnel.toString();
  }

  void toggleVisibility() {
    setState(
      () {
        isVisible = !isVisible;
      },
    );
  }

  void clearFields() {
    _objetController.clear();
    _montantPrevisionnelController.clear();
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Text('Modifier Demande',
                        style: AppTheme.pageTitleStyle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      controller: _objetController,
                      maxLines: 5,
                      validator: (value) => value!.isEmpty
                          ? 'Renseignez l\'Objet de la demande'
                          : null, // Le login doit être unique
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          hintText: 'Objet de la demande',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none),
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(8)
                      ],
                      controller: _montantPrevisionnelController,
                      validator: (value) => value!.isEmpty
                          ? 'Renseignez le montant'
                          : null, // Le login doit être unique
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                          hintText: 'Montant prévisionnel',
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
                    child: DisplayFieldWidget(
                        title: 'Service', text: widget.demande.service),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: DisplayFieldWidget(
                        title: 'Nom de demandeur :', text: widget.demande.user),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final nv = Navigator.of(context);
                        if (_formKey.currentState!.validate()) {
                          setState(() => isSaving = true);
                          final now = DateTime.now();
                          // Enregistrer la demande
                          DemandeModel demandeUpdated = DemandeModel(
                              objet: _objetController.text,
                              dateCreated: widget.demande.dateCreated,
                              dateUpdated: now,
                              montantDefinitif: widget.demande.montantDefinitif,
                              montantPrevisionnel: double.parse(
                                  _montantPrevisionnelController.text),
                              service: widget.demande.service,
                              statut: widget.demande.statut,
                              user: widget.demande.user,
                              userUid: widget.demande.userUid);
                          await ref
                              .read(demandeRepoProvider)
                              .updateDemande(widget.docId, demandeUpdated);
                          setState(() => isSaving = false);
                          Utils.showSuccessMessage(
                              message: 'Demande actualisée!');
                          ref.invalidate(demandeRepoProvider);
                          nv.pop();
                          //clearFields();
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
