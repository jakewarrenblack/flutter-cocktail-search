// once we've reached this page, we know we have our data from the API
// the data is passed from the loading_screen through the navigator

import 'package:flutter/material.dart';
import 'home.dart';
import 'constants.dart';

class CocktailPage extends StatefulWidget {
  CocktailPage({this.cocktails, this.ingredient});
  final cocktails;
  final ingredient;

  @override
  _CocktailPageState createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
  var cocktails;
  var ingredient;
  List<Column> cocktailItems = [];

  @override
  void initState() {
    super.initState();
    // get a hold of the ingredient via the State
    // see lines 18-30 of loading_screen for explanation of why we need to do this
    cocktails = widget.cocktails;
    ingredient = widget.ingredient;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    // this is a 'back' button
                    // we don't use 'Navigator.pop(context)' in this case
                    // because the page previous to this one is actually the loading_screen
                    // instead, push back to the homepage
                    Navigator.push(context,
                        // context here is a reference to the BuildContext of this Widget
                        MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
                Text(
                  'Cocktails using $ingredient',
                  style: kCocktailStyle,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          Expanded(
            // ListView is the ideal Widget here, it allows for scrolling
            // We might have 100 cocktails from our api
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              // the newCard() method will take our data, loop through it,
              // and create a list of Widgets to be used as the children of our ListView
              children: newCard(),
            ),
          ),
        ],
      ),
    ));
  }

  // We're using this method to loop through our cocktails
  // We first create our list, cocktailItems[], as a global variable
  // We loop through the data, inserting each nth value into a Column widget
  // Finally, we add each newly created widget into our list, and return the list
  List<Column> newCard() {
    var cocktailList = cocktails['drinks'];
    for (int i = 0; i < cocktailList.length; i++) {
      String title = cocktailList[i]['strDrink'];
      String url = cocktailList[i]['strDrinkThumb'];
      var newItem = Column(
        children: <Widget>[
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // We just use SizedBox to create some vertical spacing
          SizedBox(height: 15.0),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(url),
                )),
          ),
          SizedBox(height: 25.0),
          // Image.network(url),
        ],
      );
      cocktailItems.add(newItem);
    }
    return cocktailItems;
  }
}
