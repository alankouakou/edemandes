import 'dart:async';

import 'package:demandes/features/authentification/domain/models/user.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:demandes/features/budget/presentation/providers/budget_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends AutoDisposeAsyncNotifier<User> {
  @override
  FutureOr<User> build() async {
    final auth = ref.watch(authRepoProvider);
    final budgetRepo = ref.watch(budgetRepoProvider);
    final userRepository = ref.watch(userRepositoryProvider);
    final varUser = await userRepository.fetchUser(auth.currentUser!.uid);
    //init User Role Provider
    ref.read(roleProvider.notifier).state = varUser.role;

    return await userRepository.fetchUser(auth.currentUser!.uid);
  }
}
