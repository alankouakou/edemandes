import 'package:demandes/core/messaging/repository/user_token_repository.dart';
import 'package:demandes/core/widgets/loading_white.dart';

import 'package:demandes/features/authentification/presentation/pages/reset_password_page.dart';
import 'package:demandes/features/authentification/presentation/pages/signup_page.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  String response = '';
  String caisse = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade50,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Gap(50),
                    Container(
                        height: 180.0,
                        width: 180.0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/icon/logo_pcelfi.png'),
                          radius: 100,
                        )),
                    const Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: _emailController,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'E-mail obligatoire'
                            : null,
                        decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 30),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            hintText: 'E-mail',
                            suffixIcon: Icon(Icons.person)),
                      ),
                    ),
                    const Gap(10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TextFormField(
                        controller: _passwordController,
                        validator: (value) => (value == null || value.isEmpty)
                            ? 'Entrez le mot de passe !'
                            : null,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            hintText: 'Password',
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: _obscureText == true
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        //final sm = ScaffoldMessenger.of(context);
                        final nv = Navigator.of(context);
                        nv.push(MaterialPageRoute(
                            builder: (context) => const ResetPasswordPage()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('Mot de passe oublié?',
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFFFF6F00))),
                        ),
                      ),
                    ),
                    const Gap(10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 30.0),
                      child: OutlinedButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              final usercredentials = await ref
                                  .read(authRepoProvider)
                                  .signinWithEmailAndPassword(
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim());

                              if (usercredentials == null) {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50.0),
                          ),
                          child: isLoading == true
                              ? const LoadingWhite()
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Vous n\'avez pas de compte?',
                            style: TextStyle(fontSize: 14)),
                        const Gap(10),
                        GestureDetector(
                          onTap: () {
                            final nv = Navigator.of(context);
                            nv.push(MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                          },
                          child: const Text('Créez un compte',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF6F00))),
                        )
                      ],
                    ),
                    const Gap(30),
                  ]),
            ),
          ),
        ));
  }
}
