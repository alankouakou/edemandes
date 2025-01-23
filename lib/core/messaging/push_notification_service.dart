import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class PushNotificationService {
  static getAccessToken() async {
    return '';
  }

  static sendNotification(
      {required String deviceToken, required String content}) async {
    try {
      final String serverAccessToken = await getAccessToken();
      String endPointFirebaseCloudMessaging =
          'https://fcm.googleapis.com/v1/projects/edemandes-225ce/messages:send';
      final Map<String, dynamic> message = {
        'message': {
          'token': deviceToken,
          'notification': {
            'title': 'Nouvelle demande',
            'body': 'Vous avez une demande en attente de traitement!',
          },
          'data': {
            'message': content,
          }
        }
      };

      final http.Response response = await http.post(
        Uri.parse(endPointFirebaseCloudMessaging),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverAccessToken',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print(
            'Failed to send notification. status code: ${response.statusCode} \n body: ${response.body}');
      }
    } catch (e) {
      print('*** Détails de l\'exception: ${e.toString()} ***');
    }
  }
}
