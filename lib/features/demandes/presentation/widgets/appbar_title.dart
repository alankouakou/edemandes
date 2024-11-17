import 'package:demandes/core/widgets/loading.dart';

import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBarTitle extends ConsumerWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uid = ref.watch(authRepoProvider).currentUser!.uid;
    final userName = ref.watch(userRepositoryProvider).getUsername(uid);
    return ListTile(
      leading: GestureDetector(
        onTap: () async {
          final asyncUser = ref.watch(userNotifierProvider);
          final userRole = ref.watch(roleProvider);
          final serviceName = ref.watch(serviceProvider);
          showDialog(
              context: context,
              builder: (context) {
                const fontSize = 16.0;
                const couleur = Colors.blueGrey;
                const couleurNoire = Colors.black87;
                return AlertDialog(
                  backgroundColor: Colors.white,
                  title: const Text('Informations compte',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize,
                          color: Colors.blueGrey)),
                  content: asyncUser.when(
                    data: (user) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: 'Nom :',
                                style: const TextStyle(
                                    fontSize: fontSize,
                                    color: couleur,
                                    fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: '  ${user.username}',
                                  style: const TextStyle(
                                      fontSize: fontSize,
                                      color: couleurNoire,
                                      fontWeight: FontWeight.normal)),
                            ])),
                        RichText(
                            text: TextSpan(
                                text: 'Dir./Service :',
                                style: const TextStyle(
                                    fontSize: fontSize,
                                    color: couleur,
                                    fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: '  $serviceName',
                                  style: const TextStyle(
                                      fontSize: fontSize,
                                      color: couleurNoire,
                                      fontWeight: FontWeight.normal)),
                            ])),
                        RichText(
                            text: TextSpan(
                                text: 'Profil :',
                                style: const TextStyle(
                                    fontSize: fontSize,
                                    color: couleur,
                                    fontWeight: FontWeight.bold),
                                children: [
                              TextSpan(
                                  text: '  $userRole',
                                  style: const TextStyle(
                                      fontSize: fontSize,
                                      color: couleurNoire,
                                      fontWeight: FontWeight.normal)),
                            ])),
                      ],
                    ),
                    error: (e, s) => Text(e.toString()),
                    loading: () => const Loading(),
                  ),
                  actions: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        },
        child: const CircleAvatar(
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.person, color: Colors.white),
        ),
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
