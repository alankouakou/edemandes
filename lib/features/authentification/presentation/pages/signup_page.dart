import 'package:demandes/features/authentification/presentation/widgets/auth_field.dart';
import 'package:demandes/features/authentification/presentation/widgets/auth_password_field.dart';
import 'package:demandes/core/themes/app_palette.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(title: const Text('Sign Up')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signUp(_emailController.text, _passwordController.text);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.infinity, 50),
                        foregroundColor: Colors.white,
                        backgroundColor: AppPalette.buttonBackgroundColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.circular(8.0))),
                    child: const Text('Créer le compte',
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
