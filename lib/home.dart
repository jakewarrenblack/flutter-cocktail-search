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
      appBar: AppBar(
        title: Center(child: Text('Cocktail Search')),
      ),
      body: Container(
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
    );
  }
}
