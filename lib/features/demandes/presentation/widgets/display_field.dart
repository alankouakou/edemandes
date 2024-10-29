import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DisplayFieldWidget extends StatelessWidget {
  final String title;
  final String text;
  const DisplayFieldWidget(
      {super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        const Gap(5),
        Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child:
                Text(text, maxLines: 10, style: const TextStyle(fontSize: 16))),
      ],
    );
  }
}
