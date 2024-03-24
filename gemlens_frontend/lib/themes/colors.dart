import 'package:flutter/material.dart';

var primaryColor = const Color.fromARGB(255, 156, 15, 15).withOpacity(0.9);

var backgroundStyle = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColor,
      primaryColor,
      Color.fromARGB(255, 246, 73, 73),
      Color.fromARGB(255, 246, 73, 73),
      Color.fromARGB(255, 246, 73, 73),
      Colors.white,
    ],
  ),
);

var backgroundStyle2 = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColor,
            primaryColor,

      Color.fromARGB(255, 246, 73, 73),
            Color.fromARGB(255, 246, 73, 73),
            

      Colors.white70,
      
    ],
  ),
);
