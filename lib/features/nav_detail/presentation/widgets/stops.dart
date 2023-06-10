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
  bool isMute = false;
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      color: Colors.green,
      height: 90,
      child: ListTile(
        leading: const Icon(
          Icons.store_mall_directory_sharp,
          color: Colors.white,
        ),
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          "Arrival time: ${widget.arrivalTime.minute}",
          style: TextStyle(color: Colors.white),
        ),
        trailing: IconButton(
            onPressed: () async {
              setState(() {
                isMute = !isMute;
                print("object");
              });

              // //your custom configuration
              // await ftts.setLanguage("en-US");
              // await ftts.setSpeechRate(0.5); //speed of speech
              // await ftts.setVolume(1.0); //volume of speech
              // await ftts.setPitch(1); //pitc of sound

              //play text to sp
              // var result =
              //     await ftts.speak("Hello World, this is Flutter Campus.");
              // if (result == 1) {
              //   //speaking

              // } else {
              //   //not speaking
              //   print("Hey I am not speaking");
              // }
            },
            icon: isMute
                ? Icon(
                    Icons.volume_off_rounded,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.volume_down_rounded,
                    color: Colors.white,
                  )),
      ),
    );
  }
}
