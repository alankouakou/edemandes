import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';
import 'package:demandes/features/demandes/presentation/pages/main_menu.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _formKey = GlobalKey<FormState>();

class AddDemandePage extends ConsumerStatefulWidget {
  const AddDemandePage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const AddDemandePage());
  }

  @override
  ConsumerState<AddDemandePage> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<AddDemandePage> {
  final _objetController = TextEditingController();
  final _montantPrevisionnelController = TextEditingController();
  final _montantDefinitifController = TextEditingController();
  final _serviceController = TextEditingController();
  final _userController = TextEditingController();

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
    _objetController.clear();
    _montantPrevisionnelController.clear();
    _montantDefinitifController.clear();
    _serviceController.clear();
    _userController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userNotifierProvider);
    user.when(
        data: (data) {
          _userController.text = data.username;
          _serviceController.text = data.service;
        },
        error: (error, stackTrace) => null,
        loading: () => null);
    List<String> services = [
      'Audit',
      'Comptabilité',
      'Direction Générale',
      'Informatique',
      'Moyens généraux',
    ];

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
                    child: Text('Nouvelle Demande',
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
                    child: TextFormField(
                      enabled: false,
                      controller: _serviceController,
                      validator: (value) =>
                          value!.isEmpty ? 'Renseignez le service' : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          hintText: 'Service du demandeur',
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
                      enabled: false,
                      controller: _userController,
                      validator: (value) => value!.isEmpty
                          ? 'Renseignez le nom du demandeur'
                          : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                          hintText: 'Nom demandeur',
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
                          String uid =
                              ref.read(authRepoProvider).currentUser!.uid;

                          setState(() => isSaving = true);
                          final now = DateTime.now();
                          // Enregistrer la demande
                          DemandeModel demande = DemandeModel(
                              objet: _objetController.text,
                              dateCreated: now,
                              dateUpdated: now,
                              montantDefinitif: 0.0,
                              montantPrevisionnel: double.parse(
                                  _montantPrevisionnelController.text),
                              service: _serviceController.text,
                              statut: 1,
                              user: _userController.text,
                              userUid: uid);
                          await ref
                              .read(demandeRepoProvider)
                              .addNewDemande(demande);
                          setState(() => isSaving = false);
                          Utils.showSuccessMessage(message: 'Demande créée');
                          ref.read(pageIndexProvider.notifier).state = 0;
                          clearFields();
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
                          ? const Center(child: CircularProgressIndicator())
                          : const Text('Enregistrer la demande',
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
