// once we've reached this page, we know we have our data from the API
// the data is passed from the loading_screen through the navigator

import 'package:flutter/material.dart';
import 'home.dart';
import 'constants.dart';
import 'loading_screen.dart';

class CocktailPage extends StatefulWidget {
  // set singlePage to false by default
  CocktailPage({this.cocktails, this.ingredient, this.singlePage = false});
  final cocktails;
  final ingredient;
  // Used as a boolean to know whether we're viewing all the cocktails, or a single cocktail
  final singlePage;

  @override
  _CocktailPageState createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
  var cocktails;
  var ingredient;
  var singlePage;
  var cocktailTitle;
  List<Column> cocktailItems = [];

  @override
  void initState() {
    super.initState();
    // get a hold of the ingredient via the State
    // see lines 18-30 of loading_screen for explanation of why we need to do this
    cocktails = widget.cocktails;
    ingredient = widget.ingredient;
    singlePage = widget.singlePage;
  }

  @override
  Widget build(BuildContext context) {
    if (singlePage) {
      String title = cocktails['drinks'][0]['strDrink'];
      cocktailTitle = title;
    }
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                SizedBox(
                  width: 25.0,
                  child: TextButton(
                    onPressed: () {
                      var count = 0;
                      // this is a 'back' button
                      // we don't use 'Navigator.pop(context)' in this case
                      // because the page previous to this one is actually the loading_screen
                      // instead, push back to the homepage
                      !singlePage
                          ? Navigator.push(
                              context,
                              // context here is a reference to the BuildContext of this Widget
                              MaterialPageRoute(
                                builder: (context) {
                                  return Home();
                                },
                              ),
                            )
                          // if we're looking at a single cocktail and press the 'back' button, we want to be brought back to the cocktail list, so back twice (past the loading screen)
                          : Navigator.popUntil(
                              context,
                              (route) {
                                return count++ == 2;
                              },
                            );
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: !singlePage
                        ? Text(
                            // Set first letter of the ingredient / title to uppercase, then show the rest of the word
                            '${ingredient[0].toUpperCase() + ingredient.substring(1, ingredient.length)}',
                            style: kCocktailStyle,
                            textAlign: TextAlign.start,
                          )
                        : Text(
                            cocktailTitle ?? 'Title not found',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
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
    if (!singlePage) {
      for (int i = 0; i < cocktailList.length; i++) {
        String title = cocktailList[i]['strDrink'];
        String url = cocktailList[i]['strDrinkThumb'];
        String idDrink = cocktailList[i]['idDrink'];
        var newItem = Column(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoadingScreen(ingredient: ingredient, id: idDrink);
                  }));
                },
                child: Column(children: [
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
                ]))

            // Image.network(url),
          ],
        );
        cocktailItems.add(newItem);
      }
      return cocktailItems;
    } else {
      String title = cocktailList[0]['strDrink'];
      cocktailTitle = title;
      String url = cocktailList[0]['strDrinkThumb'];
      String idDrink = cocktailList[0]['idDrink'];
      List<String> ingredientList = [];
      List<String> measureList = [];

      for (var j = 1; j <= 15; j++) {
        if (cocktailList[0]['strIngredient$j'] != null) {
          ingredientList.add(cocktailList[0]['strIngredient$j']);
        }
      }

      for (var j = 1; j <= 15; j++) {
        if (cocktailList[0]['strMeasure$j'] != null) {
          measureList.add(cocktailList[0]['strMeasure$j']);
        }
      }
      var newItem = Column(
        children: <Widget>[
          Column(children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25.0),
                Column(
                  children: [
                    for (var ingredient in ingredientList) Text(ingredient)
                  ],
                ),
                Column(
                  children: [for (var measure in measureList) Text(measure)],
                ),
              ],
            ),
            SizedBox(height: 25.0),
          ])
          // Image.network(url),
        ],
      );

      cocktailItems.add(newItem);

      return cocktailItems;
    }
  }
}
