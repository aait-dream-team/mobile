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
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        ),
        height: screenHeight * 0.32,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  widget.leg.from,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.leg.routeLongName!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      widget.leg.duration < (60 * 60)
                          ? '${(widget.leg.duration / 60).toStringAsFixed(0)} min'
                          : '${(widget.leg.duration / (60 * 60)).toStringAsFixed(1)} hrs',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(child: Text("${widget.leg.agencyName}")),
              Expanded(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Text("${widget.leg.intermidateStops?.length ?? 0} Stops"),
                    PopupMenuButton(
                        itemBuilder: (context) => widget.leg.intermidateStops!
                            .map((e) => PopupMenuItem(
                                    child: ListTile(
                                  title: Text(e.name),
                                  subtitle: Text(
                                      'Arrival Time ${e.arrivalTime.hour}:${e.arrivalTime.minute}'),
                                )))
                            .toList())
                  ])),
              Expanded(
                child: Text(
                  widget.leg.to,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
