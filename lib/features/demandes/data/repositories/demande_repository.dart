import 'package:demandes/features/demandes/data/data_sources/remote_datasource.dart';
import 'package:demandes/features/demandes/data/models/demande.dart';

abstract interface class Repository {
  Future<void> addNewDemande(Demande d);
  Future<void> updateDemande(String docId, Demande d);
  Future<Demande> fetch(String docId);
  Future<List<Demande>> fetchByService(String service);
  Future<List<Demande>> fetchByStatus(String status);
  Future<List<Demande>> fetchAll();
  Future<void> delete(String docId);
}

class DemandeRepository implements Repository {
  final RemoteDatasource remoteDS;

  const DemandeRepository(this.remoteDS);

  @override
  Future<void> addNewDemande(Demande demande) async {
    return await remoteDS.add(demande);
  }

  @override
  Future<void> delete(String docId) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Demande> fetch(String docId) async {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  Future<List<Demande>> fetchAll() async {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<List<Demande>> fetchByService(String service) async {
    // TODO: implement fetchByService
    throw UnimplementedError();
  }

  @override
  Future<List<Demande>> fetchByStatus(String status) async {
    // TODO: implement fetchByStatus
    throw UnimplementedError();
  }

  @override
  Future<void> updateDemande(String docId, Demande demande) async {
    return await remoteDS.edit(docId, demande);
  }

  Stream<List<Demande>> fetchStream() async* {
    final listDemandes = remoteDS.fetchAll().map((e) {
      return e.docs.map((d) => Demande.fromSnapshot(d)).toList();
    });

    yield* listDemandes;
  }
}


/*
  final String docId;
  final String id;
  final String objet;
  final double montantPrevisionnel;
  final double montantDepense;
  final DateTime dateCreated;
  final DateTime dateUpdated;
  */