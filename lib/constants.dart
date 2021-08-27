import 'package:flutter/material.dart';

const kBgImg = 'images/cocktail-bg.jpg';

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
