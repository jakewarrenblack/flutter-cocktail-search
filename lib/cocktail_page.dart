import 'package:cocktail_search/cocktail.dart';
import 'package:flutter/material.dart';

class CocktailPage extends StatefulWidget {
  CocktailPage({this.cocktails});
  final cocktails;

  @override
  _CocktailPageState createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
  Cocktail cocktail = Cocktail();
  var cocktails;
  var ingredient;
  String title = '';
  String url = '';
  List<Column> cocktailItems = [];

  @override
  void initState() {
    super.initState();
    // get a hold of the ingredient via the State
    ingredient = widget.cocktails;
    getCocktail();
  }

  void getCocktail() async {
    if (ingredient != null) {
      cocktails = await cocktail.cocktailSearch(ingredient);

      // TODO: try loop
      var cocktailList = cocktails['drinks'];
      for (var i = 0; i < cocktailList.length; i++) {
        print(cocktailList[i]['strDrink']);
        print('------------');
        print(cocktailList[i]['strDrinkThumb']);
      }
      //iterateJson(cocktailData);
      updateUI(cocktails);
    }
  }

  void updateUI(dynamic cocktailData) {
    setState(() {
      if (cocktailData == null) {
        title = 'Unable to fetch data';
        url = 'Unable to fetch data';
      } else {
        title = cocktailData['drinks'][0]['strDrink'];
        url = cocktailData['drinks'][0]['strDrinkThumb'];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: newCard(),
    ));

    // return Column(
    //   children: newCard(),
    // );
  }

  List<Column> newCard() {
    ListView myList;
    var cocktailList = cocktails['drinks'];
    for (int i = 0; i < cocktailList.length; i++) {
      String title = cocktailList[i]['strDrink'];
      String url = cocktailList[i]['strDrinkThumb'];
      var newItem = Column(
        children: <Widget>[
          Center(
            child: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold)),
          ),
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
