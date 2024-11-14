import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/demandes/presentation/pages/validation_page.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_stream_provider.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DemandesRaf extends ConsumerWidget {
  const DemandesRaf({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userUid = ref.watch(authRepoProvider).currentUser!.uid;

    print('User demandesByStatusPage - User UID: $userUid');
    final statusDemandes = ref.watch(rafStreamProvider);

    //
    //
    return Scaffold(
      body: statusDemandes.when(
        data: (dataList) => ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (context, index) {
            return DemandeWidget(
              demande: dataList[index],
              onTap: () => Navigator.push(
                  context, ValidationPage.route(dataList[index])),
            );
          },
        ),
        error: (e, s) => Center(child: Text(s.toString())),
        loading: () => const Loading(),
      ),
    );
  }
}
