import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/features/demandes/presentation/pages/add_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/details_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/validation_page.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_stream_provider.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListDemandesPage extends ConsumerWidget {
  const ListDemandesPage({super.key});

  static Route route() =>
      MaterialPageRoute(builder: (context) => const ListDemandesPage());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamDemandes = ref.watch(demandeStreamProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: .0),
        child: Column(children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            height: 50,
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Toutes les demandes', style: AppTheme.pageTitleStyle),
                ],
              ),
            ),
          ),
          Expanded(
              child: streamDemandes.when(
                  data: (dataList) => ListView.builder(
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return DemandeWidget(
                              demande: dataList[index],
                              onTap: () => Navigator.push(context,
                                  DetailsDemandePage.route(dataList[index])));
                        },
                      ),
                  error: (e, s) => Center(child: Text(s.toString())),
                  loading: () => const Center(
                      child: CircularProgressIndicator(
                          color: AppPalette.buttonBackgroundColor)))),
        ]),
      ),
    );
  }
}
