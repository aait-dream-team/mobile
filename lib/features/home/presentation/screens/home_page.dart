import 'package:bus_navigation/features/home/presentation/widgets/floating_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../widgets/map_widget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:getwidget/getwidget.dart';
class HomeWidget extends StatefulWidget {
  static const String route = "/home";

  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
  final String? api_key = dotenv.env['API_KEY'];
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.expand, children: [
      MapWidget(),
      Column(
        children:[ 
          SizedBox(
            height: 70,
          ),
          GooglePlaceAutoCompleteTextField(
            textEditingController: controller,
            googleAPIKey: api_key!,
            inputDecoration: InputDecoration(
              hintText: 'Location',
              suffixIcon: IconButton(
                // onPressed: .clear,
                onPressed: () {
                  controller.clear();
                },
                icon: const Icon(Icons.clear),
              ),
              prefixIcon: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
            debounceTime: 800, // default 600 ms,
            countries: const ['et'], // optional by default null is set
            isLatLngRequired:
                true, // if you required coordinates from place detail
            getPlaceDetailWithLatLng: (Prediction prediction) {
              // this method will return latlng with place detail
              //   screenArguments.func(
              //       LatLng(double.parse(prediction.lat.toString()),
              //           double.parse(prediction.lng.toString())),
              //       prediction.description);
              // }, // this callback is called when isLatLngRequired is true
              // itmClick: (Prediction prediction) {
              //   controller.text = prediction.description!;
              //   controller.selection = TextSelection.fromPosition(
              //       TextPosition(offset: prediction.description!.length));
              //   Navigator.pop(context);
            }),]
      ),

      // FloatingSearchBarWidget()
    ]);
  }
}
