import 'networking.dart';

final url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=';
final lookUpUrl = 'https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=';

// making this request will take an unpredictably long amount of time
class Cocktail {
  // We have to return a 'Future' - which is like a receipt for what we *will* receive, once this method has completed
  // The result doesn't exist right now, but when it receives its response, the Future becomes a real piece of data
  Future<dynamic> cocktailSearch(dynamic cocktail) async {
    NetworkHelper networkHelper = NetworkHelper(
      // we pass in our cocktail name when we call this method, and append it to our url
      '$url$cocktail',
    );
    // we *need* to await here, no point in allowing this method to return before our networkHelper has received its data from the API
    var cocktails = await networkHelper.getData();
    return cocktails;
  }

  Future<dynamic> specificCocktailSearch(dynamic id) async {
    NetworkHelper networkHelper = NetworkHelper(
      // we pass in our cocktail name when we call this method, and append it to our url
      '$lookUpUrl$id',
    );
    // we *need* to await here, no point in allowing this method to return before our networkHelper has received its data from the API
    var cocktail = await networkHelper.getData();
    return cocktail;
  }
}
