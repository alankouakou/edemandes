import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demandes/core/messaging/models/user_token.dart';

class UserTokenRepository {
  final _usersTokensCollection =
      FirebaseFirestore.instance.collection('users_token');
  Future<void> saveUserToken(
      {required String token,
      required String userid,
      required String service}) async {
    await _usersTokensCollection.doc(userid).set({
      'token': token,
      'userid': userid,
      'service': service,
    });
  }

  Future<String> getUserToken(String userid) async {
    const tokenCesar =
        'dJkdtMp4Qpu0RyJs4m6AKH:APA91bErZh1o8bapCDskzjW-_aKqebEDjSAdPE6I9JXwwKVySTK3JUcfXb-yLdPRiYYsvkLfFinPmBKEuHqy0C3oIgAg5stQAFuI8zr_H6BdYdeXGR9uNM8';
    try {
      final usersTokensCollection =
          FirebaseFirestore.instance.collection('users_token');
      final map = await usersTokensCollection
          .where('userid', isEqualTo: userid)
          .get()
          .then((value) {
        return value.docs.first;
      });

      final userToken = UserToken.fromFirestore(map);
      return userToken.token;
    } catch (e) {
      print(e.toString());
      print('recuperation Token échoué! Token: $tokenCesar');
      return tokenCesar;
    }
  }
}
