// TypeAheadField(
//                 suggestionsBoxDecoration: const SuggestionsBoxDecoration(
//                   elevation: 0.00,
//                 ),
//                 textFieldConfiguration: TextFieldConfiguration(
//                     decoration: InputDecoration(
//                   hintText: 'Location',
//                   suffixIcon: IconButton(
//                     // onPressed: .clear,
//                     onPressed: () {
//                       FocusScope.of(context).unfocus();
//                     },
//                     icon: Icon(Icons.clear),
//                   ),
//                   prefixIcon: IconButton(
//                     icon: const Icon(Icons.arrow_back_ios_new),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(40.0),
//                   ),
//                 )),
//                 suggestionsCallback: (pattern) async {
//                   return await [
//                     'ልደታ',
//                     'Stadium',
//                     'Lideta',
//                     '4 ኪሎ',
//                     '6 ኪሎ',
//                     '5 ኪሎ',
//                     'Piyassa',
//                     '4 ኪሎ',
//                     'Kirkos',
//                     'ካዛንችስ',
//                     'ልደታ',
//                     'Stadium',
//                     'Lideta'
//                   ];
//                 },
//                 itemBuilder: (context, suggestion) {
//                   return ListTile(
//                     leading: Icon(Icons.pin_drop),
//                     title: Text(suggestion),
//                     visualDensity: VisualDensity(vertical: 3),
//                   );
//                 },
//                 onSuggestionSelected: (suggestion) {
//                   screenArguments.func(LatLng(4.44, 5.55), suggestion);
//                   Navigator.pop(context);
//                 },
//               )