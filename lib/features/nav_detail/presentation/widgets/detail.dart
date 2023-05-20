import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "6 Kilo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text("Zaspa"),
              leading: Icon(Icons.arrow_forward),
              trailing: Text("5 min"),
              subtitle: Text("Departure every 7 minutes"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text("3 stops"),
              Icon(Icons.arrow_upward_rounded)
            ],)
          ],
        ),
      ),
    );
  }
}