import 'package:flutter/material.dart';
import 'cocktail_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'cocktail.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({this.ingredient});

  final ingredient;

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getCocktails(widget.ingredient);
  }

  void getCocktails(String ingredient) async {
    var cocktails = await Cocktail().cocktailSearch(ingredient);

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CocktailPage(
        // passing jsonDecoded cocktail data
        cocktails: cocktails,
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
