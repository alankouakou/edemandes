import 'package:demandes/features/authentification/data/datasources/user_datasource.dart';
import 'package:demandes/features/authentification/data/repositories/user_repository.dart';
import 'package:demandes/features/authentification/domain/models/user.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  UserDatasource userDS = UserDatasource();
  return UserRepositoryImpl(userDS);
});

final auth = Provider((ref) => ref.watch(authRepoProvider));
final roleProvider = StateProvider<String>((ref) => '');

final userNotifierProvider =
    AutoDisposeAsyncNotifierProvider<UserNotifier, User>(
  UserNotifier.new,
);

/*
'user'
'admin'
'chef_service'
'raf'
'coordonnateur'
*/

final serviceNameProvider = StateProvider<String>((ref) {
  final user = ref.watch(futureUserProvider);
  return user.when(
    data: (data) => data.service,
    loading: () => '',
    error: (e, s) => '',
  );
});
final futureUserProvider = FutureProvider<User>((ref) async {
  final uid = ref.watch(authRepoProvider).currentUser!.uid;

  final user = await ref.watch(userRepositoryProvider).fetchUser(uid);

  return user;
});
