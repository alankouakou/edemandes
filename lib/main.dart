import 'package:demandes/features/authentification/presentation/bloc/auth_bloc.dart';
import 'package:demandes/features/authentification/presentation/pages/auth_state_page.dart';
import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/init_dependencies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(ProviderScope(
    child: MultiBlocProvider(providers: [
      BlocProvider(
        create: (create) => serviceLocator<AuthBloc>(),
      ),
    ], child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightThemeMode,
      home: const AuthStatePage(),
    );
  }
}
