// a helper class for making a request to our API and decoding its response as JSON

// the 'as http' alias is just to make it obvious the methods we're using are from the http package
// it might be confusing for another person looking at this code who might think we made the 'get' method ourselves
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  // Pass the url when a NetworkHelper is initialised
  NetworkHelper(this.url);

  final String url;

  // Future = a promise to receive some data, a representation of what we will receive
  Future getData() async {
    // get returns a response, but it's an async method, so getData must be async, and 'await' the method's resolve
    // v0.13.0 of package:http made any function which accepted Uris or Strings only accept Uris
    // so we use 'get(Uri.parse('example.com'))' instead of just 'get('example.com')

    // await = 'wait for the Future to be resolved (receive its data) before continuing, we *need* this response before we do anything else
    http.Response response = await http
        .get(Uri.parse(url))
        .timeout(Duration(seconds: 3), onTimeout: () {
      return http.Response('Connection timed out.', 500);
    });
    // status 200 = OK
    if (response.statusCode == 200 && response.body != "") {
      String data = response.body;
      // take the string we got from the server and turn it into a json object
      return jsonDecode(data);
    } else {
      return 'Something went wrong.';
    }
  }
}
