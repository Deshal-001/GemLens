import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gemlens_frontend/components/bottomNavigationBar.dart';
import 'package:gemlens_frontend/components/gemStone.dart';
import 'package:gemlens_frontend/components/menuButton.dart';
import 'package:gemlens_frontend/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' as rive;


class MenuPage extends StatefulWidget {
  final Function(int) onMenuTap;

  const MenuPage({ required this.onMenuTap}) : super();

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: CustomBottomNavigationBar(index: 0,),
      backgroundColor: Colors.white, // Changed background color to white
      appBar:  AppBar(
       // backgroundColor: Colors.white, // Changed AppBar color to white
        elevation: 0,
        title: Text(
          "GemLens",
          style: GoogleFonts.dmSerifDisplay(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Changed text color to black
          ),
        ),
      ),
      body: Container(


        child: Stack(
          children: [
            const Positioned.fill(
                child: rive.RiveAnimation.asset('assets/icons/shapes.riv'),
              ),

              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              // Content
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[
                  Padding(
            padding: const EdgeInsets.only(bottom: 15),
                    child: MenuButton(
                      text: "Scan Gemstones",
                      onTap: () {
                        widget.onMenuTap(1); // 5 is the index of ScanImagePage in the _children list
                      },
                      icon: Icons.camera_alt,
                      color: primaryColor, // Changed button color to blue
                    ),
                  ),
                  Padding(
            padding: const EdgeInsets.only(bottom: 15),
                    child: MenuButton(
                      text: "GemStone Search ",
                      onTap: () {
                        widget.onMenuTap(2); // 5 is the index of ScanImagePage in the _children list
                      },
                      icon: Icons.search,
                      color: primaryColor, // Changed button color to blue
                    ),
                  ),
                  Padding(
            padding: const EdgeInsets.only(bottom: 15),
                    child: MenuButton(
                      text: "Help and Support",
                      onTap: () {
                        widget.onMenuTap(3); // 5 is the index of ScanImagePage in the _children list
                      },
                      icon: Icons.help,
                      color: primaryColor, // Changed button color to blue
                    ),
                  ),
                  Padding(
            padding: const EdgeInsets.only(bottom: 15),
                    child: MenuButton(
                      text: "About Page",
                      onTap: () {
                        widget.onMenuTap(4); // 5 is the index of ScanImagePage in the _children list
                      },
                      icon: Icons.perm_identity,
                      color: primaryColor, // Changed button color to blue
                    ),
                  ),
            
                  Padding(
            padding: const EdgeInsets.only(bottom: 15),
                    child: MenuButton(
                      text: "Settings",
                      onTap: () {
                        widget.onMenuTap(5); // 5 is the index of ScanImagePage in the _children list
                      },
                      icon: Icons.settings,
                      color: primaryColor, // Changed button color to blue
                    ),
                  ),
                  // Repeat for other MenuButton widgets
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}