// once we've reached this page, we know we have our data from the API
// the data is passed from the loading_screen through the navigator

import 'dart:collection';

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
  final bool singlePage;

  @override
  _CocktailPageState createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
  var cocktails;
  var ingredient;
  bool singlePage = false;
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
                              color: Colors.blue,
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
      List<String> ingredientList = [];
      List<String> measureList = [];

      // create a list of all the ingredients and measures
      for (var j = 1; j <= 15; j++) {
        if (cocktailList[0]['strIngredient$j'] != null) {
          ingredientList.add(cocktailList[0]['strIngredient$j']);
        }
        if (cocktailList[0]['strMeasure$j'] != null) {
          measureList.add(cocktailList[0]['strMeasure$j']);
        }
      }

      int getLastChar(var list) {
        // the key of each ingredient and measure will look like 'strIngredient1' or 'strMeasure1'
        // we use this method to remove everything from that value but its number, this allows them to be sorted
        return int.parse(list[list.length - 1]);
      }

      List getKeysAndValuesUsingEntries(LinkedHashMap map) {
        List myList = [];

        // looping through each value in the map provided by our jsonDecoded data from the api
        map.entries.forEach((entry) {
          // just get the name of the key without the number at the end
          String entryStr = entry.key.substring(0, entry.key.length - 1);
          if (entryStr == 'strIngredient' || entryStr == 'strMeasure') {
            // now we've made a new list which only contains the keys and values we're interested in
            if (entry.value != null) {
              myList.add(entry);
            }
          }
        });

        // now that we have a list containing only the information that interests us,
        // *and* we have a method to extract their numbers eg strIngredient1, strMeasure1, we can sort them numerically!

        // .sort(a, b) will compare a/b in the list, so compare the key of index 0 and index 1, index 2 and index 3, etc
        myList.sort((a, b) {
          // this means we'll have our ingredients and their corresponding measures displayed in the right order in our GridView

          /* eg:
            vodka - 1oz
            peach schnapps - 0.5oz
            etc
           */

          var res1 = getLastChar(a.key);
          var res2 = getLastChar(b.key);
          return res1.compareTo(res2);
        });

        return myList;
      }

      List ingredientsAndMeasures = getKeysAndValuesUsingEntries(
        cocktailList[0],
      );

      var newItem = Column(
        children: <Widget>[
          Column(children: [
            // We just use SizedBox to create some vertical spacing
            SizedBox(height: 5.0),
            Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(url),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Divider(
                height: 2.0,
                color: Colors.white,
              ),
            ),
            GridView.count(
              physics:
                  NeverScrollableScrollPhysics(), // to disable GridView's scrolling, we have it nested within a ListView which can scroll on its own
              shrinkWrap:
                  true, // prevents infinite size error, also from being nested within a ListView
              crossAxisCount: 2,
              children: List.generate(ingredientsAndMeasures.length, (index) {
                return Center(
                  child: Text('${ingredientsAndMeasures[index].value}',
                      style: TextStyle(fontSize: 24.0)),
                );
              }),
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
