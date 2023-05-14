import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class FloatingSearchBarWidget extends StatelessWidget {
  const FloatingSearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: 0.0,
      openAxisAlignment: 0.0,
      width: 600,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.place),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 70,
                    child: Center(
                      child: Text("Search Suggestions"),
                    )),
                Divider(),
                SizedBox(
                    height: 70,
                    child: Center(
                      child: Text("Search Suggestions"),
                    )),
                Divider(
                  thickness: 5,
                ),
                SizedBox(
                    height: 70,
                    child: Center(
                      child: Text("Past Favorites"),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
