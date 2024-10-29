import 'package:demandes/core/themes/app_theme.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/features/demandes/presentation/widgets/appbar_title.dart';
import 'package:demandes/features/demandes/presentation/widgets/display_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class ValidationPage extends StatelessWidget {
  const ValidationPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const ValidationPage());
  }

  @override
  Widget build(BuildContext context) {
    final montantDemande = Utils.formatCFA(500000);
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle()),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView(
              children: [
                const Text('Validation Page', style: AppTheme.pageTitleStyle),
                const Gap(10),
                const DisplayFieldWidget(
                    title: 'Objet de la demande',
                    text:
                        'zefzefergzergergzergzegregezgergregegegzrgegzegeazgerageagreagerageragaergaegaergaegeagagaergeageargergergeg'),
                const Gap(20),
                DisplayFieldWidget(
                    title: 'Montant prévisionnel', text: montantDemande),
                const Gap(20),
                const DisplayFieldWidget(title: 'Demandeur:', text: ' XXXXXXX'),
                const Gap(20),
                const DisplayFieldWidget(title: 'Service: ', text: 'ZZZZ'),
                const Gap(20),
                const DisplayFieldWidget(
                    title: 'Visa chef service:', text: 'jj/mm/aaaa'),
                const Gap(20),
                const DisplayFieldWidget(
                    title: 'Visa RAF:', text: 'jj/mm/aaaa'),
                const Gap(20),
                const DisplayFieldWidget(
                    title: 'Visa Coordonnateur:', text: 'jj/mm/aaaa'),
                const Gap(20),
                const DisplayFieldWidget(
                    title: 'Date de la demande:', text: 'jj/mm/aaaa'),
                const Gap(20),
              ],
            )),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {},
                      child: const Text(
                        'Rejeter',
                      )),
                  const Gap(20.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {},
                      child: const Text(
                        'Approuver',
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
