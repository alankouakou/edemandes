import 'package:demandes/features/demandes/presentation/widgets/appbar_title.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NotificationScreen extends StatelessWidget {
  final RemoteMessage message;
  const NotificationScreen({super.key, required this.message});

  static Route route(RemoteMessage message) {
    return MaterialPageRoute(
      builder: (context) => NotificationScreen(message: message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('${message.notification?.title}')),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Gap(30),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      'Notification title ${message.notification?.title}')),
              const Gap(20),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Text('Notification body ${message.notification?.body}')),
              const Gap(20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Fermer'))
            ],
          ),
        ));
  }
}
