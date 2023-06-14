import 'package:bus_navigation/core/text_to_speech/tts.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

class Stops extends StatefulWidget {
  final String title;
  final DateTime arrivalTime;
  const Stops({super.key, required this.title, required this.arrivalTime});

  @override
  State<Stops> createState() => _StopsState();
}

class _StopsState extends State<Stops> {
  // FlutterTts ftts = FlutterTts();
  bool isMute = TextToSpeechSingleton().soundEnabled;
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      color: Colors.green,
      height: 90,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListTile(
          leading: const Icon(
            Icons.train_sharp,
            color: Colors.white,
          ),
          title: Text(
            widget.title,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "Arrival Time: ${widget.arrivalTime.hour}:${widget.arrivalTime.minute}",
            style: const TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
              onPressed: () async {
                setState(() {
                  isMute = !isMute;
                  TextToSpeechSingleton().soundEnabled = isMute;
                });
              },
              icon: isMute
                  ? const Icon(
                      Icons.volume_off_rounded,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.volume_down_rounded,
                      color: Colors.white,
                    )),
        ),
      ),
    );
  }
}
