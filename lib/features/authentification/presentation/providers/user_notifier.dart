import 'dart:async';

import 'package:demandes/features/authentification/domain/models/user.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends AutoDisposeAsyncNotifier<User> {
  @override
  FutureOr<User> build() async {
    final auth = ref.watch(authRepoProvider);
    final userRepository = ref.watch(userRepositoryProvider);
    return await userRepository.fetchUser(auth.currentUser!.uid);
  }
}
