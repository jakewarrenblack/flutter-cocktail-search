import 'package:cocktail_search/cocktail.dart';
import 'package:flutter/material.dart';
import 'home.dart';

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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Home();
                    }));
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
                Text('Cocktails using $ingredient',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              children: newCard(),
            ),
          ),
        ],
      ),
    ));
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
