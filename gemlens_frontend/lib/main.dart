import 'package:flutter/material.dart';
import 'package:gemlens_frontend/pages/aboutPage.dart';
import 'package:gemlens_frontend/pages/gemStoneSearch.dart';
import 'package:gemlens_frontend/pages/helpAndSupportPage.dart';
import 'package:gemlens_frontend/pages/scanGemStonePage.dart';
import 'package:gemlens_frontend/pages/settingsPage.dart';
import 'package:gemlens_frontend/themes/theme.dart';

import 'pages/landingPage.dart';
import 'pages/menuPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      //darkTheme: darkTheme,
      home: const LandingPage(),
      routes: {
        '/landing': (context) => const LandingPage(),
        '/menu': (context) => const MenuPage(),
        '/search': (context) => const GemStoneSearchPage(),
        '/about': (context) => const AboutPage(),
        '/settings': (context) => const SettingsPage(),
        '/help': (context) => const HelpAndSupportPage(),
        '/scan':(context) => const ScanImagePage(),
        
        },
        
    );
  }
}


//web
