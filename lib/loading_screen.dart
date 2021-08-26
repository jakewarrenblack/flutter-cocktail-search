// making a request to our API can take some time, so we pass the user input through to the loading screen rather than directly on to the cocktail_page

import 'package:flutter/material.dart';
import 'cocktail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'cocktail.dart';

class LoadingScreen extends StatefulWidget {
  // we pass data forward through our routes by adding it as a property to our widget
  // the ingredient from the input box is now received from home.dart
  LoadingScreen({this.ingredient});
  final ingredient;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  // this State object knows which StatefulWidget it belongs to
  // this State's 'widget' property is linked to its parent StatefulWidget
  // we take advantage of this to access the properties of the StatefulWidget
  // in this case, our ingredient!

  // initState is only called *one* time, when this Widget is initialised
  // In contrast, the Widget's 'Build' method is called any time something changes in the UI
  void initState() {
    // so now on initState(), before the widget is built, we can pass our data from the homescreen ot the loading_screen
    super.initState();
    getCocktails(widget.ingredient);
  }

  void getCocktails(String ingredient) async {
    // Cocktail.cocktailSearch() is an asynchronous method, it would allow other code to run while it waits
    // but we *need* the data it returns
    // in this case, we use the 'await' keyword and 'async' modifier to make everything wait until cocktailSearch is finished
    var cocktails = await Cocktail().cocktailSearch(ingredient);

    // 'await' has now made sure that the cocktailSearch() has finished
    // we know at this point that we have our data, so we're ready to 'push' the next page onto the Navigator's 'stack'
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CocktailPage(
        // passing jsonDecoded cocktail data
        // we've added 'cocktails' and 'ingredient' as attributes of CocktailPage to allow passing data through the Navigator
        cocktails: cocktails,
        ingredient: ingredient,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    // loading indicator is necessary
    // fetching weather data takes some time
    return Scaffold(
      body: Center(
        child: SpinKitRing(
          color: Colors.red,
          size: 100.0,
        ),
      ),
    );
  }
}
