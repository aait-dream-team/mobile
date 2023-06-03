import 'package:flutter/material.dart';

import '../../model/nav_detail_model.dart';

class Detail extends StatefulWidget {
  final Leg leg;
  final int index;
  final int currentIndex;
  // final Color color;
  const Detail({super.key, required this.leg, required this.index,required this.currentIndex});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    BoxDecoration decoration;
    if (widget.index > widget.currentIndex){
      decoration = const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        );
    }
    else if(widget.index < widget.currentIndex){
      decoration = const BoxDecoration(
          color: Colors.grey,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        );
    }
    else{
      decoration = const BoxDecoration(
          color: Colors.green,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.grey),
          ),
        );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        decoration: decoration,
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '${widget.leg.duration} min',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(child: Text("${widget.leg.agencyName}")),
              Expanded(
                  // TODO(Biruk) : don't hard code this.
                  child: Text("5 Stops")),
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
