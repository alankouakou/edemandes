import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarTitle extends ConsumerWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authRepoProvider).currentUser!.uid;
    final userName = ref.watch(userRepositoryProvider).getUsername(uid);
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: const Text('Bonjour',
          style: TextStyle(fontSize: 14, color: Colors.black54)),
      subtitle: FutureBuilder(
          future: userName,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text(snapshot.error.toString());
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else {
              return const Text('Pas de données');
            }
          }),
    );
  }
}
