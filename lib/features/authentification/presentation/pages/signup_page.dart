import 'package:demandes/core/utils.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _formKey = GlobalKey<FormState>();

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  Future<void> signUp(String email, String password) async {}

  @override
  void initState() {
    isLoading = false;
  }

  void toggleVisibility() {
    setState(
      () {
        isVisible = !isVisible;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authStreamProvider, (previous, next) {
      Utils.showSuccessMessage(
          message: "Utilisateur ${next.value?.uid} créé avec succès!");
      Navigator.pop(context);
    });
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(title: const Text('Sign Up')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text('Nouveau compte',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFFF3774D),
                          fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) => value!.isEmpty
                        ? 'Renseignez le champ e-mail'
                        : null, // Le login doit être unique
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        hintText: 'E-mail',
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
                    controller: _passwordController,
                    validator: (value) => passwordValidator(value),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      hintText: 'Mot de passe',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: toggleVisibility,
                        icon: isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: _repeatPasswordController,
                    validator: (value) => (value == _passwordController.text)
                        ? null
                        : 'Verifiez le mot de passe',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: isVisible,
                    decoration: InputDecoration(
                      hintText: 'Entrez à nouveau le mot de passe',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: IconButton(
                        onPressed: toggleVisibility,
                        icon: isVisible
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: isLoading == true
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              print(
                                  'UID: ${ref.read(authRepoProvider).currentUser?.uid}');
                              final user = await ref
                                  .read(authRepoProvider)
                                  .createUserWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                              print(
                                  'UID: ${ref.read(authRepoProvider).currentUser?.uid}');
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: isLoading == true
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : const Text('Créer le compte',
                            style: TextStyle(fontSize: 16)),
                  ),
                )
              ]),
            ),
          ),
        ));
  }

  passwordValidator(String? value) {
    var resultCheck = (value != null && value.length >= 6)
        ? null
        : 'Mot de passe invlide (minimum 6 caractères)';

    return resultCheck;
  }
}
