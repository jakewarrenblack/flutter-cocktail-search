// the 'as http' alias is just to make it obvious the methods we're using are from the http package
// it might be confusing for another person looking at this code who might think we made the 'get' method ourselves
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  // Pass the url when a NetworkHelper is initialised
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    // get returns a response, but it's an async method, so getData must be async, and 'await' the method's resolve
    // v0.13.0 of package:http made any function which accepted Uris or Strings only accept Uris
    // so we use 'get(Uri.parse('example.com'))' instead of just 'get('example.com')
    http.Response response = await http.get(Uri.parse(url));
    // status 200 = OK
    if (response.statusCode == 200) {
      String data = response.body;
      // We don't know the datatype until the decoding is completed, we need a var here
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
