import 'package:demandes/features/authentification/presentation/bloc/auth_bloc.dart';
import 'package:demandes/features/authentification/presentation/widgets/auth_button.dart';
import 'package:demandes/features/authentification/presentation/widgets/auth_field.dart';
import 'package:demandes/features/authentification/presentation/widgets/auth_password_field.dart';
import 'package:demandes/core/themes/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const SignupPage());
  }

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
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
        backgroundColor: AppPalette.scaffoldLightBackgroundColor,
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Nouveau compte',
                        style: TextStyle(
                            fontSize: 22,
                            color: Color(0xFFF3774D),
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: AuthField(
                        controller: _nameController,
                        hintText: 'Name',
                        suffixIcon: const Icon(Icons.mail),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: AuthField(
                        controller: _emailController,
                        hintText: 'E-mail',
                        suffixIcon: const Icon(Icons.mail),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: AuthPasswordField(
                          controller: _passwordController,
                          hintText: 'Entrez le mot de passe',
                        )),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: AuthPasswordField(
                          confirmPasswordField: _passwordController,
                          controller: _repeatPasswordController,
                          hintText: 'Confirmez le mot de passe',
                        )),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: AuthButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  AuthSignUp(
                                      name: _nameController.text.trim(),
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim()),
                                );
                            //signUp(_emailController.text,
                            //    _passwordController.text);
                            Navigator.pop(context);
                          }
                        },
                        title: 'Créer le compte',
                      ),
                    ),
                    const SizedBox(height: 200.0),
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
