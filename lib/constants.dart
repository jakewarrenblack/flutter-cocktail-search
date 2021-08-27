import 'package:flutter/material.dart';

const kBgImg =
    'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.1802house.com%2Fwp-content%2Fuploads%2F2018%2F06%2Fcocktails-slide.jpg&f=1&nofb=1';

const kInputDecoration = InputDecoration(
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
);

const kCocktailStyle = TextStyle(
  color: Colors.blue,
  fontSize: 28.0,
  fontWeight: FontWeight.bold,
);
