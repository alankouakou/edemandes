import 'package:demandes/core/services.dart';
import 'package:demandes/core/services/providers/service_notifier_provider.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/core/widgets/loading_white.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
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
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _roleController = TextEditingController(text: 'user');
  final _serviceController = TextEditingController();
  //late final List<DropdownMenuItem<String>> items;

  bool isVisible = true;
  bool isLoading = false;
  bool isProcessingData = false;
  String _serviceDropDownValue = 'N/A';

  Future<void> signUp(String email, String password) async {}

  @override
  void initState() {
    isLoading = false;
    isProcessingData = false;
    super.initState();
  }

  void toggleVisibility() {
    setState(
      () {
        isVisible = !isVisible;
      },
    );
  }

  void resetFields() {
    _emailController.clear();
    _passwordController.clear();
    _repeatPasswordController.clear();
    _nomController.clear();
    _prenomController.clear();
    _roleController.clear();
    _serviceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final nav = Navigator.of(context);
    final asyncServices = ref.watch(serviceNotifierProvider);
    final temp = services.map((service) {
      return DropdownMenuItem<String>(
        value: service['code'],
        child: Text(service['libelle'] ?? ''),
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(title: const Text('Sign Up')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Text('Nouveau compte',
                          style: TextStyle(
                              fontSize: 22,
                              color: Color(0xFFF3774D),
                              fontWeight: FontWeight.bold)),
                    ),

                    // Dropdownn Service
                    asyncServices.when(
                      data: (items) {
                        print('services From firestore: ${items.length}');
                        final serviceItems = items.map(
                          (e) {
                            return DropdownMenuItem<String>(
                              value: e.libelle,
                              child: Text(e.libelle),
                            );
                          },
                        ).toList();
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 8.0),
                          child: DropdownButton<String>(
                              hint: const Text('Service'),
                              value: _serviceDropDownValue,
                              items: serviceItems,
                              onChanged: (String? newValue) {
                                setState(
                                    () => _serviceDropDownValue = newValue!);
                              }),
                        );
                      },
                      error: (e, s) => Center(child: Text(e.toString())),
                      loading: () => const Loading(),
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
                    //Nom
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _nomController,
                        validator: (value) => value!.isEmpty
                            ? 'Renseignez le champ Nom'
                            : null, // Le login doit être unique
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            hintText: 'Nom',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    //Prenom
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: _prenomController,
                        validator: (value) => value!.isEmpty
                            ? 'Renseignez le champ prenom'
                            : null, // Le login doit être unique
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                            hintText: 'Prenom',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            filled: true),
                      ),
                    ),
                    //Service

                    //Role
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
                        validator: (value) =>
                            (value == _passwordController.text)
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
                                try {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                      isProcessingData = true;
                                    });
                                    print(
                                        'UID: ${ref.read(authRepoProvider).currentUser?.uid}');
                                    await ref
                                        .read(authRepoProvider)
                                        .createUserWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text)
                                        .then(
                                      (value) async {
                                        await ref
                                            .read(userRepositoryProvider)
                                            .registerUser(
                                                uid: value!.uid,
                                                email: _emailController.text,
                                                nom: _nomController.text,
                                                prenom: _prenomController.text,
                                                service: _serviceDropDownValue,
                                                role: 'USER');

                                        print(
                                            'Enreigstrement des infos user dans firestore');
                                      },
                                    ).whenComplete(() {
                                      _formKey.currentState!.reset();

                                      print(
                                          'UID: ${ref.read(authRepoProvider).currentUser?.uid}');
                                      setState(() {
                                        isLoading = false;
                                      });
                                      nav.pop();
                                    });
                                  }
                                } catch (e) {
                                  print(e.toString);
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: isLoading == true
                            ? const LoadingWhite()
                            : const Text('Créer le compte',
                                style: TextStyle(fontSize: 16)),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  passwordValidator(String? value) {
    var resultCheck = (value != null && value.length >= 6)
        ? null
        : 'Mot de passe invlide (minimum 6 caractères)';

    return resultCheck;
  }
}
