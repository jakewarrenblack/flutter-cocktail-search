import 'networking.dart';

final url = 'https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=';

class Cocktail {
  Future<dynamic> cocktailSearch(dynamic cocktail) async {
    NetworkHelper networkHelper = NetworkHelper(
      '$url$cocktail',
    );

    var cocktails = await networkHelper.getData();

    return cocktails;
  }
}
