import 'dart:ffi';
import 'dart:io';
import 'package:demandes/core/statuts.dart';
import 'package:demandes/core/utils.dart';
import 'package:demandes/features/budget/data/models/decaissement.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';
import 'package:demandes/features/demandes/domain/entities/demande.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PrintingService {
  // Generate  report
  static Future<Uint8List> generateReport(
      List<DecaissementModel> decaissements) async {
    // Tableau recapitulatif

    final pdf = pw.Document();

    final logoEntreprise =
        (await rootBundle.load('assets/icon/logo_pcelfi.png'))
            .buffer
            .asUint8List();

    final headers = [
      'Date \ndecaissement',
      'Objet',
      'Montant \nprévisionnel (FCFA)',
      'Montant \ndéfinitif (FCFA)',
      'Cumul \ndecaisse (FCFA)',
      'Solde \n(FCFA)'
    ];

    final List<List<String>> mvtDecaissements = decaissements.map((e) {
      return [
        e.dateDecaissement.longDate,
        e.objetDemande,
        e.montantPrevisionnel.francCFA,
        e.montantDefinitif == 0
            ? e.montantPrevisionnel.francCFA
            : e.montantDefinitif.francCFA,
        e.cumulDecaisse.francCFA,
        e.solde.francCFA
      ];
    }).toList();

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          return [
            pw.Image(width: 80, height: 80, pw.MemoryImage(logoEntreprise)),
            pw.SizedBox(height: 30.0),
            pw.Center(
                child: pw.Text('LISTE DETAILLEE DES DECAISSEMENTS',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold))),
            pw.SizedBox(height: 10),
            pw.TableHelper.fromTextArray(
                headers: headers,
                data: mvtDecaissements,
                columnWidths: {
                  0: pw.FlexColumnWidth(),
                  1: pw.FixedColumnWidth(200),
                  2: pw.FlexColumnWidth(),
                  3: pw.FlexColumnWidth(),
                  4: pw.FlexColumnWidth(),
                  5: pw.FlexColumnWidth(),
                },
                headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.teal),
                cellHeight: 25,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerRight,
                  3: pw.Alignment.centerRight,
                  4: pw.Alignment.centerRight,
                  5: pw.Alignment.centerRight,
                }),
          ];
        }));

    print('pdf daily report ends!');
    return pdf.save();
  }

  static Future<Uint8List> generateDocument(DemandeModel demande) async {
    print('Demande à imprimer: ${demande.docId}');
    final pdf = pw.Document(
        author: demande.user, title: 'Fiche de décaissement ${demande.docId}');

    const textMinistere = "MINISTERE DE L'EDUCATION NATIONALE";
    const textMinistereSuite = "ET DE L'ALPHABETISATION";
    const textRepublique = "REPUBLIQUE DE COTE D'IVOIRE";
    const textDeviseCI = "Union - Discipline - Travail";
    const textLogo = "Projet de Construction et d'Equipement de Six";
    const textLogoSuite = "(06) Lycées d'Excellence pour Filles";
    const textLogoSuite2 = "avec Internats";
    const notaBene =
        "NB : Les pièces justificatives doivent être transmises dans un délai de 48h après l'activité";
    const piedDePage = "Cocody, II Plateaux 7eme tranche, lot 2814, ilôt 234";
    const piedDePageSuite =
        "28 BP 966 ABIDJAN 28 / Tél: 27 22 42 71 45 / Mob: 07 57 65 68 53/ E-mail: ugp.pcelfi3@gmail.com";

    final infosDemande = [
      ['Date demande :', Utils.dateFull.format(demande.dateCreated)],
      ['Objet de la demande :', demande.objet],
      ['Nom du demandeur :', demande.user],
      ['Service du demandeur :', demande.service],
      [
        'Montant \nprévisionnel :',
        Utils.formatCFA(demande.montantPrevisionnel)
      ],
      [
        'Montant \ndéfinitif :',
        demande.montantDefinitif == 0
            ? demande.montantPrevisionnel.francCFA
            : demande.montantDefinitif.francCFA
      ],
      //['Visa du chef de service :', ''],
      //['Visa du RAF :', ''],
    ];

    final infosVisas = [
      ['Visa \ndu Coordonnateur :', ''],
      ["Visa \nde l'Agent Comptable :", ''],
    ];

    final logoEntreprise =
        (await rootBundle.load('assets/icon/logo_pcelfi.png'))
            .buffer
            .asUint8List();

    // Ajouter entete
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context context) => [
          pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(textMinistere,
                      style: const pw.TextStyle(fontSize: 10)),
                  pw.Text(textMinistereSuite,
                      style: const pw.TextStyle(fontSize: 10)),
                  pw.Divider(),
                  pw.Image(
                      width: 40, height: 40, pw.MemoryImage(logoEntreprise)),
                  pw.Text(textLogo, style: const pw.TextStyle(fontSize: 10)),
                  pw.Text(textLogoSuite,
                      style: const pw.TextStyle(fontSize: 10)),
                  pw.Text(textLogoSuite2,
                      style: const pw.TextStyle(fontSize: 10)),
                ]),
            pw.Expanded(child: pw.Container()),
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(textRepublique,
                      style: const pw.TextStyle(fontSize: 10)),
                  pw.Text(textDeviseCI,
                      style: const pw.TextStyle(fontSize: 10)),
                ])
          ]),

          // pw.Image(width: 40, height: 40, pw.MemoryImage(logoEntreprise)),
          pw.SizedBox(height: 40.0),
          pw.Center(
            child: pw.Text("FICHE DE DEMANDE DE DECAISSEMENT",
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 10.0),
          pw.TableHelper.fromTextArray(
            headers: null,
            columnWidths: {
              0: pw.FixedColumnWidth(130),
              1: pw.FlexColumnWidth()
            },
            //headerStyle: pw.TextStyle(
            //    fontWeight: pw.FontWeight.bold, color: PdfColors.white),
            //headerDecoration: const pw.BoxDecoration(color: PdfColors.teal),
            cellHeight: 35,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              /* 
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
                5: pw.Alignment.centerRight,
                */
            },
            data: infosDemande,
          ),
          pw.TableHelper.fromTextArray(
            headers: null,
            columnWidths: {
              0: pw.FixedColumnWidth(130),
              1: pw.FlexColumnWidth()
            },
            //headerStyle: pw.TextStyle(
            //    fontWeight: pw.FontWeight.bold, color: PdfColors.white),
            //headerDecoration: const pw.BoxDecoration(color: PdfColors.teal),
            cellHeight: 70,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              /* 
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
                5: pw.Alignment.centerRight,
                */
            },
            data: infosVisas,
          ),
          pw.SizedBox(height: 10.0),
          pw.Text(notaBene,
              style:
                  pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
          //pw.SizedBox(height: 30.0),
          pw.Expanded(child: pw.Container()),
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Divider(),
                pw.Text(piedDePage, style: const pw.TextStyle(fontSize: 8)),
                pw.Text(piedDePageSuite,
                    style: const pw.TextStyle(fontSize: 8)),
              ])
        ],
      ),
    );

    return await pdf.save();
  }

  // save Pdf File
  static Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    late final String filePath;
    try {
      if (Platform.isAndroid) {
        final cacheDir = await getApplicationCacheDirectory();
        //final cacheDir = await getDownloadsDirectory();
        filePath = '${cacheDir.path}/$fileName.pdf';
      } else {
        final dir = await getApplicationDocumentsDirectory();
        filePath = '${dir.path}/$fileName.pdf';
      }

      File file = File(filePath);
      await file.writeAsBytes(byteList);
      OpenFile.open(filePath);
    } catch (e, s) {
      Utils.showSuccessMessage(message: 'Bientôt disponible!');
      print(s.toString());
    }
  }

  //print Receipt

  // print Daily report
  static printReport(
    List<DecaissementModel> mvts,
  ) async {
    final dailyReport = await generateReport(mvts);
    savePdfFile('rapport_decaissements', dailyReport);
  }

  static printDemande(DemandeModel demande) async {
    final demandePdf = await generateDocument(demande);
    savePdfFile(demande.docId!, demandePdf);
  }
}
