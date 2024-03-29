import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:gemlens_frontend/components/menuButton.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(index: 0,),
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: Icon(Icons.menu),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "GemLens",
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(216, 23, 23, 0.78),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
              child: Image.asset(
                'assets/icons/backgroundAnime.gif', // Replace 'assets/background.gif' with the path to your GIF file
                fit: BoxFit.cover,
              ),
            ),),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.white.withOpacity(0.5),
                ),
              
              ),
            ),
         Container(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                MenuButton(
                  text: "Scan Gemstones",
                  onTap: () {
                    Navigator.pushNamed(context, '/scan');
                  },
                  icon: Icons.camera_alt,
                ),
                const SizedBox(height: 20),
                MenuButton(
                  text: "Gemstones",
                  onTap: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  icon: Icons.emoji_objects,
                ),
                const SizedBox(height: 20),
                MenuButton(
                  text: "About",
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  icon: Icons.info,
                ),
                const SizedBox(height: 20),
                MenuButton(
                  text: "Help & Support",
                  onTap: () {
                    Navigator.pushNamed(context, '/help');
                  },
                  icon: Icons.help,
                ),
                const SizedBox(height: 20),
                MenuButton(
                  text: "Settings",
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  icon: Icons.settings,
                ),
                Expanded(
                  child: Container(), // Placeholder for bottom navigation bar
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

