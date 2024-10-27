import 'package:flutter/material.dart';

class CustomPanel extends StatelessWidget {
  final Color color;
  const CustomPanel({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: double.infinity,
          height: 130,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Container(
                width: 12,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    ListTile(
                        title: const Text('Demande'),
                        subtitle: const Text('Description de la demande'),
                        trailing: Icon(Icons.circle, color: color)),
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0, left: 20.0),
                      child: Divider(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Par D. KOUAKOU'),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Service Achats'),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    )
                  ]))
            ],
          )),
    );
  }
}
