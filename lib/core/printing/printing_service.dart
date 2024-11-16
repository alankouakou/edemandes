import 'dart:io';
import 'package:demandes/core/utils.dart';
import 'package:demandes/features/budget/data/models/decaissement.dart';
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
      'Date decaissement',
      'Objet',
      'Montant prévisionnel',
      'Montant définitif',
      'Cumul decaisse',
      'Solde'
    ];

    final List<List<String>> mvtDecaissements = decaissements.map((e) {
      return [
        Utils.dateFull.format(e.dateDecaissement),
        e.objetDemande,
        Utils.formatCFA(e.montantPrevisionnel),
        Utils.formatCFA(e.montantDefinitif),
        Utils.formatCFA(e.cumulDecaisse),
        Utils.formatCFA(e.solde)
      ];
    }).toList();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.landscape,
        build: (pw.Context context) {
          return pw.Column(children: [
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
          ]);
        }));
/* 
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context context) {
          return pw.Column(children: [
            pw.Text('MOUVEMENTS DE CAISSE',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 30.0),
            pw.TableHelper.fromTextArray(
                headers: headersMvtCaisse,
                data: [],
                headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.teal),
                cellHeight: 25,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerLeft,
                  3: pw.Alignment.centerRight
                }),
            //pw.TableHelper.fromTextArray(headers:,data: dataPrestations)
          ]);
        }));
/*     print('adding prestations page to the report!');
    print(mvtPrestations); */
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        orientation: pw.PageOrientation.portrait,
        build: (pw.Context ctx) {
          return pw.Column(children: [
            pw.Text('LISTE DECAISSEMENTS',
                style:
                    pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.TableHelper.fromTextArray(
                headers: headers,
                data: [],
                headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, color: PdfColors.white),
                headerDecoration: const pw.BoxDecoration(color: PdfColors.teal),
                cellHeight: 25,
                cellAlignments: {
                  0: pw.Alignment.centerLeft,
                  1: pw.Alignment.centerLeft,
                  2: pw.Alignment.centerLeft,
                  3: pw.Alignment.centerRight
                })
          ]);
        })); */
    print('pdf daily report ends!');
    return pdf.save();
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
}
