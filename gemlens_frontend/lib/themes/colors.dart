import 'package:flutter/material.dart';

var primaryColor = Color.fromARGB(255, 57, 57, 157); // Deep Sky Blue

var backgroundStyle = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColor,
      Color(0xFF1E90FF), // Dodger Blue
      Color(0xFF4169E1), // Royal Blue
      Color(0xFF0000CD), // Medium Blue
      Color(0xFF00008B), // Dark Blue
    ],
  ),
);