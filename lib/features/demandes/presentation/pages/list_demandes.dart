import 'package:flutter/material.dart';

class ListDemandes extends StatelessWidget {
  const ListDemandes({super.key});
  static Route route() {
    return MaterialPageRoute(builder: (_) => const ListDemandes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Liste des demandes')),
        body: const Center(
          child: Text('Liste des demandes',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54)),
        ));
  }
}
