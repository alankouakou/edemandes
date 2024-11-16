import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/authentification/presentation/providers/user_provider.dart';
import 'package:demandes/features/demandes/presentation/pages/details_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/validation_page.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemandeServicePage extends ConsumerWidget {
  const DemandeServicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userUid = ref.watch(authRepoProvider).currentUser!.uid;
    final asyncUser = ref.watch(userNotifierProvider);

    print('User demandesPage - User UID: $userUid');
    final serviceName = ref.watch(serviceProvider);
    final listDemandes =
        ref.watch(demandeRepoProvider).getByService(serviceName);
    //
    //
    return Scaffold(
      body: FutureBuilder(
          future: listDemandes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final dataList = snapshot.data;
              return ListView(
                  children: dataList!.map((e) {
                return DemandeWidget(
                  demande: e,
                  onTap: () =>
                      Navigator.push(context, DetailsDemandePage.route(e)),
                );
              }).toList());
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loading();
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Text('Pas de données');
            }
          }),
    );
  }
}
