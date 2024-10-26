import 'package:demandes/features/authentification/presentation/pages/reset_password_page.dart';
import 'package:demandes/features/authentification/presentation/pages/signup_page.dart';
import 'package:demandes/features/authentification/presentation/widgets/auth_button.dart';
import 'package:demandes/features/authentification/presentation/widgets/auth_field.dart';
import 'package:demandes/features/authentification/presentation/widgets/auth_password_field.dart';
import 'package:demandes/core/themes/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:demandes/features/authentification/data/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signinWithEmailAndPassword(String email, String password) async {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppPalette.scaffoldLightBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 50),
                    Container(
                        height: 180.0,
                        width: 180.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/green_shield.jpeg'),
                          radius: 100,
                        )),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: AuthField(
                          controller: _emailController,
                          hintText: 'E-mail',
                          suffixIcon: const Icon(Icons.person)),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: AuthPasswordField(
                        confirmPasswordField: _passwordController,
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, ResetPasswordPage.route());
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('Mot de passe oublié?',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF6F00))),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30.0),
                      child: AuthButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            signinWithEmailAndPassword(email, password);
                          }
                        },
                        title: 'Login',
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, SignupPage.route());
                      },
                      child: RichText(
                          text: const TextSpan(
                              text: 'Vous n\'avez pas de compte? ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                              children: [
                            TextSpan(
                                text: 'Créez un compte',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFFF6F00))),
                          ])),
                    ),
                    const SizedBox(height: 30),
                  ]),
            ),
          ),
        ));
  }
}
