import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'screen_arguments.dart';
import 'choose_from_map.dart';
class SearchPage extends StatefulWidget {
  static const String route = "/SearchRoute";
  final ScreenArguments screenArguments;
  const SearchPage({super.key, required this.screenArguments});

  @override
  State<SearchPage> createState() => _SearchWidget(screenArguments: this.screenArguments);
}

class _SearchWidget extends State<SearchPage> {
  final  ScreenArguments screenArguments;

  _SearchWidget({required this.screenArguments});
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    // print(args.name);
    print(screenArguments);
    // print(screenArguments.name);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 45, 10, 0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField(
                suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                  elevation: 0.00,
                ),
                textFieldConfiguration: TextFieldConfiguration(
                    decoration: InputDecoration(
                  hintText: 'Location',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                )),
                suggestionsCallback: (pattern) async {
                  return await ['ልደታ', 'Stadium', 'Lideta', '4 ኪሎ', '6 ኪሎ', '5 ኪሎ','Piyassa', '4 ኪሎ','Kirkos', 'ካዛንችስ','ልደታ', 'Stadium', 'Lideta']; 
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.pin_drop),
                    title: Text(suggestion),
                    visualDensity: VisualDensity(vertical: 3),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  screenArguments.func(suggestion);
                  Navigator.pop(context);
                },
              ),
            ),
            Divider(
              thickness: 0.3,
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      
                      onPressed: () {
                        Navigator.of(context).pushNamed(MapPage.route, arguments: screenArguments);
                      },
                      icon: Icon(Icons.map,
                          color: Colors.grey[700]), // lighter icon color
                      label: Text('Select on Map',
                          style: TextStyle(
                              color: Colors.grey[700])), // lighter text color
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue.withOpacity(0.1),
                          shadowColor: Colors.lightBlue.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(
                                color: Colors.lightBlue.withOpacity(0.2),
                              ))), // lighter border color with radius 40
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.my_location,
                          color: Colors.grey[700]), // lighter icon color
                      label: Text('Use Current Location',
                          style: TextStyle(
                              color: Colors.grey[700])), // lighter text color
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlue.withOpacity(0.1),
                          shadowColor: Colors.lightBlue.withOpacity(0.2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                              side: BorderSide(
                                color: Colors.lightBlue.withOpacity(0.2),
                              ))), // lighter border color with radius 40
                    ),
                  ),
                ),
              ],
            ),
            Row(children: <Widget>[
              Expanded(child: Divider()),
              Text("Recent"),
              Expanded(child: Divider()),
            ]),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(color: Colors.grey[300]), // lighter divider color
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      screenArguments.func('Location $index');
                      Navigator.pop(context);
                    },
                    leading:
                        Icon(Icons.location_on_outlined), // location pin icon
                    title: Text('Location $index'), // title of the suggestion
                    subtitle:
                        Text('Subtitle $index'), // subtitle of the suggestion
                    trailing: Icon(Icons
                        .copy), // copy icon at the most left side of the row
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
