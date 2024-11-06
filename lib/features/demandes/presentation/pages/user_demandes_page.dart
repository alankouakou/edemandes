import 'package:demandes/features/authentification/presentation/providers/auth_providers.dart';
import 'package:demandes/features/demandes/presentation/pages/details_demande_page.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_providers.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDemandesPage extends ConsumerWidget {
  const UserDemandesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userUid = ref.watch(authRepoProvider).currentUser!.uid;

    print('User demandesPage - User UID: $userUid');
    final userDemandes = ref.watch(demandeRepoProvider).fetchByUserUid(userUid);
    //
    //
    return Scaffold(
      body: FutureBuilder(
        future: userDemandes,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final dataList = snapshot.data;
            print('Nb items: ${dataList!.length}');
            return ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                return DemandeWidget(
                  demande: dataList[index],
                  onTap: () => Navigator.push(
                      context, DetailsDemandePage.route(dataList[index])),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const Center(child: Text('Pas de données'));
          }
        },
      ),
    );
  }
}
