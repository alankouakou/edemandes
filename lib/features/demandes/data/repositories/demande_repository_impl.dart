import 'package:demandes/core/statuts.dart';
import 'package:demandes/features/demandes/data/data_sources/remote_datasource.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';

import 'package:demandes/features/demandes/domain/entities/demande.dart';
import 'package:demandes/features/demandes/data/repositories/demande_repository.dart';

class DemandeRepositoryImpl implements DemandeRepository {
  final RemoteDatasource remoteDS;

  const DemandeRepositoryImpl(this.remoteDS);

  @override
  Future<void> addNewDemande(Demande demande) async {
    DemandeModel demandeModel = DemandeModel.fromEntity(demande);
    await remoteDS.add(demandeModel);
    //   await sendNotification();
  }

  @override
  Future<int> delete(Demande demande) async {
    if (demande.statut == Statut.created) {
      remoteDS.delete(demande.docId!);
      return 0;
    } else {
      return 1;
    }
  }

  @override
  Future<DemandeModel> fetch(String docId) async {
    final ds = await remoteDS.get(docId);
    return DemandeModel.fromMap(ds as Map<String, dynamic>);
  }

  @override
  Future<List<DemandeModel>> fetchAll() async {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Stream<List<DemandeModel>> fetchByService(String service) async* {
    final list = remoteDS.fetchByService(service).map((e) {
      return e.docs.map((d) => DemandeModel.fromSnapshot(d)).toList();
    });

    yield* list;
  }

  Stream<List<DemandeModel>> fetchAllByService(String service) async* {
    final list = remoteDS.fetchAllByService(service).map((e) {
      return e.docs.map((d) => DemandeModel.fromSnapshot(d)).toList();
    });

    yield* list;
  }

  @override
  Stream<List<DemandeModel>> fetchByStatus(int status) async* {
    final list = remoteDS.fetchByStatus(status).map((e) {
      return e.docs.map((d) => DemandeModel.fromSnapshot(d)).toList();
    });

    yield* list;
  }

  @override
  Future<void> updateDemande(String docId, Demande demande) async {
    final demandeModel = DemandeModel.fromEntity(demande);
    return await remoteDS.edit(docId, demandeModel);
  }

  Stream<List<DemandeModel>> fetchStream() async* {
    final listDemandes = remoteDS.fetchAll().map((e) {
      return e.docs.map((d) => DemandeModel.fromSnapshot(d)).toList();
    });

    yield* listDemandes;
  }

  @override
  Stream<List<DemandeModel>> fetchByUserUid(String userUid) async* {
    final userDemandes = remoteDS
        .fetchByUserUid(userUid)
        .map((e) => e.docs.map((d) => DemandeModel.fromSnapshot(d)).toList());

    yield* userDemandes;
  }

  Future<List<DemandeModel>> getByService(String serviceName) async {
    final serviceDemandes = await remoteDS
        .getByService(serviceName)
        .then((e) => e.docs.map((d) => DemandeModel.fromSnapshot(d)).toList());

    return serviceDemandes;
  }
}
