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
        height: 252,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "6 Kilo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Expanded(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_forward),
                    Text("Zaspa",style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                trailing: Text("5 min"),
                subtitle: Text("Departure every 7 minutes"),
              ),
            ),
            // SizedBox(
            //   height: 20,
            // ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top:18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("3 stops"), Icon(Icons.arrow_upward_rounded)],
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("Megenagna", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ),
            ),
            Divider()
          ],
        ),
      ),
    );
  }
}
