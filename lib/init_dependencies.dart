import 'package:demandes/core/secrets/supabase_secret.dart';
import 'package:demandes/features/authentification/data/datasources/auth_remote_datasource.dart';
import 'package:demandes/features/authentification/data/repositories/auth_repository_impl.dart';
import 'package:demandes/features/authentification/domain/repository/auth_repository.dart';
import 'package:demandes/features/authentification/domain/usecases/user_sign_up.dart';
import 'package:demandes/features/authentification/presentation/bloc/auth_bloc.dart';
import 'package:demandes/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: SupabaseSecret.url, anonKey: SupabaseSecret.anonKey);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignUp(serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignUp: serviceLocator(),
    ),
  );
}
