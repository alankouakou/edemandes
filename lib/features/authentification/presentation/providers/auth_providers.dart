import 'package:demandes/features/authentification/data/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepoProvider = Provider<AuthRepository>(
  (ref) => AuthRepository(),
);

final authStreamProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepoProvider);
  return authRepository.authStateChanges;
});
