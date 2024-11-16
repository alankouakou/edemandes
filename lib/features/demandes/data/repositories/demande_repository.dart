import 'package:demandes/features/demandes/data/data_sources/remote_datasource.dart';
import 'package:demandes/features/demandes/data/models/demande_model.dart';

abstract interface class Repository {
  Future<void> addNewDemande(DemandeModel d);
  Future<void> updateDemande(String docId, DemandeModel d);
  Future<DemandeModel> fetch(String docId);
  Stream<List<DemandeModel>> fetchByService(String service);
  Stream<List<DemandeModel>> fetchByStatus(int status);
  Future<List<DemandeModel>> fetchByUserUid(String userUid);
  Future<List<DemandeModel>> fetchAll();
  Future<void> delete(String docId);
}

class DemandeRepository implements Repository {
  final RemoteDatasource remoteDS;

  const DemandeRepository(this.remoteDS);

  @override
  Future<void> addNewDemande(DemandeModel demande) async {
    return await remoteDS.add(demande);
  }

  @override
  Future<void> delete(String docId) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<DemandeModel> fetch(String docId) async {
    // TODO: implement fetch
    throw UnimplementedError();
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
  Future<void> updateDemande(String docId, DemandeModel demande) async {
    return await remoteDS.edit(docId, demande);
  }

  Stream<List<DemandeModel>> fetchStream() async* {
    final listDemandes = remoteDS.fetchAll().map((e) {
      return e.docs.map((d) => DemandeModel.fromSnapshot(d)).toList();
    });

    yield* listDemandes;
  }

  @override
  Future<List<DemandeModel>> fetchByUserUid(String userUid) async {
    final userDemandes = await remoteDS
        .fetchByUserUid(userUid)
        .then((e) => e.docs.map((d) => DemandeModel.fromSnapshot(d)).toList());

    return userDemandes;
  }

  Future<List<DemandeModel>> getByService(String serviceName) async {
    final serviceDemandes = await remoteDS
        .getByService(serviceName)
        .then((e) => e.docs.map((d) => DemandeModel.fromSnapshot(d)).toList());

    return serviceDemandes;
  }
}
