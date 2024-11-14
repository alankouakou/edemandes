import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_stream_provider.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDemandesPageSav extends ConsumerWidget {
  const UserDemandesPageSav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamDemandes = ref.watch(demandeStreamProvider);
    return Scaffold(
        body: streamDemandes.when(
            data: (dataList) => ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return DemandeWidget(
                        demande: dataList[index], onTap: () {});
                  },
                ),
            error: (e, s) => Center(child: Text(s.toString())),
            loading: () => const Loading()));
  }
}
