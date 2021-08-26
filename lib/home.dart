// the first page we see when the app runs, because main.dart's MaterialApp has a 'home' property of 'Home()', this Widget

import 'package:flutter/material.dart';
import 'cocktail_page.dart';
import 'loading_screen.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // we'll pass our user input in here
  var input;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
            image: NetworkImage(kBgImg),
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
                    decoration: kInputDecoration,
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
                        // 'push' this route onto the Navigator
                        // in the same way, this route can be 'popped' off from the navigator, it acts like a stack
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // the context here refers to this widget's BuildContext
                            builder: (context) {
                              return LoadingScreen(
                                // passing our input text through to the LoadingScreen, the LoadingScreen Widget can access this through its State
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
