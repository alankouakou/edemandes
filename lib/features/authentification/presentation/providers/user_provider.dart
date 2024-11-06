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

final userNotifierProvider =
    AutoDisposeAsyncNotifierProvider<UserNotifier, User>(
  UserNotifier.new,
);

/*
'user'
'manager'
'validator'
'accountant'
'admin'


final currentUserRoleProvider = StateProvider<String>((ref) => '');
final userNameProvider = StateProvider<String>((ref) => 'username');
*/

final futureUserProvider = FutureProvider<User>((ref) async {
  final uid = ref.watch(authRepoProvider).currentUser!.uid;

  final user = await ref.watch(userRepositoryProvider).fetchUser(uid);

  return user;
});
