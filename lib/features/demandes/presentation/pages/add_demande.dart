import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _formKey = GlobalKey<FormState>();

class AddDemande extends StatefulWidget {
  const AddDemande({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const AddDemande());
  }

  @override
  State<AddDemande> createState() => _SignUpState();
}

class _SignUpState extends State<AddDemande> {
  final _objetController = TextEditingController();
  final _montantPrevisionnelController = TextEditingController();
  bool isVisible = true;

  Future<void> signUp(String email, String password) async {}

  void toggleVisibility() {
    setState(
      () {
        isVisible = !isVisible;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text('Nouvelle Demande',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFFF3774D),
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: _objetController,
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
                      LengthLimitingTextInputFormatter(6)
                    ],
                    controller: _montantPrevisionnelController,
                    validator: (value) => value!.isEmpty
                        ? 'Renseignez le montant'
                        : null, // Le login doit être unique
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,

                    decoration: InputDecoration(
                        hintText: 'Montant prévisionnel de la demande',
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Enregistrer la demande
                        Utils.showSuccessMessage(
                            message: 'Implementez la fonctionnalité');
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
                    child: const Text('Enregistrer la demande',
                        style: TextStyle(fontSize: 16)),
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
