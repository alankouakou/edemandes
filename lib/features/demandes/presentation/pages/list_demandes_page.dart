import 'package:demandes/core/printing/printing_service.dart';
import 'package:demandes/core/themes/app_palette.dart';
import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/widgets/loading.dart';
import 'package:demandes/features/budget/presentation/providers/budget_provider.dart';
import 'package:demandes/features/budget/presentation/providers/decaissement_notifier.dart';
import 'package:demandes/features/demandes/presentation/pages/add_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/details_demande_page.dart';
import 'package:demandes/features/demandes/presentation/pages/validation_page.dart';
import 'package:demandes/features/demandes/presentation/providers/demande_stream_provider.dart';
import 'package:demandes/features/demandes/presentation/widgets/demande_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //const Text('Toutes les demandes',
                  //    style: AppTheme.pageTitleStyle),
                  IconButton(
                      onPressed: () async {
                        //TODO Récuperer les decaissements et imprimer le rapport
                        final decaissements = await ref
                            .read(decaissementsNotifierProvider.notifier)
                            .fetchAll();

                        print('Nb decaissements: ${decaissements.length}');
                        await PrintingService.printReport(decaissements);
                      },
                      icon: const FaIcon(FontAwesomeIcons.solidFilePdf,
                          color: AppPalette.buttonBackgroundColor))
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
                  loading: () => const Loading())),
        ]),
      ),
    );
  }
}
