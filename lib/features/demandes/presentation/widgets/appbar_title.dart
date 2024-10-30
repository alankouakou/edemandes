import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueGrey,
        child: Icon(Icons.person, color: Colors.white),
      ),
      title: Text('Bonjour',
          style: TextStyle(fontSize: 14, color: Colors.black54)),
      subtitle: Text(
        'Charles K.',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
