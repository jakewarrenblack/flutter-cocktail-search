import 'package:flutter/material.dart';
import 'cocktail_page.dart';
import 'loading_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var input;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            image: NetworkImage(
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.1802house.com%2Fwp-content%2Fuploads%2F2018%2F06%2Fcocktails-slide.jpg&f=1&nofb=1'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(height: 150.0),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10.0,
                          ),
                        ),
                      ),
                      hintText: "Enter an ingredient e.g. 'vodka'",
                      hintStyle: TextStyle(color: Colors.grey),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      // pass the user input from the textfield to our empty 'input' variable
                      input = value;
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      if (input != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoadingScreen(
                                ingredient: input,
                              );
                            },
                          ),
                        );
                      }
                    },
                    child: Icon(Icons.search, size: 58.0),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
