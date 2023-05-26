import 'package:flutter/material.dart';

import '../../model/nav_detail_model.dart';

class Detail extends StatefulWidget {
  final Leg leg;
  const Detail({super.key, required this.leg});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 252,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.leg.from,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Expanded(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_forward),
                    Text(
                      "Zaspa",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                trailing: Text("5 min"),
                subtitle: Text("Departure every 7 minutes"),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("3 stops"), Icon(Icons.arrow_upward_rounded)],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  widget.leg.to,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
